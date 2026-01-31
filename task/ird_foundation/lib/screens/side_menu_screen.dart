import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A8ED9),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            _buildMenuItem(Icons.home_outlined, "Home", isActive: true),
            _buildMenuItem(Icons.person_outline, "Profile"),
            _buildMenuItem(Icons.location_on_outlined, "Nearby"),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Divider(color: Colors.white24, endIndent: 120),
            ),
            _buildMenuItem(Icons.bookmark_border, "Bookmark"),
            _buildMenuItem(Icons.notifications_outlined, "Notification", hasBadge: true),
            _buildMenuItem(Icons.mail_outline, "Message", hasBadge: true),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Divider(color: Colors.white24, endIndent: 120),
            ),
            _buildMenuItem(Icons.settings_outlined, "Setting"),
            _buildMenuItem(Icons.help_outline, "Help"),
            _buildMenuItem(Icons.power_settings_new, "Logout"),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, {bool isActive = false, bool hasBadge = false}) {
    return Container(
      margin: const EdgeInsets.only(right: 170, bottom: 8),
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.transparent,
        borderRadius: const BorderRadius.only(topRight: Radius.circular(25), bottomRight: Radius.circular(25)),
      ),
      child: ListTile(
        leading: Icon(icon, color: isActive ? const Color(0xFF0A8ED9) : Colors.white),
        title: Text(
          title,
          style: GoogleFonts.raleway(
            color: isActive ? const Color(0xFF0A8ED9) : Colors.white,
            fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
          ),
        ),
        trailing: hasBadge ? const CircleAvatar(radius: 4, backgroundColor: Colors.red) : null,
      ),
    );
  }
}