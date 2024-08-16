import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MyHabitTile extends StatelessWidget {
  final bool isCompleted;
  final String text;
  final void Function(bool?)? onChanged;
  final void Function(BuildContext)? editHabit;
  final void Function(BuildContext)? deleteHabit;

  const MyHabitTile(
      {super.key,
      required this.isCompleted,
      required this.text,
      required this.onChanged,
      required this.editHabit,
      required this.deleteHabit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: editHabit,
              backgroundColor: Colors.grey.shade200,
              icon: Icons.edit,
              borderRadius: BorderRadius.circular(10),
            ),
            SizedBox(
              width: 2,
            ),
            SlidableAction(
              onPressed: deleteHabit,
              backgroundColor: Colors.red.shade600,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(10),
            )
          ],
        ),
        child: GestureDetector(
          onTap: () {
            if (onChanged != null) {
              onChanged!(!isCompleted);
            }
          },
          child: Container(
            decoration: BoxDecoration(
                color: isCompleted
                    ? Theme.of(context).colorScheme.secondary
                    :Colors.white,
                borderRadius: BorderRadius.circular(8)),
            child: ListTile(
              title: Text(
                text,
                style: TextStyle(
                    color: isCompleted
                        ? Colors.grey.shade50
                        : Theme.of(context).colorScheme.primary),
              ),
              leading: Checkbox(
                focusColor: Colors.white,
                value: isCompleted,
                onChanged: onChanged,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
