import 'package:flutter/widgets.dart';
import 'package:uuid/uuid.dart';

/// The Player
class Player {
  /// The player's ID
  /// 
  /// Used internally and should not be shown to the user
  final String id;
  /// The player's name
  final String name;
  /// The player's color in the physical game
  final Color color;
  /// The player's current score
  int score;

  /// Set the player's score to a new value
  void setScore(int newScore) => score = newScore;
  /// Increament the player's score by the given number
  void increment(int points) => score += points;
  /// Decrement the player's score by the given number
  void decrement(int points) => score -= points;

  /// The Player
  Player({
    required this.id,
    required this.name,
    required this.color,
    required this.score
  });

  /// Creates a new [Player] and autofills the [uuid] field
  factory Player.autoID({
    required String name,
    required Color color,
    required int score
  }) => Player(
    id: Uuid().v4().toString(),
    name: name,
    color: color,
    score: score
  );

  /// Creates a new [Player] from the previous, with the given changes
  Player copyWith({
    String? id,
    String? name,
    Color? color,
    int? score,
  }) => Player(
    id: id ?? this.id,
    name: name ?? this.name,
    color: color ?? this.color,
    score: score ?? this.score,
  ); 

  /// Creates a new [Player] from map data
  /// 
  /// useful for converting from local storage
  factory Player.fromMap(Map<String, dynamic> map) => Player(
    id: map['id'],
    name: map['name'],
    color: Color.from(
      alpha: map['color'][0],
      red: map['color'][1],
      green: map['color'][2],
      blue: map['color'][3],
    ),
    score: map['score'],
  );

  /// Creates a [Map] from this [Player]
  /// 
  /// Userful for storing in local storage
  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'color': [color.a, color.r, color.g, color.b],
    'score': score,
  };
}