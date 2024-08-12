
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MyHabitTile extends StatelessWidget {
  final bool isCompleted;
  final String text;
  final void Function(bool?)? onChanged;
  final void Function(BuildContext)? editHabit;
  final void Function(BuildContext)? deleteHabit;

  const MyHabitTile({super.key,required this.isCompleted ,required this.text,required this.onChanged,required this.editHabit,required this.deleteHabit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(onPressed: editHabit,
            backgroundColor: Colors.grey.shade800,
            icon: Icons.settings,
              borderRadius: BorderRadius.circular(10),

            ),
            SlidableAction(onPressed: deleteHabit,
              backgroundColor: Colors.red,
              icon: Icons.settings,
              borderRadius: BorderRadius.circular(10),

            )
          ],
        ),
        child: GestureDetector(
          onDoubleTap: () {
            if(onChanged!=null)
              {
                onChanged!(!isCompleted);
              }
          },
          child: Container(
            color:isCompleted? Colors.green.shade50 :Theme.of(context).colorScheme.surface,
            child:Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title:  Text(text,style: TextStyle(
                  color: isCompleted? Colors.black45:Theme.of(context).colorScheme.primary
                ),),
                leading: Checkbox(
                  focusColor: Colors.grey.shade200,
                  value: isCompleted,
                  onChanged: onChanged,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
