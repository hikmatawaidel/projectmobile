import 'dart:async';

import 'package:projectmobile/FlappyBird/flappybird.dart';
import 'package:projectmobile/homescreen.dart';

import 'barrier.dart';
import 'bird.dart';
import 'package:flutter/material.dart';

class HomeFlappyBird extends StatefulWidget {
  const HomeFlappyBird({super.key});

  @override
  State<HomeFlappyBird> createState() => _HomeFlappyBirdState();
}

class _HomeFlappyBirdState extends State<HomeFlappyBird> {
  static double birdY = 0;
  double initialPos = birdY;
  double height = 0;
  double time = 0;
  double gravity = -4.9;
  double velocity = 3;
  double birdWidth = 0.1;
  double birdHeight = 0.1;

  bool gameHasStarted= false;

  static List<double> barrierX = [2, 2+1.5];
  static double barrierWidth = 0.5;
  List<List<double>> barrierHeight = [
    [0.6, 0.4],
    [0.4, 0.6],
  ];

  void startGame(){
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      height = gravity * time * time + velocity * time;
      setState(() {
        birdY = initialPos - height;
      });

      if(birdDead()){
        timer.cancel();
        _showDialog();
      }

      moveMap();

      time += 0.01;
    });
  }

  void moveMap(){
    for(int i= 0; i < barrierX.length; i++){
      setState(() {
        barrierX[i] -= 0.005;
      });

      if(barrierX[i] < -1.5){
        barrierX[i] += 3;
      }
    }
  }

  void resetGame(){
    setState(() {
      birdY = 0;
      gameHasStarted = false;
      time = 0;
      initialPos = birdY;
    });
  }

  void _showDialog(){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            backgroundColor: Colors.brown,
            title: Center(
              child: Text(
                "G A M E O V E R",
                style: TextStyle(color: Colors.white),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: (){
                  Navigator.pushReplacement( // Use pushReplacement to replace the current screen
                      context,
                      MaterialPageRoute(builder: (context) => FlappyBird()));
                  resetGame();
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    padding: EdgeInsets.all(7),
                    color: Colors.white,
                    child: Text(
                      'PLAY AGAIN',
                      style: TextStyle(color: Colors.brown),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement( // Use pushReplacement to replace the current screen
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                  navigateToHomeScreen();
                  },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    padding: EdgeInsets.all(7),
                    color: Colors.white,
                    child: Text(
                      'QUIT',
                      style: TextStyle(color: Colors.brown),
                    ),
                  ),
                ),
              )
            ],
          );
        }
    );
  }

  void navigateToHomeScreen() {
    setState(() {
      birdY = 0;
      gameHasStarted = false;
      time = 0;
      initialPos = birdY;
      height = 0;
      gravity = -4.9;
      velocity = 3;
      birdWidth = 0.1;
      birdHeight = 0.1;
    });
  }
  void jump(){
    setState(() {
      time = 0;
      initialPos = birdY;
    });
  }

  bool birdDead(){
    if(birdY < -1 || birdY > 1){
      return true;
    }
    for(int i = 0; i < barrierX.length; i++){
      if(barrierX[i] <= birdWidth && barrierX[i] + barrierWidth >= -birdWidth && (birdY <= -1 + barrierHeight[i][0] || birdY + birdHeight >= 1 - barrierHeight[i][1])){
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gameHasStarted ? jump : startGame,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.blue,
                child: Center(
                  child: Stack(
                    children: [
                      MyBird(
                        birdY: birdY,
                        birdWidth: birdWidth,
                        birdHeight: birdHeight,
                      ),
                      Container(
                        alignment: Alignment(0, -0.5),
                        child: Text(
                          gameHasStarted ? '' : 'T A P  T O  P L A Y',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      MyBarrier(
                        barrierX: barrierX[0],
                        barrierWidth: barrierWidth,
                        barrierHeight: barrierHeight[0][0],
                        isThisBottomBarrier: false,
                      ),
                      MyBarrier(
                        barrierX: barrierX[0],
                        barrierWidth: barrierWidth,
                        barrierHeight: barrierHeight[0][1],
                        isThisBottomBarrier: true,
                      ),
                      MyBarrier(
                        barrierX: barrierX[1],
                        barrierWidth: barrierWidth,
                        barrierHeight: barrierHeight[1][0],
                        isThisBottomBarrier: false,
                      ),MyBarrier(
                        barrierX: barrierX[1],
                        barrierWidth: barrierWidth,
                        barrierHeight: barrierHeight[1][1],
                        isThisBottomBarrier: true,
                      ),

                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.brown,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
