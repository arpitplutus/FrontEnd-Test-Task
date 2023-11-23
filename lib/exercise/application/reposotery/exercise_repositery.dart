import 'dart:convert';
import 'package:demo_app/exercise/domain/exercise_model.dart';
import 'package:demo_app/utils/shared_pref.dart';

class ExerciseRepository {

  // fetched exercise
  Future<List<ExerciseModel>> getExercises() async {

    // static list of exercise
    List<ExerciseModel> exercises = [
      ExerciseModel(isselected: false, id: 1,title:  "Bodyweight"),
      ExerciseModel(isselected: false, id: 2,title:  "Dumbbels"),
      ExerciseModel(isselected: false, id: 3,title: "Bands" ),
      ExerciseModel(isselected: false, id: 4,title:  "Deadlift"),
      ExerciseModel(isselected: false, id: 5,title: "Push-up" ),
      ExerciseModel(isselected: false, id: 6,title:  "Pull-up"),
    ];

    try {
      // checked the exercise if selected or not
      if (AppSharedPrefs.getString(AppSharedPrefs.selectedArray) != "") {
        var parsedListJson =
            jsonDecode(AppSharedPrefs.getString(AppSharedPrefs.selectedArray));
        List<ExerciseModel> itemsList = List<ExerciseModel>.from(
            parsedListJson.map((i) => ExerciseModel.fromJson(i)));

        return itemsList;
      } else {
        return exercises;
      }
    } catch (e) {
      rethrow;
    }
  }
}
