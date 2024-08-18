import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:provider/provider.dart';

import '../../provider/theme_provider.dart';

class MyHabitMap extends StatelessWidget {
  final Map<DateTime, int> datasets;
  final DateTime startDate;

  const MyHabitMap(
      {super.key, required this.startDate, required this.datasets});

  @override
  Widget build(BuildContext context) {
    return HeatMap(
        startDate: startDate,
        endDate: DateTime.now().add(Duration(days: 13)),
        datasets: datasets,
        colorMode: ColorMode.color,
        defaultColor: Colors.white70,
        textColor: Provider.of<ThemeProvider>(context).isDarkMode
            ? Colors.white
            : Color(0xff354a7f),
        showColorTip: false,
        showText: true,
        scrollable: true,
        borderRadius: 8.0,
        size: 32,
        margin: EdgeInsets.all(8.0),
        colorsets: {
          1: Colors.blue.shade100,
          2: Colors.blue.shade200,
          3: Colors.blue.shade200,
          4: Colors.blue.shade200,
          5: Colors.blue.shade100,
        }


        );
  }
}
