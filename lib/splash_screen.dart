import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:projectmobile/loading_screen.dart';
class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState(){
    super.initState();
    _navigatetoloading();
  }
  _navigatetoloading()async {
    await Future.delayed(Duration(milliseconds: 3000));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  const Loading()));
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.pinkAccent, Color(0x8C0228FF)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
        )
      ),
      child: Center(
        child: Image.asset(
          "assets/logo.png"
        ),
      ),
    ),
    );
  }
}
