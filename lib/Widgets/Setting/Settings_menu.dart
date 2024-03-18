import 'package:flutter/material.dart';

class SettingsMenu extends StatelessWidget {
  const SettingsMenu(
      {super.key,
      this.title,
      this.subtitle,
      required this.icon,
      this.trailing, this.onTap});

  final String? title, subtitle;
  final IconData icon;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
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
