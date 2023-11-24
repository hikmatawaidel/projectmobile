import 'package:flutter/material.dart';
import 'package:projectmobile/FlappyBird/homeflappybird.dart';

class FlappyBird extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeFlappyBird(),
    );
  }
}
