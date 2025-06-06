import 'package:flutter/material.dart';
import 'package:flutter_to_ride/flutter_to_ride.dart';
import 'package:get_storage/get_storage.dart';

class TtRAppModel extends ChangeNotifier {
  static const _storageKey = 'games';
  final GetStorage storage;

  List<TtRGame> games = [];

  TtRAppModel() : storage = GetStorage() {
    _loadFromStorage();
  }

  // --- Private local storage methods

  void _loadFromStorage() {
    final List<dynamic>? gameMaps = storage.read(_storageKey);
    if (gameMaps != null) {
      final gameList = gameMaps
          .map((map) => TtRGame.fromMap(map))
          .toList();
      gameList.sort((a, b) => a.lastPlayed.compareTo(b.lastPlayed));
      games = gameList;
      notifyListeners();
    }
  }

  void _saveToStorage() {
    final gameMap = games.map((game) => game.toMap()).toList();
    storage.write(_storageKey, gameMap);
    notifyListeners();
  }

  // --- Public, game list related methods ---

  void addGame(TtRGame newGame) {
    games.add(newGame);
    _saveToStorage();
  }

  void removeGame(String id) {
    games.removeWhere((game) => identical(game.id, id));
    _saveToStorage();
  }

  void updateGame(TtRGame updatedGame) {
    final index = games.indexWhere((game) => game.id == updatedGame.id);
    if (index != -1) {
      games[index] = updatedGame;
      _saveToStorage();
    }
  }

  void clearAll() {
    games = [];
    _saveToStorage();
  }

  // --- Public, game specific methods ---
}