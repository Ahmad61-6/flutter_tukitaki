import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../core/data/models/user_info.dart';

class UserPostCard extends StatelessWidget {
  final UserModel user;
  const UserPostCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    ImageProvider? getProfileImage() {
      if (user.profilePictureUrl != null) {
        final file = File(user.profilePictureUrl!);
        if (file.existsSync()) {
          return FileImage(file);
        }
      }
      return null;
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 24,
              backgroundColor: colorScheme.surface.withOpacity(0.8),
              backgroundImage: getProfileImage(),
              child: getProfileImage() == null
                  ? Icon(
                      Icons.person_outline,
                      color: colorScheme.onSurface.withOpacity(0.6),
                    )
                  : null,
            ),
            title: Text(user.fullName, style: textTheme.titleMedium),
            subtitle: Text(user.email, style: textTheme.bodySmall),
            trailing: Icon(Icons.more_horiz, color: colorScheme.onSurface),
          ),

          // --- Card Body: Bio & Phone ---
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (user.bio != null && user.bio!.isNotEmpty)
                  Text(
                    user.bio!,
                    style: textTheme.bodyMedium,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  )
                else
                  Text(
                    'No bio provided.',
                    style: textTheme.bodyMedium?.copyWith(
                      fontStyle: FontStyle.italic,
                      color: colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),

                if (user.phoneNumber != null &&
                    user.phoneNumber!.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  const Divider(),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(
                        Icons.phone_outlined,
                        size: 16,
                        color: colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        user.phoneNumber!,
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildActionButton(context, Icons.thumb_up_outlined, 'Like'),
                _buildActionButton(context, Icons.comment_outlined, 'Comment'),
                _buildActionButton(context, Icons.share_outlined, 'Share'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, IconData icon, String label) {
    return TextButton.icon(
      icon: Icon(icon, size: 18),
      label: Text(label),
      onPressed: () {
        // Mock action
      },
    );
  }
}
