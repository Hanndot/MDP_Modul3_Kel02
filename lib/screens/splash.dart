import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:mod3_kel02/screens/home.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Image.asset(
        'assets/images/splash_image.png',
      ),
      nextScreen: HomePage(),
      splashTransition: SplashTransition.decoratedBoxTransition,
      backgroundColor: Colors.grey,
      duration: 3000,
    );
  }
}
