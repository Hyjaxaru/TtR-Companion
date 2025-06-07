import 'package:flutter/material.dart';

class GroupedListTile extends StatelessWidget {
  const GroupedListTile({
    super.key,
    this.enabled,
    this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
  });

  final bool? enabled;

  final Widget? title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      enabled: enabled ?? true,
      title: title,
      subtitle: subtitle,
      leading: leading,
      trailing: trailing,
      contentPadding: EdgeInsets.symmetric(horizontal: 16),
      onTap: onTap,
    );
  }
}