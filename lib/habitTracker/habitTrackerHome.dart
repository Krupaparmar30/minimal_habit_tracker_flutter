import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minimal_habit_tracker_flutter/DataBase/habit_database.dart';
import 'package:minimal_habit_tracker_flutter/componets/my_habit_map/my_habit_map.dart';
import 'package:minimal_habit_tracker_flutter/componets/my_habit_tile/my_habit_tile.dart';
import 'package:minimal_habit_tracker_flutter/modal/habit_modal.dart';
import 'package:provider/provider.dart';

import '../utils/habit_utils.dart';

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

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();

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

    //check habit on off
    // edit habit box

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Habit Tracker')),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inverseSurface,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewHabit,
        backgroundColor: Theme.of(context).colorScheme.surface,
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
    List<HabitModal> currentHabit = habitDatabase.currentHabits;

    //   return heat map UI
    return FutureBuilder<DateTime?>(
      future: habitDatabase.getFirstLaunchDate(),
      builder: (context, snapshot) {
        // once the data  is available -> build heatmap
        if (snapshot.hasData) {
          return MyHeatMap(
              startDate: snapshot.data!,
              datasets: preHeatMapDataset(currentHabit));
        }

        //   handle case where no da ta is returned
        else {
          return Container();
        }
      },
    );
  }

// Widget _buildHabitMap()
// {
//   final habitDatabase=context.watch<HabitDatabase>();
//   List<HabitModal> currentHabits = habitDatabase.currentHabits;
//   return FutureBuilder<DateTime?>(future: habitDatabase.getFirstLaunchDate(), builder: (context, snapshot) {
// if(snapshot.hasData)
//   {
//     return MyHabitMap(startDate: snapshot.data!, datasets: prepHeatMapDataset(currentHabits));
//   }
// else
//   {
//     return Container();
//   }
//   },
//   );
//
// }
  Widget _buildHabitList() {
    final habitDatabase = context.watch<HabitDatabase>();

    List<HabitModal> currentHabits = habitDatabase.currentHabits;
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
          editHabit: (context) => editHabit(habit),
          deleteHabit: (context) => deleteHabit(habit),
        );
      },
    );
  }

  editHabit(HabitModal habit) {
    var textEditingController;
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

  deleteHabit(HabitModal habit) {
    var textEditingController;
    textEditingController.text = habit.name;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure you want to delete?'),
        actions: [
          MaterialButton(
            onPressed: () {
              context.read<HabitDatabase>().deleteHabit(habit.id);

              Navigator.of(context).pop();

              textEditingController.clear();
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

  checkHabitOnOff(bool? value, HabitModal habit) {
    if (value != null) {
      context.read<HabitDatabase>().updateHabitCompletion(habit.id, value);
    }
  }
}
