import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:tictactoe_game/core/provider/room_provider.dart';
import 'package:tictactoe_game/core/utils/show_dialog.dart';

import 'package:tictactoe_game/services/socket_client_services.dart';

class GameMethod {
  static void checkWinner(BuildContext context, Socket socketClient) {
    RoomDataProvider roomDataProvider =
        Provider.of<RoomDataProvider>(context, listen: false);
    final board = roomDataProvider.displayGrid;

    String winner = '';

    List<List<int>> winningPatterns = [
      // Rows
      [0, 1, 2], [3, 4, 5], [6, 7, 8],
      // Columns
      [0, 3, 6], [1, 4, 7], [2, 5, 8],
      // Diagonals
      [0, 4, 8], [2, 4, 6]
    ];

    // Loop through all winning patterns and check if any are fully occupied by 'X' or 'O'
    for (var pattern in winningPatterns) {
      String firstCell = board[pattern[0]];
      if (firstCell.isNotEmpty &&
          firstCell == board[pattern[1]] &&
          firstCell == board[pattern[2]]) {
        winner = firstCell; // 'X' or 'O' has won
      }
    }
    // If there is no winner, check if the game is a draw (no empty cells)
    if (roomDataProvider.filledBoxes == 9 && winner.isEmpty) {
      winner = '';
      showWinnerDialog(context, 'Draw', isDraw: true);
    }

    // If there is a winner or the game is a draw, emit the game over event
    if (winner.isNotEmpty) {
      if (winner == roomDataProvider.player1.playerType) {
        socketClient.emit('winner', {
          'roomID': roomDataProvider.room['roomID'],
          'winnerSocketID': roomDataProvider.player1.socketId,
          'socketID': SocketClientServices.instance.socket?.id
        });
      } else if (winner == roomDataProvider.player2.playerType) {
        socketClient.emit('winner', {
          'roomID': roomDataProvider.room['roomID'],
          'winnerSocketID': roomDataProvider.player2.socketId,
          'socketID': SocketClientServices.instance.socket?.id
        });
      }
    }
  }

  // Function to reset the board for a new game
  static void resetBoard(BuildContext context) {
    RoomDataProvider roomDataProvider =
        Provider.of<RoomDataProvider>(context, listen: false);
    roomDataProvider.resetGame();
  }
}
