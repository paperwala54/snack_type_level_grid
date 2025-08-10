import 'package:flutter/material.dart';

import '../providers/level_provider.dart';

/// Widget to display a single level tile
/// Shows different states: completed (green), available (orange), locked (grey)
class LevelTile extends StatelessWidget {
  final int levelNumber;
  final LevelStatus status;
  final VoidCallback? onTap;
  
  const LevelTile({
    super.key,
    required this.levelNumber,
    required this.status,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: status == LevelStatus.locked ? null : onTap,
      child: Container(
        decoration: BoxDecoration(
          color: _getBackgroundColor(),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _getBorderColor(),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Level number in center
            Center(
              child: Text(
                levelNumber.toString().padLeft(2, '0'),
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: _getTextColor(),
                ),
              ),
            ),
            // Status icon in bottom right corner
            Positioned(
              bottom: 6,
              right: 6,
              child: _getStatusIcon(),
            ),
          ],
        ),
      ),
    );
  }
  
  /// Get background color based on level status
  Color _getBackgroundColor() {
    switch (status) {
      case LevelStatus.completed:
        return Colors.green[600]!; // Brighter green like in the image
      case LevelStatus.available:
        return Colors.orange[600]!; // Brighter orange like in the image
      case LevelStatus.locked:
        return Colors.grey[200]!; // Lighter grey like in the image
    }
  }
  
  /// Get border color based on level status
  Color _getBorderColor() {
    switch (status) {
      case LevelStatus.completed:
        return Colors.green[700]!;
      case LevelStatus.available:
        return Colors.orange[700]!;
      case LevelStatus.locked:
        return Colors.grey[400]!;
    }
  }
  
  /// Get text color based on level status
  Color _getTextColor() {
    switch (status) {
      case LevelStatus.completed:
      case LevelStatus.available:
        return Colors.white;
      case LevelStatus.locked:
        return Colors.grey[800]!; // Darker text for better contrast like in the image
    }
  }
  
  /// Get appropriate icon based on level status
  Widget _getStatusIcon() {
    switch (status) {
      case LevelStatus.completed:
        return const Icon(
          Icons.check,
          color: Colors.white,
          size: 16,
        );
      case LevelStatus.available:
        return const Icon(
          Icons.play_arrow,
          color: Colors.white,
          size: 16,
        );
      case LevelStatus.locked:
        return Icon(
          Icons.lock,
          color: Colors.grey[600],
          size: 16,
        );
    }
  }
} 