import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe_game/core/provider/room_provider.dart';
import 'package:tictactoe_game/core/reponsiveness/responsiveness.dart';
import 'package:tictactoe_game/core/utils/constants.dart';
import 'package:tictactoe_game/core/widgets/custom_textfield.dart';
import 'package:tictactoe_game/services/socket_client_method.dart';

class WaitingLobby extends StatefulWidget {
  const WaitingLobby({super.key});

  @override
  State<WaitingLobby> createState() => _WaitingLobbyState();
}

class _WaitingLobbyState extends State<WaitingLobby> {
  final _socketClientMethod = SocketClientMethod();
  late TextEditingController _controller;
  @override
  void initState() {
    _socketClientMethod.onGameStartedListener(context);
    _socketClientMethod.onPlayersUpdateStateListener(context);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _controller = TextEditingController(
        text: Provider.of<RoomDataProvider>(context).room['roomID']);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        child: Center(
          child: Responsive(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircularProgressIndicator.adaptive(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue)),
                const SizedBox(
                  height: defaultPadding * 3,
                ),
                const Text('Waiting for the player joined'),
                const SizedBox(
                  height: defaultPadding * 2,
                ),
                CustomTextField(
                    hintText: '', controller: _controller, readOnly: true),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
