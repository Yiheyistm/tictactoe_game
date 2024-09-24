
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tictactoe_game/core/reponsiveness/responsiveness.dart';
import 'package:tictactoe_game/core/routes/route_names.dart';
import 'package:tictactoe_game/core/utils/constants.dart';
import 'package:tictactoe_game/core/widgets/custom_button.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        child: Center(
          child: Responsive(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/tictactoe.png',
                    width: 200,
                    height: 200,
                  ),
                ),
                const SizedBox(height: defaultPadding * 3),
                CustomButton(
                  text: 'Create Room',
                  onPressed: () {
                    context.pushNamed(RouteName.createRoom);
                  },
                ),
                const SizedBox(height: defaultPadding / 3),
                CustomButton(
                  text: 'Join Room',
                  onPressed: () {
                    context.pushNamed(RouteName.joinRoom);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
