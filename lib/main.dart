import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snake_game_app/controls.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

void main() async {
  // Sets up Flutter's internal system.
  WidgetsFlutterBinding.ensureInitialized();

  // Force landscape mode (like classic snake game).
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  // Hides top status bar and bottom navigation.
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  // Keeps the screen ON (useful for games).
  await WakelockPlus.enable();

  // Launch the game screen
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GameController(),
    ),
  );
}
