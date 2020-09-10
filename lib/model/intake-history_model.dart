import 'package:hive/hive.dart';
import 'intake_model.dart';
part 'intake-history_model.g.dart';

@HiveType(typeId: 1)
class IntakeHistoryModel extends HiveObject{
  @HiveField(0)
  DateTime createdAt;
  @HiveField(1)
  int dailyGoal;
  @HiveField(2)
  List<IntakeModel> intakes;
  IntakeHistoryModel({this.createdAt,this.dailyGoal,this.intakes});
}

