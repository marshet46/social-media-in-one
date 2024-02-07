import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

import 'home.dart';

class Splashscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      title: 'Flutter Animated Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnimatedSplashScreen(
        duration: 3000,
        splash: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                verticalDirection: VerticalDirection.down,
                children: [
                  Image.asset(
                    'assets/logo.png',
                    height: constraints.maxHeight * 0.2, // Responsive height
                  ),
                  SizedBox(height: constraints.maxHeight * 0.02), // Adjust spacing
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      'All Social Media in one',
                      style: TextStyle(
                        fontSize: screenWidth * 0.1, // Responsive text size
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        nextScreen: Home(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Colors.white,
      ),
    );
  }
}
