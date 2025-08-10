import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/level_provider.dart';

/// Game screen that appears when user taps on a level
/// Simple screen with a completion button to simulate level completion
class GameScreen extends StatelessWidget {
  final int levelNumber;
  
  const GameScreen({
    super.key,
    required this.levelNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          'Level $levelNumber',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.orange, Colors.deepOrange],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Level display
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(60),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    levelNumber.toString().padLeft(2, '0'),
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              
              // Level title
              Text(
                'Level $levelNumber',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              
              // Level description
              Text(
                'Complete this level to unlock the next one!',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 60),
              
              // Complete level button
              ElevatedButton(
                onPressed: () => _completeLevel(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  'Complete Level',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              
              // Skip level button (for testing)
              TextButton(
                onPressed: () => _completeLevel(context),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white70,
                ),
                child: const Text(
                  'Skip Level (for testing)',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  /// Complete the current level and navigate back
  void _completeLevel(BuildContext context) {
    // Get the level provider and mark level as completed
    final levelProvider = Provider.of<LevelProvider>(context, listen: false);
    levelProvider.completeLevel(levelNumber);
    
    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Level $levelNumber completed!'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
    
    // Navigate back to level selection
    Navigator.pop(context);
  }
} 