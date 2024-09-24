import 'package:flutter/material.dart';
import 'package:tictactoe_game/core/reponsiveness/responsiveness.dart';
import 'package:tictactoe_game/core/utils/constants.dart';
import 'package:tictactoe_game/core/widgets/custom_button.dart';
import 'package:tictactoe_game/core/widgets/custom_text.dart';
import 'package:tictactoe_game/core/widgets/custom_textfield.dart';

class JoinGameRoom extends StatefulWidget {
  const JoinGameRoom({super.key});

  @override
  _JoinGameRoomState createState() => _JoinGameRoomState();
}

class _JoinGameRoomState extends State<JoinGameRoom> {
  final TextEditingController _gameIdController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  @override
  void dispose() {
    _gameIdController.dispose();
    _nameController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomText(text: 'Join Room', fontSize: 70, shadow: [
                Shadow(
                  color: Colors.blue,
                  blurRadius: 10,
                  offset: Offset(1, 1),
                ),
              ]),
              const SizedBox(height: defaultPadding * 2),
              CustomTextField(
                hintText: 'Enter your nickname',
                controller: _nameController,
              ),
              const SizedBox(height: defaultPadding),
              CustomTextField(
                hintText: 'Enter Game Id',
                controller: _gameIdController,
              ),
              const SizedBox(height: defaultPadding),
              CustomButton(
                  text: 'Join',
                  onPressed: () {
                    if (_gameIdController.text.isNotEmpty &&
                        _nameController.text.isNotEmpty) {
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
