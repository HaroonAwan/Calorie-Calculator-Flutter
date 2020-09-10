import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'intake_model.g.dart';

@HiveType(typeId: 2)
class IntakeModel extends HiveObject {
  @HiveField(0) DateTime time;
  @HiveField(1) int calories;
  @HiveField(2) String description;

  IntakeModel({this.calories, this.description, this.time});
}

List<IntakeModel> history = [
  IntakeModel(
    time: DateTime.now(),
    description: 'Salad',
    calories: 20
  ),
  IntakeModel(
    time: DateTime.now(),
    description: 'Burger',
    calories: 20
  ),
  IntakeModel(
    time: DateTime.now(),
    description: 'Sandwich',
    calories: 20
  ),
  IntakeModel(
    time: DateTime.now(),
    description: 'Drink',
    calories: 20
  ),
];