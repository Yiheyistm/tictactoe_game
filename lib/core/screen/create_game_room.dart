import 'package:flutter/material.dart';
import 'package:tictactoe_game/core/reponsiveness/responsiveness.dart';
import 'package:tictactoe_game/core/utils/constants.dart';
import 'package:tictactoe_game/core/widgets/custom_button.dart';
import 'package:tictactoe_game/core/widgets/custom_text.dart';
import 'package:tictactoe_game/core/widgets/custom_textfield.dart';

class CreateGameRoom extends StatefulWidget {
  const CreateGameRoom({super.key});

  @override
  _CreateGameRoomState createState() => _CreateGameRoomState();
}

class _CreateGameRoomState extends State<CreateGameRoom> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomText(text: 'Create Room', fontSize: 70, shadow: [
                Shadow(
                  color: Colors.blue,
                  blurRadius: 10,
                  offset: Offset(1, 1),
                ),
              ]),
              const SizedBox(height: defaultPadding * 2),
              CustomTextField(
                  hintText: 'Enter your nickname', controller: controller),
              const SizedBox(height: defaultPadding),
              CustomButton(
                  text: 'Create',
                  onPressed: () {
                    if (controller.text.isNotEmpty) {
                      // Create room
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
