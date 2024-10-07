import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe_game/core/utils/constants.dart';
import 'package:tictactoe_game/services/game_method.dart';
import 'package:tictactoe_game/services/socket_client_services.dart';

void showWinnerDialog(BuildContext context, String winner,
    {bool isFinalRound = false, bool isDraw = false}) {
  final ConfettiController confettiController =
      ConfettiController(duration: const Duration(seconds: 3));
  confettiController.play(); // Start confetti animation

  WidgetsBinding.instance.addPostFrameCallback((_) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: bgColor,
          elevation: 2,
          shadowColor: Colors.blue,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      !isDraw ? '🎉 Congratulations! 🎉' : '😒😒 DRAW 😒😒',
                      style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              color: Colors.blue,
                              blurRadius: 10,
                            )
                          ]),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: defaultPadding),
                    Text(
                      winner,
                      style: const TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: defaultPadding * 2),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding * 2),
                      ),
                      onPressed: () {
                        if (!isFinalRound) {
                          GameMethod.resetBoard(context); // Reset the game
                          Navigator.of(context, rootNavigator: true).pop();
                        } else {
                          GameMethod.resetBoard(context);
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
                          SocketClientServices.instance.dispose();
                        }
                        // Close the dialog
                      },
                      child: const Text('Play Again'),
                    ),
                  ],
                ),
              ),
              // Confetti animation
              Positioned(
                top: 0,
                child: ConfettiWidget(
                  confettiController: confettiController,
                  blastDirectionality: BlastDirectionality.explosive,
                  shouldLoop: false,
                  colors: const [
                    Colors.red,
                    Colors.green,
                    Colors.blue,
                    Colors.yellow
                  ],
                ),
              ),
            ],
          ),
        );
      },
    ).then((value) {
      confettiController.stop(); // Stop confetti after the dialog is dismissed
    });
  });
}
