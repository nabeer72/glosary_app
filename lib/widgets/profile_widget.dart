import 'dart:ui';

import 'package:flutter/material.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final String profilePicUrl;
  final String userName;
  final String userEmail;

  const ProfileHeaderWidget({
    super.key,
    required this.profilePicUrl,
    required this.userName,
    required this.userEmail,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Profile Picture with Glassmorphic Border
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 12,
                  spreadRadius: 2,
                ),
              ],
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 4,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: profilePicUrl.isNotEmpty
                  ? Image.network(
                      profilePicUrl,
                      height: 130,
                      width: 130,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return CircularProgressIndicator(
                          color: Colors.white.withOpacity(0.7),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.account_circle,
                        size: 130,
                        color: Colors.white70,
                      ),
                    )
                  : Icon(
                      Icons.account_circle,
                      size: 130,
                      color: Colors.white70,
                    ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            userName,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: 0.8,
              fontFamily: 'Roboto',
            ),
          ),
          const SizedBox(height: 8),
          Text(
            userEmail,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.85),
              fontStyle: FontStyle.italic,
              fontFamily: 'Roboto',
            ),
          ),
        ],
      ),
    );
  }
}

// Reusable Glassmorphic Card Widget
class GlassmorphicCardWidget extends StatelessWidget {
  final List<Widget> children;

  const GlassmorphicCardWidget({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white.withOpacity(0.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1.5,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: children,
            ),
          ),
        ),
      ),
    );
  }
}

// Reusable Animated List Tile Widget
class AnimatedListTileWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? titleColor;

  const AnimatedListTileWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.iconColor,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white.withOpacity(0.05),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: iconColor ?? const Color(0xff5EC401),
              size: 26,
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: titleColor ?? Colors.black87,
                fontFamily: 'Roboto',
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey[600],
            ),
          ],
        ),
      ),
    );
  }
}

// Divider Widget for Reusability
class CustomDividerWidget extends StatelessWidget {
  const CustomDividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Divider(
        height: 1,
        thickness: 0.5,
        color: Colors.grey.withOpacity(0.3),
      ),
    );
  }
}