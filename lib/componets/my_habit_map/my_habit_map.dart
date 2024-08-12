// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
//
// class MyHabitMap extends StatelessWidget {
//   final DateTime startDate;
//   final Map<DateTime,int> datasets;
//
//   const MyHabitMap({super.key,required this.startDate,required this.datasets});
//
//   @override
//   Widget build(BuildContext context) {
//     return HeatMap(
//         startDate: startDate,
//         endDate: DateTime.now(),
//         datasets: datasets,
//         colorMode:ColorMode.color,
//         defaultColor:  Theme.of(context).colorScheme.inverseSurface,
//         textColor: Colors.white,
//         showColorTip: false,
//         showText: true,
//         scrollable: true,
//         size: 32,
//
//         colorsets: {
//       1: Colors.green.shade200,
//       2: Colors.green.shade300,
//       3: Colors.green.shade400,
//       4: Colors.green.shade500,
//       5: Colors.green.shade600,
//
//     });
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:provider/provider.dart';

class MyHeatMap extends StatelessWidget {
  final Map<DateTime, int> datasets;
  final DateTime startDate;

  const MyHeatMap({
    super.key,
    required this.startDate,
    required this.datasets,
  });

  @override
  Widget build(BuildContext context) {
    return HeatMap(
        startDate: startDate,
        endDate: DateTime.now(),
        datasets: datasets,
        colorMode: ColorMode.color,
        defaultColor: Theme.of(context).colorScheme.secondary,
        textColor: Theme.of(context).colorScheme.inversePrimary,
        showColorTip: false,

        showText: true,
        scrollable: true,
        size: 32,
        colorsets: {
          1: Colors.green.shade200,
          2: Colors.green.shade300,
          3: Colors.green.shade400,
          4: Colors.green.shade500,
          5: Colors.green.shade600,
        });
  }
}