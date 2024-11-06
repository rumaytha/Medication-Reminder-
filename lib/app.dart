import 'package:flutter/material.dart';
import 'package:medication_reminder/features/side_effect/screens/side_effect_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SideEffectScreen(),
    );
  }
}
