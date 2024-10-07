require('dotenv').config();
const express = require('express');
const http = require('http');
const { Server } = require('socket.io');
const connectDB = require('./db/mongo_db');
const RoomModel = require('./models/room_model');

const app = express();

const server = http.createServer(app);
const io = new Server(server);

// Socket Service
io.on('connection', (socket) => {
    console.log('A user is connected:', socket.id);
    // Room Create
    socket.on('createRoom', async ({ nickname }) => {
        try {
            await RoomModel.deleteMany({});
            // console.log('All rooms deleted');
            // console.log('createRoom', nickname);
            let room = new RoomModel();
            const player = {
                nickname: nickname,
                socketId: socket.id,
                playerType: 'X'
            };
            room.players.push(player);
            room.turn = player;
            room.roomID = socket.id;
            room.winner = null;
            room = await room.save();
            const roomId = room._id.toString().substring(0, 10);
            console.log('room id:', roomId);
            room.roomID = roomId;
            room.save();
            socket.join(roomId);
            socket.emit('roomCreatedSuccess', room);
        } catch (error) {
            console.log('Error', error);
            socket.emit('errorOccurred', error.message);
        }
    });

    socket.on('joinRoom', async ({ roomId, nickname }) => {

        try {
            console.log('joinRoom', roomId, nickname);

            if (!roomId.match(/^[0-9a-fA-F]{10}$/)) {
                socket.emit('errorOccurred', 'Please enter a valid room ID');
                return;
            }
            let room = await RoomModel.find({ roomID: roomId });
            room = room[0];
            // console.log('Room:', room);
            if (!room) {
                socket.emit('errorOccurred', 'Room not found');
                return;
            }

            if (room.players.length === room.occupancy) {
                socket.emit('errorOccurred', 'Room is full');
                return;
            }
            if (room.isJoined) {
                // socket.emit('errorOccurred', 'Room is already joined');
                const player = {
                    nickname: nickname,
                    socketId: socket.id,
                    playerType: 'O'
                };
                room.players.push(player);
                socket.join(roomId);
                room.isJoined = false;
                room = await room.save();

                io.to(roomId).emit('roomJoinedSuccess', room);
                io.to(roomId).emit('updatePlayers', room.players);
                io.to(roomId).emit('gameStarted', room);
            }

        } catch (error) {
            console.log(error);
            socket.emit('errorOccurred', error.message);
        }

    });
    socket.on('tapGrid', async ({ roomId, index }) => {
        try {
            console.log('tapGrid', roomId, index);
            let room = await RoomModel.find({ roomID: roomId });
            room = room[0];
            if (!room) {
                socket.emit('errorOccurred', 'Room not found');
                return;
            }
            if (room.winner) {
                socket.emit('errorOccurred', 'Game is over');
                return;
            }

            let choice = room.turn.playerType;
            if (room.turnIndex === 0) {
                room.turn = room.players[1];
                room.turnIndex = 1;
            } else {
                room.turn = room.players[0];
                room.turnIndex = 0;
            }
            room = await room.save();
            io.to(roomId).emit('updateGame', {
                room: room,
                index: index,
                choice: choice
            });
        } catch (error) {
            console.log(error);
            socket.emit('errorOccurred', error.message);
        }
    });

    socket.on('winner', async ({ roomID, winnerSocketID, socketID }) => {
        try {
            console.log('winner', roomID, winnerSocketID);
            let room = await RoomModel.find({ roomID: roomID });
            room = room[0];
            let winner = room.players.find(player => player.socketId === winnerSocketID && player.socketId === socketID);
            if (!room) {
                socket.emit('errorOccurred', 'Room not found');
                return;
            }
            console.log('Winner:', winner);
            if (winner) {
                winner.points += 1;
                room.currentRound += 1;
                room = await room.save();

                console.log('Current Round:', room.currentRound);
                console.log('Max Rounds:', room.maxRounds);
            }


            if (room.currentRound >= room.maxRounds) {
                let allTimeWinner = room.players[0].points > room.players[1].points ? room.players[0] : room.players[1];
                io.to(roomID).emit('endGame', allTimeWinner);
            } else {
                io.to(roomID).emit('pointsIncrease', { winner: winner, room: room });
            }


        } catch (error) {
            console.log(error);
            socket.emit('errorOccurred', error.message);
        }
    });

    socket.on('disconnect', () => {
        console.log('User disconnected:', socket.id);
    });
});
// Middleware
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static('public'));



// Start the server
const port = process.env.PORT || 3000;

const start = async () => {
    try {
        await connectDB(process.env.MONGO_DB_CONNECTION_STRING).then(() => {
            console.log('Connected to DB');
            server.listen(port, '0.0.0.0', () => {
                console.log(`Server is running on http://localhost:${port}\n`);
            });
        });
    } catch (error) {
        console.error(error.message);
    }

}
start();
