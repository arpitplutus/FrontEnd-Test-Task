import 'package:demo_app/exercise/domain/exercise_model.dart';
import 'package:equatable/equatable.dart';

abstract class ExerciseState extends Equatable {}

class InitialState extends ExerciseState {
  @override
  List<Object> get props => [];
}

class LoadingState extends ExerciseState {
  @override
  List<Object> get props => [];
}

class LoadedState extends ExerciseState {
  LoadedState(this.exercises);

  final List<ExerciseModel> exercises;

  @override
  List<Object> get props => [exercises];
}

class ErrorState extends ExerciseState {
  @override
  List<Object> get props => [];
}