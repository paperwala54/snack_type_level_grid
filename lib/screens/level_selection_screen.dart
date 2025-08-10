import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/level_provider.dart';
import '../widgets/level_tile.dart';
import 'game_screen.dart';

/// Main screen for level selection
/// Displays a grid of level tiles with different states
class LevelSelectionScreen extends StatefulWidget {
  const LevelSelectionScreen({super.key});

  @override
  State<LevelSelectionScreen> createState() => _LevelSelectionScreenState();
}

class _LevelSelectionScreenState extends State<LevelSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar with settings and hints
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Level Selection',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          // Settings button
          Container(
            margin: const EdgeInsets.only(right: 8),
            decoration: const BoxDecoration(
              color: Colors.orange,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.settings, color: Colors.white),
              onPressed: () {
                // TODO: Implement settings functionality
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Settings coming soon!')),
                );
              },
            ),
          ),
          // Hints button
          Container(
            margin: const EdgeInsets.only(right: 8),
            decoration: const BoxDecoration(
              color: Colors.orange,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.lightbulb, color: Colors.white),
              onPressed: () {
                // TODO: Implement hints functionality
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Hints coming soon!')),
                );
              },
            ),
          ),
          // Hints counter
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  '0',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // Background with gradient and subtle patterns like in the image
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.lightBlue],
          ),
        ),
        child: Stack(
          children: [
            // Subtle circular patterns in background
            Positioned(
              top: 50,
              right: 30,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
            ),
            Positioned(
              top: 150,
              left: 20,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.08),
                ),
              ),
            ),
            Positioned(
              bottom: 100,
              right: 50,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.06),
                ),
              ),
            ),
            // Main content
            Consumer<LevelProvider>(
              builder: (context, levelProvider, child) {
                // Show input screen if no levels are set
                if (levelProvider.totalLevels == 0) {
                  return const Center(
                    child: Text(
                      'Please enter number of levels to start',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }
                
                return Column(
                  children: [
                    // Level grid - centered and compact like in the image
                    Expanded(
                      child: Center(
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 400),
                          child: GridView.builder(
                            key: const Key('levelGridView'), // Added key for debugging
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              childAspectRatio: 0.9, // Slightly taller tiles
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                            ),
                            itemCount: _calculateTotalGridItems(levelProvider.totalLevels),
                            itemBuilder: (context, index) {
                              return _buildGridItem(context, index, levelProvider);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
  
  /// Calculate total grid items needed for enhanced snake layout
  /// Accounts for special levels (multiples of 5) that get their own positions
  int _calculateTotalGridItems(int totalLevels) {
    // Generate the level sequence to see how many positions we need
    List<int> levelSequence = _generateLevelSequence();
    
    // Find how many positions we need for the total levels
    int positionsNeeded = 0;
    for (int i = 0; i < levelSequence.length; i++) {
      if (levelSequence[i] <= totalLevels) {
        positionsNeeded = i + 1;
      } else {
        break;
      }
    }
    
    // Add one more position for "Coming Soon" tile
    return positionsNeeded + 1;
  }
  
  /// Build individual grid item with enhanced snake layout
  Widget _buildGridItem(BuildContext context, int index, LevelProvider levelProvider) {
    final crossAxisCount = 4;
    final row = index ~/ crossAxisCount;
    final col = index % crossAxisCount;
    
    // Get the level sequence
    List<int> levelSequence = _generateLevelSequence();
    
    // Calculate the index in the sequence
    int sequenceIndex = row * crossAxisCount + col;
    
    // Check if this position has a level
    if (sequenceIndex >= levelSequence.length) {
      return Container(); // Empty position
    }
    
    int levelNumber = levelSequence[sequenceIndex];
    
    // If levelNumber is 0, it's an empty position (for special level rows)
    if (levelNumber == 0) {
      return Container();
    }
    
    // If this level is beyond total levels
    if (levelNumber > levelProvider.totalLevels) {
      // Show "Coming Soon" tile if it's the first level beyond total
      if (levelNumber == levelProvider.totalLevels + 1) {
        return _buildComingSoonTile();
      }
      return Container(); // Empty position
    }
    
    // Get level status and build tile
    final status = levelProvider.getLevelStatus(levelNumber);
    return LevelTile(
      levelNumber: levelNumber,
      status: status,
      onTap: () => _onLevelTap(context, levelNumber, status),
    );
  }
  
  /// Generate the level sequence with special handling for multiples of 5
  /// Dynamic algorithm that works for any number of levels
  List<int> _generateLevelSequence() {
    List<int> sequence = [];
    int currentLevel = 1;
    int regularRowCount = 0; // Track regular rows (excluding special level rows)
    
    while (currentLevel <= 1000) { // Support up to 1000 levels
      if (currentLevel % 5 == 0) {
        // Special level (multiple of 5) - alternate between end and beginning
        int specialLevelCount = (currentLevel / 5).round();
        if (specialLevelCount % 2 == 1) {
          // Odd special levels: at the end (5, 15, 25, 35, etc.)
          sequence.addAll([0, 0, 0, currentLevel]);
        } else {
          // Even special levels: at the beginning (10, 20, 30, 40, etc.)
          sequence.addAll([currentLevel, 0, 0, 0]);
        }
        currentLevel++;
      } else {
        // Regular group of 4 levels
        if (regularRowCount % 2 == 0) {
          // Even regular rows: left to right (1-4, 11-14, 21-24, 31-34, etc.)
          for (int i = 0; i < 4 && currentLevel <= 1000; i++) {
            sequence.add(currentLevel);
            currentLevel++;
          }
        } else {
          // Odd regular rows: right to left (6-9, 16-19, 26-29, 36-39, etc.)
          List<int> tempLevels = [];
          for (int i = 0; i < 4 && currentLevel <= 1000; i++) {
            tempLevels.add(currentLevel);
            currentLevel++;
          }
          // Reverse the order for right-to-left flow
          for (int i = tempLevels.length - 1; i >= 0; i--) {
            sequence.add(tempLevels[i]);
          }
        }
        regularRowCount++;
      }
    }
    
    print('Fixed Sequence: ${sequence.take(40).toList()}');
    return sequence;
  }
  
  /// Handle level tile tap
  void _onLevelTap(BuildContext context, int levelNumber, LevelStatus status) {
    if (status == LevelStatus.locked) {
      // Show message for locked levels
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Complete previous levels first!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    
    // Navigate to game screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GameScreen(levelNumber: levelNumber),
      ),
    );
  }
  
  /// Build "Coming Soon" tile
  Widget _buildComingSoonTile() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.purple.withOpacity(0.8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.purple,
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
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.hourglass_empty,
              color: Colors.white,
              size: 28,
            ),
            SizedBox(height: 6),
            Text(
              'Coming\nSoon',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 