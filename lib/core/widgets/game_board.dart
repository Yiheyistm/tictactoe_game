import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe_game/core/provider/room_provider.dart';
import 'package:tictactoe_game/services/socket_client_method.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  final SocketClientMethod _socketClientMethod = SocketClientMethod();

  @override
  void initState() {
    _socketClientMethod.onGridTappedListener(context);
    _socketClientMethod.onEndGameListener(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.7,
        maxWidth: 500,
      ),
      child: AbsorbPointer(
        absorbing: Provider.of<RoomDataProvider>(context).room['turn']
                ['socketId'] !=
            _socketClientMethod.socketClient.id,
        child: GridView.builder(
            itemCount: 9,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemBuilder: (context, index) {
              return Consumer<RoomDataProvider>(
                builder: (context, roomDataProvider, child) => GestureDetector(
                  onTap: () {
                    _socketClientMethod.tapGrid(
                      index: index,
                      roomId: roomDataProvider.room['roomID'],
                      displayGrid: roomDataProvider.displayGrid,
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white60),
                    ),
                    child: Center(
                      child: AnimatedSize(
                        duration: const Duration(milliseconds: 300),
                        child: Text(
                          roomDataProvider.displayGrid[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 100,
                            shadows: [
                              Shadow(
                                color:
                                    roomDataProvider.displayGrid[index] == 'X'
                                        ? Colors.blue
                                        : Colors.red,
                                blurRadius: 10,
                                offset: const Offset(1, 1),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
