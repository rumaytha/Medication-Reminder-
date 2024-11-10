import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medication_reminder/features/side_effect/logic/medicin_cubit.dart';
import 'package:medication_reminder/features/side_effect/screens/side_effect_screen.dart';

import 'features/side_effect/logic/side_effect_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SideEffectCubit(),
          ),
          BlocProvider(
            create: (context) => MedicationCubit(),
          )
        ],
        child: const SideEffectScreen(),
      ),
    );
  }
}
