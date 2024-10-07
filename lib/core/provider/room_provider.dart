import 'package:flutter/material.dart';
import 'package:tictactoe_game/models/player.dart';

class RoomDataProvider extends ChangeNotifier {
  Map<String, dynamic> _room = {};
  List<String> _displayGrid = List.filled(9, '');
  int _filledBoxes = 0;
  bool _isGameStarted = false;
  Player _player1 = Player.empty().copyWith(playerType: 'X');
  Player _player2 = Player.empty().copyWith(playerType: 'O');

  Map<String, dynamic> get room => _room;
  List<String> get displayGrid => _displayGrid;
  int get filledBoxes => _filledBoxes;
  bool get isGameStarted => _isGameStarted;
  Player get player1 => _player1;
  Player get player2 => _player2;

  void updateRoom(Map<String, dynamic> room) {
    _room = room;
    notifyListeners();
  }

  void setGameStarted(bool started) {
    _isGameStarted = started;
    notifyListeners();
  }

  void updatePlayer1(Map<String, dynamic> player1) {
    _player1 = Player.fromMap(player1);
    notifyListeners();
  }

  void updatePlayer2(Map<String, dynamic> player2) {
    _player2 = Player.fromMap(player2);
    notifyListeners();
  }

  void upDateDisplayGrid(int index, String choice) {
    _displayGrid[index] = choice;
    _filledBoxes++;
    notifyListeners();
  }

  void resetGame() {
    _displayGrid = List.filled(9, '');
    _filledBoxes = 0;
    notifyListeners();
  }
}
