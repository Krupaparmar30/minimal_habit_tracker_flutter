//
// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
//
// class MyHabitTile extends StatelessWidget {
//   final bool isCompleted;
//   final String text;
//   final void Function(bool?)? onChanged;
//   final void Function(BuildContext)? editHabit;
//   final void Function(BuildContext)? deleteHabit;
//
//   const MyHabitTile({super.key,required this.isCompleted ,required this.text,required this.onChanged,required this.editHabit,required this.deleteHabit});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Slidable(
//         endActionPane: ActionPane(
//           motion: StretchMotion(),
//           children: [
//             SlidableAction(onPressed: editHabit,
//             backgroundColor: Colors.grey.shade800,
//             icon: Icons.settings,
//               borderRadius: BorderRadius.circular(10),
//
//             ),
//             SizedBox(width: 2,),
//
//             SlidableAction(onPressed: deleteHabit,
//               backgroundColor: Colors.red,
//               icon: Icons.settings,
//               borderRadius: BorderRadius.circular(10),
//
//             )
//           ],
//         ),
//         child: GestureDetector(
//           onTap: () {
//             if(onChanged!=null)
//               {
//                 onChanged! (!isCompleted);
//               }
//           },
//           child: Container(
//             color:isCompleted? Colors.green.shade50 :Theme.of(context).colorScheme.secondary,
//             child:Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: ListTile(
//                 title:  Text(text,style: TextStyle(
//                   color: isCompleted? Colors.white:Theme.of(context).colorScheme.inverseSurface
//                 ),),
//                 leading: Checkbox(
//                   focusColor: Colors.green,
//                   value: isCompleted,
//                   onChanged: onChanged,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MyHabitTile extends StatelessWidget {
  final bool isCompleted;
  final String text;
  final void Function(bool?)? onChanged;
  final void Function(BuildContext)? editHabit;
  final void Function(BuildContext)? deleteHabit;

  const MyHabitTile({
    super.key,
    required this.isCompleted,
    required this.text,
    required this.onChanged,
    required this.editHabit,
    required this.deleteHabit,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: editHabit,
              backgroundColor: Colors.grey.shade800,
              icon: Icons.edit,
              borderRadius: BorderRadius.circular(10),
            ),
            SlidableAction(
              onPressed: deleteHabit,
              backgroundColor: Colors.red,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(10),
            ),
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
              gradient: isCompleted
                  ?  LinearGradient(
                colors: [
                  // Color(0xff024942),
                  Colors.white60,
                  Colors.white,

                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
                  : const LinearGradient(
                colors: [
                  Colors.black12,
                  Colors.black12,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: width * 0.04,
                    ),
                  ),
                ),
                Checkbox(
                  value: isCompleted,
                  onChanged: onChanged,
                  activeColor: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}