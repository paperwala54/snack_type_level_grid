import 'package:flutter/material.dart';

/// Provider class to manage level state across the app
/// Handles completed levels, current level, and total levels
class LevelProvider extends ChangeNotifier {
  // Set to store completed level numbers
  Set<int> _completedLevels = {};
  
  // Current level that user is on (next level to play)
  int _currentLevel = 1;
  
  // Total number of levels available
  int _totalLevels = 0;
  
  // Getter for completed levels
  Set<int> get completedLevels => _completedLevels;
  
  // Getter for current level
  int get currentLevel => _currentLevel;
  
  // Getter for total levels
  int get totalLevels => _totalLevels;
  
  /// Set the total number of levels from user input
  /// @param total The total number of levels to create
  void setTotalLevels(int total) {
    _totalLevels = total;
    _currentLevel = 1;
    _completedLevels.clear();
    notifyListeners();
  }
  
  /// Mark a level as completed and move to next level
  /// @param levelNumber The level number that was completed
  void completeLevel(int levelNumber) {
    if (levelNumber <= _totalLevels) {
      _completedLevels.add(levelNumber);
      
      // Find the next available level
      _currentLevel = _findNextAvailableLevel();
      
      notifyListeners();
    }
  }
  
  /// Find the next level that should be available to play
  /// @return The next available level number
  int _findNextAvailableLevel() {
    for (int i = 1; i <= _totalLevels; i++) {
      if (!_completedLevels.contains(i)) {
        return i;
      }
    }
    return _totalLevels + 1; // All levels completed
  }
  
  /// Check if a level is completed
  /// @param levelNumber The level number to check
  /// @return True if the level is completed
  bool isLevelCompleted(int levelNumber) {
    return _completedLevels.contains(levelNumber);
  }
  
  /// Check if a level is currently available to play
  /// @param levelNumber The level number to check
  /// @return True if the level can be played
  bool isLevelAvailable(int levelNumber) {
    // Level is available if it's the current level or if all previous levels are completed
    if (levelNumber == _currentLevel) return true;
    
    // Check if all previous levels are completed
    for (int i = 1; i < levelNumber; i++) {
      if (!_completedLevels.contains(i)) {
        return false;
      }
    }
    return true;
  }
  
  /// Get the status of a level for UI display
  /// @param levelNumber The level number to get status for
  /// @return LevelStatus enum value
  LevelStatus getLevelStatus(int levelNumber) {
    if (isLevelCompleted(levelNumber)) {
      return LevelStatus.completed;
    } else if (isLevelAvailable(levelNumber)) {
      return LevelStatus.available;
    } else {
      return LevelStatus.locked;
    }
  }
}

/// Enum to represent different level states
enum LevelStatus {
  completed,  // Green - level is completed
  available,  // Orange - level is available to play
  locked,     // Grey - level is locked
} 