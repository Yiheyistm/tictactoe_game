const mongoose = require('mongoose');

const playerSchema = new mongoose.Schema({
    nickname: {
        type: String,
        required: true,
        trim: true
    },
    socketId: {
        type: String,
        required: true
    },
    points: {
        type: Number,
        default: 0
    },
    playerType: {
        type: String,
        required: true
    }
});

module.exports = playerSchema;