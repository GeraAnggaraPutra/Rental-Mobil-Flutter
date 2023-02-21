import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rental_mobil_flutter/CheckAuth.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rental_mobil_flutter/Screens/Home.dart';
import 'package:rental_mobil_flutter/Screens/login.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Lottie.asset("assets/car_splash.json"),
      nextScreen: Login(),
      backgroundColor: Color.fromARGB(255, 1, 140, 20),
      splashIconSize: 250,
      duration: 3000,
      splashTransition: SplashTransition.sizeTransition,
      pageTransitionType: PageTransitionType.leftToRightWithFade,
      animationDuration: const Duration(seconds: 1),
    );
  }
}
