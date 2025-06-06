import 'package:flutter/material.dart';
import 'package:flutter_to_ride/flutter_to_ride.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:watch_it/watch_it.dart';

class TtRHome extends WatchingWidget {
  const TtRHome({super.key});

  void _startNewGame(BuildContext context) {
    // create the new game
    final newGame = TtRGame.autoID(
      name: 'New Game',
      icon: Icons.train,
      started: DateTime.now(),
      players: [],
      actions: []
    );
    // add it to the game list
    di<TtRAppModel>().addGame(newGame);
    // navigate to it
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => GameView(newGame.id))
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<TtRGame> games = watchIt<TtRAppModel>().games; // watchPropertyValue((TtRAppModel m) => m.games);
    return Scaffold(
      backgroundColor: ColorScheme.of(context).surfaceContainer,
      floatingActionButton: FloatingActionButton.large(
        onPressed: () => _startNewGame(context),
        tooltip: 'Start new game',
        child: Icon(Icons.play_arrow_rounded),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: false,
            backgroundColor: ColorScheme.of(context).surfaceContainer,
            title: Text('TtR Companion', style: TextStyle(fontFamily: 'RobotoSlab')),
            actions: [
              IconButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SettingsView())
                ),
                icon: Icon(Icons.settings_rounded)
              ),
            ],
          ),

          if (games.isEmpty)
            const SliverToBoxAdapter(child: NoGamesFoundHero()),

          if (games.isNotEmpty && games.first.ended == null)
            SliverToBoxAdapter(
              child: LastGameHero(
                title: games.first.name,
                icon: Icons.train_rounded,
                lastPlayed: null,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => GameView(games.first.id))
                ),
              ),
            ),

          SliverList.builder(
            itemCount: games.length,
            itemBuilder: (context, index) {
              //if (index==0 && games.first.ended == null) { return SizedBox(); }
              final game = games[index];
              return GroupedListContainer(
                length: games.length,
                itemIndex: index,
                child: ListTile(
                  title: Text(game.name),
                  subtitle: Text(game.ended != null ? 'Played ${timeago.format(game.ended!)}' : 'Ongoing'),
                  leading: Icon(game.icon),
                  trailing: Icon(game.ended == null ? Icons.arrow_forward : Icons.more_vert),
                  onTap: () => game.ended == null
                      ? Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => GameView(game.id))
                      )
                      : {} 
                ),
              );
            }
          ),
        ],
      )
    );
  }
}