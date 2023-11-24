import 'package:flutter/material.dart';
import 'package:projectmobile/BubbleBobble/homeBubbleBobble.dart';

class Bubble extends StatelessWidget {
  const Bubble({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeBubble(),
    );
  }
}