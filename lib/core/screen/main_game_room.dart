import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe_game/core/provider/room_provider.dart';
import 'package:tictactoe_game/core/utils/constants.dart';
import 'package:tictactoe_game/core/widgets/game_board.dart';
import 'package:tictactoe_game/core/widgets/socore_board.dart';

class MainRoom extends StatelessWidget {
  const MainRoom({super.key});

  @override
  Widget build(BuildContext context) {
    final roomDataProvider = Provider.of<RoomDataProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: defaultPadding * 2,
              horizontal: defaultPadding,
            ),
            child: Column(
              children: [
                const ScoreBoard(),
                const SizedBox(height: defaultPadding * 3),
                const GameBoard(),
                const SizedBox(height: defaultPadding),
                Text(
                  '${roomDataProvider.room['turn']['nickname']}\'s Turn',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
