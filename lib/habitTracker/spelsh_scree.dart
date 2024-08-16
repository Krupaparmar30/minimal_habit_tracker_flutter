import 'package:flutter/material.dart';

class spleshPage extends StatelessWidget {
  const spleshPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            GestureDetector(
              onDoubleTap: () {

                Navigator.of(context).pushNamed('/sec');
              },
              child: Container(
                height: 900,
                width: 500,
                decoration: BoxDecoration(

                    image: DecorationImage(
                      fit: BoxFit.cover,
                        image: AssetImage('assets/images/habit.png'))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
