import 'package:flutter/material.dart';

import 'game_page.dart';


class Snake extends StatelessWidget {

  const Snake({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: SankeGamePage(),
    );
  }
}

