import 'package:flutter/material.dart';

class GroupedListContainer extends StatelessWidget {
  const GroupedListContainer({
    super.key,
    required this.length,
    required this.itemIndex,
    required this.child
  });

  final int length;
  final int itemIndex;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final outsideRadius = Radius.circular(24);
    final insideRadius = Radius.circular(4);
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 1
      ),
      decoration: BoxDecoration(
        color: ColorScheme.of(context).surface,
        borderRadius: BorderRadius.vertical(
          top: itemIndex <= 0 ? outsideRadius : insideRadius,
          bottom: itemIndex >= length-1 ? outsideRadius : insideRadius,
        )
      ),
      child: child,
    );
  }
}