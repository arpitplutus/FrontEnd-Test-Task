import 'package:demo_app/exercise/application/cubit/exercise_state.dart';
import 'package:demo_app/exercise/application/reposotery/exercise_repositery.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExerciseCubit extends Cubit<ExerciseState> {
  ExerciseCubit({required this.repository}) : super(InitialState()) {
    getExercises();
  }

  final ExerciseRepository repository;

  // fetched exercise preferences
  void getExercises() async {
    try {
      emit(LoadingState());
      final exercises = await repository.getExercises();
      emit(LoadedState(exercises));
    } catch (e) {
      emit(ErrorState());
    }
  }

  // fetched exercise preferences
  void tapLoading() async {
    try {
      emit(LoadingState());
      Future.delayed(const Duration(seconds: 3), () async {
        final exercises = await repository.getExercises();
        emit(LoadedState(exercises));
      });
    } catch (e) {
      emit(ErrorState());
    }
  }
}
