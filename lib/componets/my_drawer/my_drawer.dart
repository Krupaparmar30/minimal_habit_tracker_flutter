
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minimal_habit_tracker_flutter/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Center(
          child: CupertinoSwitch(
            value: Provider.of<ThemeProvider>(context,listen: true).isDarkMode,
            onChanged: (value) {
              Provider.of<ThemeProvider>(context,listen: false).toggleTheme();
            },
          )),
    );
  }
}