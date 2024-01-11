import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AppbarMenu extends StatelessWidget implements PreferredSizeWidget {
  const AppbarMenu(
      {super.key,
      this.title,
      required this.showBackArrow,
      this.leadingIcon,
      this.actions,
      this.leadingOnPressed,
      required this.onPressed,
      required this.opacity,this.color = Colors.white});

  final Widget? title;
  final Color color;
  final double opacity;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: AppBar(
        backgroundColor: Colors.purple.withOpacity(opacity),
        automaticallyImplyLeading: false,
        leading: showBackArrow
            ? IconButton(
                onPressed: onPressed,
                icon: Icon(
                  Iconsax.arrow_left,
                  color: color,
                ))
            : leadingIcon != null
                ? IconButton(
                    onPressed: leadingOnPressed,
                    icon: Icon(leadingIcon),
                  )
                : null,
        title: title,
        actions: actions,
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
