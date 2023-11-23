import 'dart:convert';
import 'package:demo_app/exercise/application/cubit/exercise_cubit.dart';
import 'package:demo_app/exercise/application/cubit/exercise_state.dart';
import 'package:demo_app/exercise/domain/exercise_model.dart';
import 'package:demo_app/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExercisesPage extends StatefulWidget {
  const ExercisesPage({super.key});

  @override
  _ExercisesPageState createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage> {
  var showLoading = false;
  List<ExerciseModel> selectedList = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: BlocBuilder<ExerciseCubit, ExerciseState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ErrorState) {
              return const Center(
                child: Icon(Icons.close),
              );
            } else if (state is LoadedState) {
              final exercises = state.exercises;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(flex: 3,
                      child: GridView.builder(
                    itemCount: exercises.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      final itemWidth = MediaQuery.of(context).size.width / 3;

                      return SizedBox(
                          width: itemWidth,
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  selectedList.clear();
                                  for (var j in exercises) {
                                    if (j.isselected == true) {
                                      selectedList.add(j);
                                    }
                                  }
                                  if (exercises[index].isselected == true) {
                                    exercises[index].isselected = false;
                                    selectedList.remove(exercises[index]);
                                  } else {
                                    if (selectedList.length > 2) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text(
                                            'You have reached max limit of selection!'),
                                      ));
                                    } else {
                                      selectedList.add(exercises[index]);
                                      exercises[index].isselected = true;
                                    }
                                  }
                                  setState(() {});

                                  String json = jsonEncode(exercises);
                                  AppSharedPrefs.setString(
                                      AppSharedPrefs.selectedArray, json);
                                },
                                child: Image.asset(
                                    exercises[index].isselected == true
                                        ? "assets/exSelect.png"
                                        : "assets/exDeselect.png"),
                              ),
                              Text(
                                exercises[index].title,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ));
                    },
                  )),
                  Expanded(flex: 1,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            child: const Text('SHOW A SNACKBAR'),
                            onPressed: () {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Hello!'),
                              ));
                            },
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                            child: const Text('SHOW A LOADING'),
                            onPressed: () {
                              context.read<ExerciseCubit>().tapLoading();
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
