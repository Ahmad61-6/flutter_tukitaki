import 'dart:io';

import 'package:flutter/material.dart';
import 'package:task_1/app/app_constants.dart';
import 'package:task_1/features/home/presentation/widgets/post_action_button.dart';

import '../../../../core/data/models/user_info.dart';

class UserPostCard extends StatelessWidget {
  final UserModel user;
  final int index;

  const UserPostCard({super.key, required this.user, required this.index});

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

    final String postContent = AppConstants
        .contentVariations[index % AppConstants.contentVariations.length];
    final String timestamp = _getRelativeTime(index);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        colorScheme.primaryContainer,
                        colorScheme.primary.withOpacity(0.7),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: ClipOval(
                    child: getProfileImage() != null
                        ? Image(
                            image: getProfileImage()!,
                            fit: BoxFit.cover,
                            width: 48,
                            height: 48,
                          )
                        : Icon(
                            Icons.person,
                            size: 24,
                            color: colorScheme.onPrimaryContainer,
                          ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.fullName,
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        timestamp,
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.more_horiz,
                  color: colorScheme.onSurface.withOpacity(0.6),
                ),
              ],
            ),
          ),

          // Post Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(postContent, style: textTheme.bodyMedium),
          ),

          const SizedBox(height: 16),

          // User Info Section
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '👤 Profile Information',
                  style: textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 12),
                _buildInfoRow('Name', user.fullName, Icons.person_outline),
                _buildInfoRow('Email', user.email, Icons.email_outlined),
                if (user.phoneNumber != null && user.phoneNumber!.isNotEmpty)
                  _buildInfoRow(
                    'Phone',
                    user.phoneNumber!,
                    Icons.phone_outlined,
                  ),
                if (user.bio != null && user.bio!.isNotEmpty)
                  _buildInfoRow('Bio', user.bio!, Icons.info_outline),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Post Actions
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                PostActionButton(
                  icon: Icons.thumb_up_outlined,
                  label: 'Like',
                  count: (index * 3) % 100,
                  onPressed: () {},
                ),
                PostActionButton(
                  icon: Icons.comment_outlined,
                  label: 'Comment',
                  count: (index * 2) % 50,
                  onPressed: () {},
                ),
                PostActionButton(
                  icon: Icons.share_outlined,
                  label: 'Share',
                  count: (index * 1) % 25,
                  onPressed: () {},
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getRelativeTime(int index) {
    final hoursAgo = (index * 2) % 24;
    if (hoursAgo == 0) return 'Just now';
    if (hoursAgo == 1) return '1 hour ago';
    return '$hoursAgo hours ago';
  }
}
