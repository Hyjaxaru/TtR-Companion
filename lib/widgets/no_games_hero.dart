import 'package:flutter/material.dart';

class NoGamesFoundHero extends StatelessWidget {
  const NoGamesFoundHero({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 128,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorScheme.of(context).tertiaryContainer,
        borderRadius: BorderRadius.circular(64)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'That\'s weird...',
            style: Typography.englishLike2021.titleLarge?.copyWith(
              fontFamily: 'RobotoSlab',
              color: ColorScheme.of(context).onTertiaryContainer
            )
          ),
          const Text('There\'s nothing to show'),
        ]
      ),
    );
  }
}