// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:tictactoe_game/core/reponsiveness/responsiveness.dart';
import 'package:tictactoe_game/core/utils/constants.dart';
import 'package:tictactoe_game/core/widgets/custom_button.dart';
import 'package:tictactoe_game/core/widgets/custom_text.dart';
import 'package:tictactoe_game/core/widgets/custom_textfield.dart';
import 'package:tictactoe_game/services/socket_client_method.dart';

class CreateGameRoom extends StatefulWidget {
  const CreateGameRoom({super.key});

  @override
  _CreateGameRoomState createState() => _CreateGameRoomState();
}

class _CreateGameRoomState extends State<CreateGameRoom> {
  final SocketClientMethod _socketClientMethod = SocketClientMethod();
  final _controller = TextEditingController();

  @override
  void initState() {
    _socketClientMethod.onRoomCreatedListener(context);
    _socketClientMethod.onErrorOccurredListener(context);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    // _socketClientMethod.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Responsive(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                    hintText: 'Enter your nickname', controller: _controller),
                const SizedBox(height: defaultPadding),
                CustomButton(
                    text: 'Create',
                    onPressed: () {
                      if (_controller.text.isNotEmpty) {
                        _socketClientMethod.createRoom(_controller.text);
                      }
                      // braveheart, nomadland, fightclub, inception, i am david shutter island
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
