import 'package:demo_app/exercise/application/cubit/exercise_cubit.dart';
import 'package:demo_app/exercise/application/reposotery/exercise_repositery.dart';
import 'package:demo_app/exercise/presentation/exercise_screen.dart';
import 'package:demo_app/utils/shared_pref.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialized preferences
  await AppSharedPrefs.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercise Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider<ExerciseCubit>(
        create: (context) => ExerciseCubit(
          repository: ExerciseRepository(),
        ),
        child: ExercisesPage(),
      ),
    );
  }
}