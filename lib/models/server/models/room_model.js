const mongoose = require('mongoose');
const player = require('./player_model');

const roomSchema = new mongoose.Schema({
    roomID: {
        type: String,
        required: true,
        unique: true,
    },
    occupancy: {
        type: Number,
        default: 2
    },
    maxRounds: {
        type: Number,
        default: 3
    },
    currentRound: {
        type: Number,
        default: 1,
        required: true
    },
    players: [player],
    isJoined: {
        type: Boolean,
        default: true,
    },
    turn: player,
    turnIndex: {
        type: Number,
        default: 0
    },
    winner: player,
});

const Room = mongoose.model('Room', roomSchema);
module.exports = Room;