import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gregdoucette/homepage.dart';
import 'package:gregdoucette/model/intake-history_model.dart';
import 'package:gregdoucette/quick-start_page.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'model/intake_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Hive.registerAdapter(IntakeModelAdapter());
  Hive.registerAdapter(IntakeHistoryModelAdapter());
  await Hive.initFlutter();
  int dailyCalorieIntake;
  /// TODO: Use SharedPreferences for storing single values.
  // Hive.openBox('dailyCalorieIntake').then((value) => value.clear());
  // Hive.box('records').clear();
  bool firstTime = (await Hive.openBox('dailyCalorieIntake')).isEmpty;
  if(!firstTime){
     dailyCalorieIntake = (await Hive.openBox('dailyCalorieIntake')).get('dailyCalorieIntake');
  }
  final box = await Hive.openBox<IntakeHistoryModel>('records');
  _parse(DateTime now) => '${now.day}-${now.month}-${now.year}';
  final date = _parse(DateTime.now());

  if (!box.containsKey(date)) {
    final model = IntakeHistoryModel(
      createdAt: DateTime.now(),
      dailyGoal: dailyCalorieIntake, /// TODO: Change it.
      intakes: []
    );
    await box.put(date, model);
    await model.save();
  }

  runApp(MyApp(firstTime: firstTime));
}

class MyApp extends StatelessWidget {
  final bool firstTime;
  MyApp({this.firstTime=true});
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Greg Doucette Calorie Calculator',
      localizationsDelegates: [
        DefaultMaterialLocalizations.delegate
      ],
      theme: CupertinoThemeData(
        barBackgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        textTheme: CupertinoTextThemeData(
          primaryColor: Colors.red,
        ),
      ),
      home: firstTime ? QuickStartPage() : HomePage(),
    );
  }
}