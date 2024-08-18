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
                        image: AssetImage('assets/hab.png'))),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 600,left: 20),
                      child: Text('Habitat',style: TextStyle(
                        color: Colors.blue.shade700,
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                        letterSpacing: 2
                      ),),
                    ),
                    Text('Build Habits And Routines',style: TextStyle(
                        color: Colors.blue.shade700,

                        fontSize: 18,
                        letterSpacing: 2
                    ),),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
