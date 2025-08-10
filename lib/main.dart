import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/level_provider.dart';
import 'screens/input_screen.dart';

/// Main entry point of the Snack Demo app
/// Sets up Provider and initializes the app
void main() {
  runApp(const MyApp());
}

/// Root app widget
/// Configures the app theme and provides state management
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // Provide the LevelProvider to the entire app
      create: (context) => LevelProvider(),
      child: MaterialApp(
        title: 'Snack Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // App theme configuration
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.light,
          ),
          useMaterial3: true,
          // Customize app bar theme
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
          ),
          // Customize elevated button theme
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        // Start with the input screen
        home: const InputScreen(),
      ),
    );
  }
}
