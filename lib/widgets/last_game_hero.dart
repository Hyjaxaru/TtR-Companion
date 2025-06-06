import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago; 

class LastGameHero extends StatelessWidget {
  const LastGameHero({
    super.key,
    required this.title,
    this.icon,
    this.lastPlayed,
    required this.onTap
  });

  final String title;
  final IconData? icon;
  final DateTime? lastPlayed;

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 128,
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.symmetric(horizontal: 48),
        decoration: BoxDecoration(
          color: ColorScheme.of(context).tertiaryContainer,
          borderRadius: BorderRadius.circular(24)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon ?? Icons.train,
              color: Theme.of(context).colorScheme.tertiary,
              size: 32,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Typography.englishLike2021.titleLarge?.copyWith(
                    fontFamily: 'RobotoSlab',
                    color: ColorScheme.of(context).onTertiaryContainer
                  )
                ),
                Text(lastPlayed != null ? 'Played ${timeago.format(lastPlayed!)}' : 'Ongoing'),
              ]
            ),
            Icon(
              Icons.arrow_forward,
              color: Theme.of(context).colorScheme.tertiary,
              size: 32,
            ),
          ]
        ),
      ),
    );
  }
}