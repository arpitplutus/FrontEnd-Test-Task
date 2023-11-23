class ExerciseModel {
  int id;
  bool isselected;
  String title;

  ExerciseModel({required this.id, required this.isselected,required this.title});

  factory ExerciseModel.fromJson(Map<String, dynamic> parsedJson) {
    return ExerciseModel(
        id: parsedJson['id'] ?? "",
        title: parsedJson['title'] ?? "",
        isselected: parsedJson['isselected'] ?? false);
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "isselected": isselected,"title": title};
  }
}
