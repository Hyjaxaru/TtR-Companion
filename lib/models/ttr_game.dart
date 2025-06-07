import 'package:flutter/material.dart';
import 'package:flutter_to_ride/models/event.dart';
import 'package:flutter_to_ride/models/player.dart';
import 'package:uuid/uuid.dart';

/// A single Ticket to Ride game
class TtRGame {
  /// The game's ID
  /// 
  /// Used internally, and should not be shown to the user
  final String id;
  /// The decorative name of the game
  final String name;
  /// The decorative icon for the game
  final IconData icon;
  /// The date and time the game was created or stared
  final DateTime started;
  /// The date and time the game was last played
  DateTime lastPlayed;
  /// The date tand time the game ended or finished
  /// 
  /// Leave this as null if the game is still ongoing.
  DateTime? ended;

  /// The list of players in the game
  List<Player> players;
  /// The id of the winning player
  String? winnerID;
  Player? get winner => players.where((player) => player.id == winnerID).first;
  set winner(Player? player) => winnerID = player?.id;

  /// The list of actions that took place in the game
  List<GameAction> actions;

  /// A single Ticket to Ride game
  TtRGame({
    required this.id,
    required this.name,
    required this.icon,
    required this.started,
    required this.lastPlayed,
    this.ended,
    required this.players,
    this.winnerID,
    required this.actions,
  });

  /// Creates a new [TtRGame] and autofills the [id] field
  /// 
  /// If the [lastPlayed] field is null, [started] will be used
  factory TtRGame.autoID({
    required String name,
    required IconData icon,
    required DateTime started,
    DateTime? lastPlayed,
    DateTime? ended,
    required List<Player> players,
    String? winnerID,
    required List<GameAction> actions,
  }) => TtRGame(
    id: Uuid().v4().toString(),
    name: name,
    icon: icon,
    started: started,
    lastPlayed: lastPlayed ?? started,
    ended: ended,
    players: players,
    winnerID: winnerID,
    actions: actions
  );

  /// Creates a new [TtRGame] from the previous, with the given changes
  TtRGame copyWith({
    String? id,
    String? name,
    IconData? icon,
    DateTime? started,
    DateTime? lastPlayed,
    DateTime? ended,
    List<Player>? players,
    String? winnerID,
    List<GameAction>? actions,
  }) => TtRGame(
    id: id ?? this.id,
    name: name ?? this.name,
    icon: icon ?? this.icon,
    started: started ?? this.started,
    lastPlayed: lastPlayed ?? this.lastPlayed,
    ended: ended ?? this.ended,
    players: players ?? this.players,
    winnerID: winnerID ?? this.winnerID,
    actions: actions ?? this.actions,
  );

  /// Creates a new [TtRGame] from map data
  /// 
  /// useful for converting from local storage
  factory TtRGame.fromMap(Map<String, dynamic> map) {
    // convert the players into the Player type
    final playerMap = map['players'] ?? [];
    final playerList = playerMap as List;
    final players = playerList.map((map) => Player.fromMap(map)).toList();
    // convert the actions into the GameAction type
    final actionMap = map['actions'] ?? [];
    final actionList = actionMap as List;
    final actions = actionList.map((map) => GameAction.fromMap(map)).toList();
    return TtRGame(
      id: map['id'],
      name: map['name'],
      icon: IconData(map['icon'], fontFamily: 'MaterialIcons'),
      started: DateTime.parse(map['started']),
      lastPlayed: DateTime.parse(map['lastPlayed']),
    ended: DateTime.tryParse(map['ended']),
      players: players,
      winnerID: map['winnerID'],
      actions: actions,
    );
  }

  /// Creates a [Map] from this [TtRGame]
  /// 
  /// Userful for storing in local storage
  Map<String, dynamic> toMap() {
    final playerList = players.map((player) => player.toMap()).toList();
    final actionList = actions.map((action) => action.toMap()).toList();
    return {
      'id': id,
      'name': name,
      'icon': icon.codePoint,
      'started': started.toString(),
      'lastPlayed': lastPlayed.toString(),
      'ended': ended.toString(),
      'players': playerList,
      'winnerID': winnerID,
      'actions': actionList,
    };
  }
}
