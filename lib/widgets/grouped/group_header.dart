import 'package:flutter/material.dart';

class GroupedListHeader extends StatelessWidget {
  const GroupedListHeader(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8),
      child: Text(
        title,
        style: Typography.englishLike2021.titleMedium?.copyWith(
          fontFamily: 'RobotoSlab',
          color: ColorScheme.of(context).onTertiaryContainer
        )
      ),
    );
  }
}