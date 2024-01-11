import 'package:flutter/material.dart';

class SettingsMenu extends StatelessWidget {
  const SettingsMenu(
      {super.key,
      this.title,
      this.subtitle,
      required this.icon,
      this.trailing});

  final String? title, subtitle;
  final IconData icon;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        size: 28,
        color: Colors.purple,
      ),
      trailing: trailing,
      title: Text(
        title!,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Text(
        subtitle!,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}
