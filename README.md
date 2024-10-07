# TicTacToe Game

This is a real-time multiplayer TicTacToe game built with Flutter for the frontend and Node.js with Socket.IO for the backend.

## Table of Contents

- [Features](#Features)
- [Installation](#installation)
- [Usage](#usage)
- [Demo Images](#demo-images)
- [Contributing](#contributing)
- [License](#license)

## Features

- Real-time multiplayer gameplay
- Room creation and joining
- Scoreboard updates
- Game state synchronization
- Winner announcement

## Installation

### Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install)
- [Node.js](https://nodejs.org/en/download/)
- [MongoDB](https://www.mongodb.com/try/download/community)

### Backend Setup

1. Navigate to the backend directory:

    ```sh
    cd lib/server
    ```

2. Install the dependencies:

    ```sh
    npm install
    ```

3. Create a `.env` file in the `lib/server` directory and add your MongoDB connection string:

    ```env
    MONGO_DB_CONNECTION_STRING=your_mongodb_connection_string
    ```

4. Start the server:

    ```sh
    node index.js
    ```

### Frontend Setup

1. Navigate to the Flutter project root directory:

    ```sh
    cd ../../../../../../tictactoe_game
    ```

2. Get the Flutter dependencies:

    ```sh
    flutter pub get
    ```

3. Run the app:

    ```sh
    flutter run
    ```

## Usage

1. Open the app on two different devices or emulators.
2. Create a room on one device by entering a nickname and clicking "Create Room".
3. Join the room on the other device by entering the room ID and a nickname, then clicking "Join Room".
4. Start playing the game.

## Demo Images
![menu]('./demo_image/menu.png')
![Create Room]('./demo_image/create_room.png')
![Join Room]('./demo_image/join_game.png')
![Winner]('./demo_image/winner.png')

Feel free to modify the content as per your project's specifics.