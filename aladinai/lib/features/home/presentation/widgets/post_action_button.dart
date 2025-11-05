import 'package:flutter/material.dart';

class PostActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final int count;
  final VoidCallback onPressed;

  const PostActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.count,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TextButton.icon(
      icon: Icon(icon, size: 18, color: colorScheme.onSurface.withOpacity(0.7)),
      label: Text(
        '$label ($count)',
        style: TextStyle(
          color: colorScheme.onSurface.withOpacity(0.7),
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }
}
