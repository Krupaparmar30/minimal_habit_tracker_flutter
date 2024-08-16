import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minimal_habit_tracker_flutter/DataBase/habit_database.dart';
import 'package:minimal_habit_tracker_flutter/componets/my_habit_map/my_habit_map.dart';
import 'package:minimal_habit_tracker_flutter/componets/my_habit_tile/my_habit_tile.dart';
import 'package:minimal_habit_tracker_flutter/modal/habit_modal.dart';
import 'package:provider/provider.dart';

import '../provider/theme_provider.dart';
import '../utils/habit_utils.dart';

final TextEditingController textEditingController = TextEditingController();

class habitTracker extends StatefulWidget {
  //const habitTracker({super.key});

  @override
  State<habitTracker> createState() => _habitTrackerState();
}

class _habitTrackerState extends State<habitTracker> {
  @override
  void initState() {
    Provider.of<HabitDatabase>(context, listen: false).readHabits();

    super.initState();
  }

//create new habit
  void createNewHabit() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textEditingController,
          decoration: InputDecoration(hintText: "Create a new Habits"),
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              String newHabitName = textEditingController.text;

              context.read<HabitDatabase>().addHabit(newHabitName);

              Navigator.of(context).pop();

              textEditingController.clear();
            },
            child: Text('Save'),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.of(context).pop();

              textEditingController.clear();
            },
            child: Text('Cancel'),
          )
        ],
      ),
    );
  }

  void checkHabitOnOff(bool? value, Habit habit) {
    // update habit completion status
    if (value != null) {
      context.read<HabitDatabase>().updateHabitCompletion(habit.id, value);
    }
  }

  //check habit on off
  // edit habit box

  void editHabitBox(Habit habit) {
    textEditingController.text = habit.name;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textEditingController,
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              String newHabitName = textEditingController.text;

              context
                  .read<HabitDatabase>()
                  .updateHabitName(habit.id, newHabitName);

              Navigator.pop(context);

              textEditingController.clear();
            },
            child: Text('Save'),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.of(context).pop();

              textEditingController.clear();
            },
            child: Text('Cancel'),
          )
        ],
      ),
    );
  }

  void deleteHabitBox(Habit habit) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure you want to delete?'),
        actions: [
          MaterialButton(
            onPressed: () {
              context.read<HabitDatabase>().deleteHabit(habit.id);

              Navigator.pop(context);
            },
            child: Text('Delete'),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'Habit Tracker',
          style: TextStyle(
            color: Provider.of<ThemeProvider>(context).isDarkMode
                ? Colors.white
                : Color(0xff132a66),
            //Color(0xff132a66)
          ),
        )),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inverseSurface,
        actions: [
          IconButton(
            icon: Icon(
              Provider.of<ThemeProvider>(context).isDarkMode
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewHabit,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: Icon(Icons.add),
      ),
      body: ListView(
        children: [
          _buildHabitMap(),
          _buildHabitList(),
        ],
      ),
    );
  }

  Widget _buildHabitMap() {
    // habit database
    final habitDatabase = context.watch<HabitDatabase>();

    //   current habit
    List<Habit> currentHabit = habitDatabase.currentHabits;

    //   return heat map UI
    return FutureBuilder<DateTime?>(
      future: habitDatabase.getFirstLaunchDate(),
      builder: (context, snapshot) {
        // once the data  is available -> build heatmap
        if (snapshot.hasData) {
          return MyHabitMap(
              startDate: snapshot.data!,
              datasets: preHeatMapDataset(currentHabit)


          );
        }

        //   handle case where no da ta is returned
        else {
          return Container();
        }
      },
    );
  }

  Widget _buildHabitList() {
    final habitDatabase = context.watch<HabitDatabase>();

    List<Habit> currentHabits = habitDatabase.currentHabits;
    return ListView.builder(
      itemCount: currentHabits.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final habit = currentHabits[index];

        bool isCompletedToday = isHabitCompletedToday(habit.completedDays);

        return MyHabitTile(
          isCompleted: isCompletedToday,
          text: habit.name,
          onChanged: (value) => checkHabitOnOff(value, habit),
          editHabit: (context) => editHabitBox(habit),
          deleteHabit: (context) => deleteHabitBox(habit),
        );
      },
    );
  }
}
//061d5c
