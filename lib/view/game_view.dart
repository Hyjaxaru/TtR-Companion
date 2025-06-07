import 'package:flutter/material.dart';
import 'package:flutter_to_ride/flutter_to_ride.dart';
import 'package:watch_it/watch_it.dart';

class GameView extends WatchingWidget {
  const GameView(this.gameID, {super.key});
  final String gameID;

  void _showDeleteDialog(BuildContext context, String gameID) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: Icon(Icons.warning_rounded, color: ColorScheme.of(context).error),
        title: Text('Delete Game?', style: TextStyle(fontFamily: 'RobotoSlab')),
        content: Text('All your progress will be lost', textAlign: TextAlign.center),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              di<TtRAppModel>().removeGame(gameID);
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: Text(
              'Confirm',
              style: TextStyle(color: ColorScheme.of(context).error)
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TtRGame game =watchIt<TtRAppModel>().games.firstWhere((game) => game.id == gameID);
    return Scaffold(
      backgroundColor: ColorScheme.of(context).surfaceContainer,
      body: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            backgroundColor: ColorScheme.of(context).surfaceContainer,
            centerTitle: false,
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(game.icon),
                const SizedBox(width: 8),
                Text(
                  game.name,
                  style: TextStyle(fontFamily: 'RobotoSlab')
                ),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () => _showDeleteDialog(context, game.id),
                icon: Icon(Icons.delete_rounded),
              )
            ],
          ),

          SliverToBoxAdapter(
            child: GroupedListHeader('Players')
          ),

          SliverGroupedList(
            children: List.generate(
              game.players.length < 5 ? game.players.length+1 : game.players.length, (index) {       
                if (index >= game.players.length && game.players.length < 5) {
                  return GroupedListTile(
                    title: Text('Add Player'),
                    leading: Icon(Icons.add),
                    onTap: () => di<TtRAppModel>().gameAddPlayer(
                      gameID,
                      Player.autoID(
                        name: 'Player $index',
                        color: Colors.blue,
                        score: 0
                      )
                    ) 
                  );
                }
                final player = game.players[index];
                return GroupedListTile(
                  title: Text(player.name),
                  subtitle: Text('${player.score} points'),
                  leading: Icon(
                    Icons.person_rounded,
                    color: player.color,
                  ),
                  trailing: IconButton(
                    onPressed: () => di<TtRAppModel>().gameRemovePlayer(
                      gameID,
                      player
                    ),
                    icon: Icon(Icons.remove_rounded)
                  ),
                );
              }
            ),
          ),
        ],
      )
    );
  }
}