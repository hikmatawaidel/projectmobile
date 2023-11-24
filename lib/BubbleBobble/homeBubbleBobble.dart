import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projectmobile/homescreen.dart';
import 'package:projectmobile/BubbleBobble/player.dart';
import 'package:projectmobile/BubbleBobble/missile.dart';
import 'package:projectmobile/BubbleBobble/button.dart';
import 'package:projectmobile/BubbleBobble/ball.dart';


class HomeBubble extends StatefulWidget {
  const HomeBubble({super.key});

  @override
  State<HomeBubble> createState() => _HomeBubbleState();
}

enum direction {LEFT, RIGHT}

class _HomeBubbleState extends State<HomeBubble> {
  //player variables
  static double playerX = 0;

  //missile variables
  double missileX = playerX;
  double missileHeight = 10;
  bool midShot = false;

  //ball variables
  double ballX = 0.5;
  double ballY = 1;
  var ballDirection = direction.LEFT;

  void moveLeft(){
    setState(() {
      if(playerX - 0.1 < -1){}
      else {
        playerX -= 0.1;
      }
      if(!midShot){
        missileX = playerX;
      }
    });
  }

  void moveRight(){
    setState(() {
      if(playerX + 0.1 > 1){}
      else {
        playerX += 0.1;
      }
      missileX = playerX;
    });
  }

  void fireMissile(){
    if(midShot == false){
      Timer.periodic(Duration(milliseconds: 20), (timer) {
        //shots fired
        midShot = true;
        //missile goes till it hits top of the screen
        setState(() {
        missileHeight += 10;
        });
        //stop missile when it reaches top of screen
        if(missileHeight > MediaQuery.of(context).size.height * 3 / 4){
          resetMissile();
          timer.cancel();
        }

        //check if missile has hit the ball
        if(ballY > heightToPosition(missileHeight) && (ballX - missileX).abs() < 0.03){
          resetMissile();
          ballX = 5;
          timer.cancel();
        }
      });
    }
  }

  void resetMissile(){
    missileX = playerX;
    missileHeight = 0;
    midShot = false;
  }

  void startGame(){
    double time = 0;
    double height = 0;
    double velocity = 60;//how strong the ball jumps
      Timer.periodic(Duration(milliseconds: 10), (timer) {
        height = -5 * time * time + velocity * time;
        //if the ball reaches the ground reset the jump
        if(height < 0){
          time = 0;
        }
        //update the new ball position
        setState(() {
          ballY = heightToPosition(height);
        });

        // if the ball hits the left wall, then change directions is right
        if(ballX - 0.005 < -1){
          ballDirection = direction.RIGHT;
        }
        // if the ball hits the right wall, then change directions is left
        else if(ballX + 0.005 > 1){
          ballDirection = direction.LEFT;
        }
        // move the ball in the correct direction
        if(ballDirection == direction.LEFT){
          setState(() {
            ballX -= 0.005;
          });
        }else if(ballDirection == direction.RIGHT){
          setState(() {
            ballX += 0.005;
          });
        }

        //check if ball hits the player
        if(playerDie()){
          timer.cancel();
          _showDialog();
        }
        //keep the time going
        time += 0.1;
      });
  }

  bool playerDie(){
    //if the ball position and the player position
    //are the same, then player dies
    if((ballX - playerX).abs() < 0.05 && ballY > 0.95){
      return true;
    }else{
      return false;
    }
  }

  void _showDialog(){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            backgroundColor: Colors.grey,
            title: Text("Dead", style: TextStyle(color: Colors.white),),
            actions: [
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
                    color: Colors.pink[200],
                    child: Text(
                      'QUIT',
                      style: TextStyle(color: Colors.white),
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
      playerX = 0;

      //missile variables
      missileX = playerX;
      missileHeight = 10;
      midShot = false;

      //ball variables
      ballX = 0.5;
      ballY = 1;
      ballDirection = direction.LEFT;
    });
  }

  //converts height to a coordinate
  double heightToPosition(double height){
    double totalHeight = MediaQuery.of(context).size.height * 3 / 4;
    double position = 1 - 2 * height / totalHeight;
    return position;
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event){
        if(event.isKeyPressed(LogicalKeyboardKey.arrowLeft)){
          moveLeft();
        }else if(event.isKeyPressed(LogicalKeyboardKey.arrowRight)){
          moveRight();
        }
        if(event.isKeyPressed(LogicalKeyboardKey.space)){
          fireMissile();
        }
      },
      child: Column(
        children: [
          Expanded(
            flex: 3,
              child: Container(
                color: Colors.pink[200],
                child: Center(
                  child: Stack(
                    children: [
                      MyBall(
                          ballX: ballX,
                          ballY: ballY
                      ),
                      MyMissile(
                        height: missileHeight,
                        missileX: missileX,
                      ),
                      MyPlayer(
                        playerX: playerX,
                      ),
                    ],
                  ),
                ),
              )
          ),
          Expanded(
              child: Container(
                color: Colors.grey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MyButton(icon: Icons.play_arrow, function: startGame,),
                    MyButton(icon: Icons.arrow_back, function: moveLeft,),
                    MyButton(icon: Icons.arrow_upward, function: fireMissile,),
                    MyButton(icon: Icons.arrow_forward, function: moveRight,),
                  ],
                ),
              )
          ),
        ],
      ),
    );
  }
}
