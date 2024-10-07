import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe_game/core/provider/room_provider.dart';
import 'package:tictactoe_game/services/socket_client_method.dart';

class ScoreBoard extends StatefulWidget {
  const ScoreBoard({super.key});

  @override
  State<ScoreBoard> createState() => _ScoreBoardState();
}

class _ScoreBoardState extends State<ScoreBoard> {
  final SocketClientMethod _socketClientMethod = SocketClientMethod();

  @override
  void initState() {
    _socketClientMethod.onPointUpdateListener(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RoomDataProvider>(
      builder: (context, roomDataProvider, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                // nickname
                Text(
                  roomDataProvider.player1.nickname,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.blue,
                          offset: Offset(1.0, 1.0),
                        ),
                      ]),
                ),
                Text(
                  roomDataProvider.player1.points.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                // points
              ],
            ),
            Column(
              children: [
                // nickname
                Text(
                  roomDataProvider.player2.nickname,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.red,
                          offset: Offset(1.0, 1.0),
                        ),
                      ]),
                ),
                Text(
                  roomDataProvider.player2.points.toInt().toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                // points
              ],
            )
          ],
        );
      },
    );
  }
}
