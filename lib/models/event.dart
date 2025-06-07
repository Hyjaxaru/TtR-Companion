import 'package:uuid/uuid.dart';

/// The different types of turn actions
/// 
/// Only the ones that should be stored in the app
/// (e.g. building a route, but not picking up cards)
enum GameActionType { buildRoute, completeTicket }

/// A game action taken by the player
/// 
/// Great for logging the actions played
class GameAction {
  final String id;
  final String playerID;
  final GameActionType action;
  final int pointsAwarded;
  final String? notes;

  /// A game action a player proformed for their turn
  /// 
  /// Great for action history
  GameAction({
    required this.id,
    required this.playerID,
    required this.action,
    required this.pointsAwarded,
    this.notes,
  });

  /// Creates a new [GameAction] and autofills the [id]
  factory GameAction.autoID({
    required String playerID,
    required GameActionType action,
    required int pointsAwarded,
    String? notes,
  }) => GameAction(
    id: Uuid().v4().toString(),
    playerID: playerID,
    action: action,
    pointsAwarded: pointsAwarded,
    notes: notes
  );

  /// Creates a new [GameAction] from the previous, with the given changes
  /// 
  /// Note: this will generate a new [id] string
  GameAction copyWith({
    String? id,
    String? playerID,
    GameActionType? action,
    int? pointsAwarded,
    String? notes
  }) => GameAction(
    id: id ?? this.id,
    playerID: playerID ?? this.playerID,
    action: action ?? this.action,
    pointsAwarded: pointsAwarded ?? this.pointsAwarded,
    notes: notes ?? this.notes
  );

  /// Creates a new [GameAction] from map data
  /// 
  /// useful for converting from local storage
  factory GameAction.fromMap(Map<String, dynamic> map) => GameAction(
    id: map['id'],
    playerID: map['playerID'],
    action: GameActionType.values.byName(map['action']),
    pointsAwarded: map['pointsAwarded'],
    notes: map['notes']
  );

  /// Creates a [Map] from this [GameAction]
  /// 
  /// Userful for storing in local storage
  Map<String, dynamic> toMap() => {
    'id': id,
    'playerID': playerID,
    'action': action.name,
    'pointsAwarded': pointsAwarded,
    'notes': notes
  };
}