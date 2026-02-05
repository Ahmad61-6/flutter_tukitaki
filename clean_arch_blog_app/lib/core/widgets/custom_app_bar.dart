import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final String? title;
  final bool showBackButton;

  const CustomAppBar({
    super.key,
    this.leading,
    this.actions,
    this.backgroundColor,
    this.title,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(title ?? ''),
      automaticallyImplyLeading: false,
      backgroundColor: backgroundColor,
      leading:
          leading ??
          (showBackButton
              ? IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.arrow_back),
                )
              : null),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
