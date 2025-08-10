# Snack Demo - Level Selection App

A Flutter app that demonstrates a level selection interface with Provider state management.

## Features

- **Dynamic Level Creation**: Enter any number (1-100) to create that many levels
- **Sequential Progression**: Levels must be completed in order
- **Visual Level States**:
  - 🟢 **Green**: Completed levels (with checkmark)
  - 🟠 **Orange**: Available levels (current level to play)
  - ⚪ **Grey**: Locked levels (with lock icon)
  - 🟣 **Purple**: "Coming Soon" tile after the last level

## How to Use

1. **Start the App**: Run `flutter run` to launch the app
2. **Enter Level Count**: On the welcome screen, enter the number of levels you want (e.g., 50)
3. **Press "Start Game"**: This will create the level grid
4. **Play Levels**: 
   - Tap on the orange (available) level to play
   - Complete the level by pressing "Complete Level" button
   - Return to see the level turn green and the next level become orange
5. **Sequential Progress**: You can only play levels in order - locked levels show a message if tapped

## App Structure

```
lib/
├── main.dart                    # App entry point with Provider setup
├── providers/
│   └── level_provider.dart      # State management for levels
├── screens/
│   ├── input_screen.dart        # Welcome screen for level count input
│   ├── level_selection_screen.dart  # Main level grid screen
│   └── game_screen.dart         # Individual level play screen
└── widgets/
    └── level_tile.dart          # Reusable level tile widget
```

## State Management

The app uses **Provider** for state management:
- `LevelProvider` manages completed levels, current level, and total levels
- State updates automatically reflect in the UI
- Level progression is handled sequentially

## Dependencies

- `flutter`: Core Flutter framework
- `provider: ^6.1.1`: State management
- `cupertino_icons: ^1.0.8`: iOS-style icons

## Getting Started

1. Ensure you have Flutter installed
2. Clone this repository
3. Run `flutter pub get` to install dependencies
4. Run `flutter run` to start the app

## Example Usage

1. Enter "50" in the text field
2. Press "Start Game"
3. You'll see a 4x4 grid of levels (1-50 + "Coming Soon")
4. Level 1 will be orange (available)
5. Levels 2-50 will be grey (locked)
6. Tap Level 1 to play
7. Complete the level and return
8. Level 1 will be green, Level 2 will be orange
9. Continue this pattern to progress through all levels
