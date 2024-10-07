const express = require('express');
const http = require('http');
const { Server } = require('socket.io');

const app = express();

const server = http.createServer(app);
const io = new Server(server);

io.on('connection', (socket) => {
    console.log('A user connected: ' + socket.id);

    // Handle creating a room
    socket.on('createRoom', ({ roomId }) => {
        console.log(`${socket.id} created room ${roomId}`);
        socket.join(roomId);  // The user creates and joins the room
        socket.emit('roomCreated', { roomId }); // Acknowledge the room creation
    });

    // Handle joining a room
    socket.on('joinRoom', ({ roomId }) => {
        const room = io.sockets.adapter.rooms.get(roomId);

        // Check if the room exists

        if (room) {
            console.log(`${socket.id} joined room ${roomId}`);
            socket.join(roomId);
            socket.emit('roomJoined', { roomId }); // Acknowledge the room join
            io.to(roomId).emit('playerJoined', { roomId, playerId: socket.id });
            io.to(roomId).emit('startGame', { roomId });
        } else {
            socket.emit('error', { message: 'Room does not exist!' });
        }
    });

    socket.on('disconnect', () => {
        console.log('A user disconnected: ' + socket.id);
    });
});

server.listen(3000, () => {
    console.log('Server is running on port 3000');
});
