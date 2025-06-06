import 'package:flutter/material.dart';
import 'package:flutter_to_ride/flutter_to_ride.dart';

class GroupedListView extends StatelessWidget {
  const GroupedListView({
    super.key,
    this.heading,
    required this.children
  });

  final Widget? heading;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: heading != null ? children.length+1 : children.length,
      itemBuilder: (context, index) {
        if (heading != null && index == 0) {
          return heading;
        }
        return GroupedListContainer(
          length: children.length,
          itemIndex: heading != null ? index-1 : index,
          child: children[heading != null ? index-1 : index ]
        );
      }
    );
  }
}

class SliverGroupedList extends StatelessWidget {
  const SliverGroupedList({
    super.key,
    this.heading,
    required this.children,
  });

  final Widget? heading;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: heading != null ? children.length+1 : children.length,
      itemBuilder: (context, index) {
        if (heading != null && index == 0) {
          return heading;
        }
        return GroupedListContainer(
          length: children.length,
          itemIndex: heading != null ? index-1 : index,
          child: children[heading != null ? index-1 : index ]
        );
      }
    );
  }
}