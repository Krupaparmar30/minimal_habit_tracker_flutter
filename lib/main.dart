import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minimal_habit_tracker_flutter/DataBase/habit_database.dart';
import 'package:provider/provider.dart';

import 'habitTracker/habitTrackerHome.dart';

Future<void> main()
async {
  WidgetsFlutterBinding.ensureInitialized();
  //initialize database
  await HabitDatabase.initialize();
  await HabitDatabase().saveFirstLaunchDate();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HabitDatabase(),)
      ],
      child: MaterialApp(
        home: habitTracker(),
      ),
    );
  }
}
