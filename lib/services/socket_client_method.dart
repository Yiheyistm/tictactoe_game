import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:tictactoe_game/core/provider/room_provider.dart';
import 'package:tictactoe_game/core/routes/route_names.dart';
import 'package:tictactoe_game/core/utils/show_dialog.dart';
import 'package:tictactoe_game/core/utils/show_snackbar.dart';
import 'package:tictactoe_game/services/game_method.dart';
import 'package:tictactoe_game/services/socket_client_services.dart';
// import 'dart:developer' as dev show log;

class SocketClientMethod {
  final _socketClient = SocketClientServices.instance.socket!;
  Socket get socketClient => _socketClient;

  void createRoom(String nickname) {
    _socketClient.emit('createRoom', {"nickname": nickname});
  }

  void joinRoom(String roomId, String nickname) {
    _socketClient.emit('joinRoom', {"roomId": roomId, "nickname": nickname});
  }

  void tapGrid({
    required int index,
    required String roomId,
    required List<String> displayGrid,
  }) {
    if (displayGrid[index] == '') {
      _socketClient.emit('tapGrid', {"index": index, "roomId": roomId});
    }
  }

  // Listener
  void onRoomCreatedListener(BuildContext context) {
    _socketClient.on(
        'roomCreatedSuccess',
        (room) => {
              Provider.of<RoomDataProvider>(context, listen: false)
                  .updateRoom(room),
              context.pushNamed(RouteName.waitingLobby),
              CustomSnackBar.showSuccessSnackBar(
                  context, 'Room is created successfully')
            });
  }

  void onRoomJoinedListener(BuildContext context) {
    _socketClient.on(
        'roomJoinedSuccess',
        (room) => {
              Provider.of<RoomDataProvider>(context, listen: false)
                  .updateRoom(room),
            });
  }

  void onErrorOccurredListener(BuildContext context) {
    _socketClient.on('errorOccurred', (error) {
      CustomSnackBar.showErrorSnackBar(context, error);
    });
  }

  void onPlayersUpdateStateListener(BuildContext context) {
    _socketClient.on('updatePlayers', (playersData) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updatePlayer1(playersData[0]);
      Provider.of<RoomDataProvider>(context, listen: false)
          .updatePlayer2(playersData[1]);
    });
  }

  void onGameStartedListener(BuildContext context) {
    _socketClient.on('gameStarted', (data) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .setGameStarted(true);
      CustomSnackBar.showSuccessSnackBar(context, "Game Started Successfully");
      context.pushNamed(RouteName.gameRoom);
    });
  }

  void onGridTappedListener(BuildContext context) {
    _socketClient.on('updateGame', (data) {
      final roomDataProvider =
          Provider.of<RoomDataProvider>(context, listen: false);
      roomDataProvider.upDateDisplayGrid(data['index'], data['choice']);
      roomDataProvider.updateRoom(data['room']);
      GameMethod.checkWinner(context, socketClient);
    });
  }

  void onEndGameListener(BuildContext context) {
    _socketClient.on('endGame', (playerData) {
      showWinnerDialog(
          context, '${playerData['nickname']} is the winner of all Time!!!',
          isFinalRound: true);

      // _gameMethod.resetBoard(context);
    });
  }

  void onPointUpdateListener(BuildContext context) {
    _socketClient.on('pointsIncrease', (data) {
      showWinnerDialog(context, '${data['winner']['nickname']} is the winner');
      final roomDataProvider =
          Provider.of<RoomDataProvider>(context, listen: false);
      if (data['winner']['socketId'] == roomDataProvider.player1.socketId) {
        roomDataProvider.updatePlayer1(data['winner']);
      } else {
        roomDataProvider.updatePlayer2(data['winner']);
      }
      roomDataProvider.updateRoom(data['room']);
    });
  }
}
