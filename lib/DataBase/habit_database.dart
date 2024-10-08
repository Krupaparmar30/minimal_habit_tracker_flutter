import 'package:flutter/cupertino.dart';
import 'package:isar/isar.dart';
import 'package:minimal_habit_tracker_flutter/modal/app_settings.dart';
import 'package:minimal_habit_tracker_flutter/modal/habit_modal.dart';
import 'package:path_provider/path_provider.dart';

class HabitDatabase extends ChangeNotifier {
  static late Isar isar;

  // S E T U P

// Initialize - database
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([HabitSchema, AppSettingsSchema],
        directory: dir.path);
  }

  //save first date of startup(for heatmap)
 static Future<void> saveFirstLaunchDate() async {
    final existingSettings =await isar.appSettings.where().findFirst();
    if (existingSettings == null) {
      final settings = AppSettings()..firstLaunchDate = DateTime.now();
      await isar.writeTxn(() => isar.appSettings.put(settings));
    }
  }

//get first date of app startup(for heatmap)
  Future<DateTime?> getFirstLaunchDate() async {
    final settings = await isar.appSettings.where().findFirst();
    return settings?.firstLaunchDate;
  }

  //crud

//List of habits
  final List<Habit> currentHabits = [];

  // CREATE  - add a new habit
  Future<void> addHabit(String habitName) async {
//create a new habit
    final newHabit = Habit()..name = habitName;
//SAVE TO database
    await isar.writeTxn(() => isar.habits.put(newHabit));

    //re - read from database
    readHabits();
  }

// READ - read saved habits from database

  Future<void> readHabits() async {
    //fetch all habits from db

    List<Habit> fetchedHabits = await isar.habits.where().findAll();

    // give to currunt habits

    currentHabits.clear();
    currentHabits.addAll(fetchedHabits);

    //up
    notifyListeners();
  }

  //UPDATE - check habit on and off

  Future<void> updateHabitCompletion(int id, bool isCompleted) async {
//find the specific habit
    final habit = await isar.habits.get(id);

    //update completion status
    if (habit != null) {
      await isar.writeTxn(() async {
        if (isCompleted && !habit.completedDays.contains(DateTime.now())) {
          //today
          final today = DateTime.now();

          habit.completedDays.add(DateTime(today.year, today.month, today.day));
        } else {
          //remove the currunt
          habit.completedDays.removeWhere((date) =>
              date.year == DateTime.now().year &&
              date.month == DateTime.now().month &&
              date.day == DateTime.now().day);
        }
//save the up dated
        await isar.habits.put(habit);
      });
    }
    //reread from db
    readHabits();
  }

  // UPDATE -edit habit name
  Future<void> updateHabitName(int id, String newName) async {
    final habit = await isar.habits.get(id);

    if (habit != null) {
      await isar.writeTxn(() async {
        habit.name = newName;

        await isar.habits.put(habit);
      });
    }
    readHabits();
  }

//DELETE -delete habit
  Future<void> deleteHabit(int id) async {
    await isar.writeTxn(() async {
      await isar.habits.delete(id);
    });
    readHabits();
  }
}
