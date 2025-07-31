import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snake_game_app/controls.dart';
import 'package:snake_game_app/splash_screen.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  await WakelockPlus.enable();

  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(), // ✅ Start with splash!
    ),
  );
}
