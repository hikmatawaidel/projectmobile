import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projectmobile/homescreen.dart';
import 'package:projectmobile/RockPaperScissors/main_screen.dart';
import 'package:projectmobile/RockPaperScissors/game.dart';
import 'package:projectmobile/RockPaperScissors/game_button.dart';

int score = 0;

void resetScore() {
  score = 0;
}

class GameScreen extends StatefulWidget {
  GameScreen(this.gameChoice,{super.key});
 Choice gameChoice;
  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {

  void navigateToHomeScreen(){
    resetScore();
  }
  @override
  Widget build(BuildContext context) {
    double bttnWidth =MediaQuery.of(context).size.width /2-40;
    String? robotChoice= Game.randomChoice();
    String robotChoicePath="";
    switch(robotChoice){
      case"Rock":
        robotChoicePath="rock_btn2.png";
        break;
      case"Paper":
        robotChoicePath="paper_btn1.png";
        break;

      case"Scisors":
        robotChoicePath="scisor_btn1.png";
        break;
      default:

    }
    //Setting the Path to the Player Choice
    String? player_choice;
    switch(widget.gameChoice.type){
      case"Rock":
        player_choice="assets/rock_btn2.png";
        break;
      case"Paper":
        player_choice="assets/paper_btn1.png";
        break;

      case"Scisors":
        player_choice="assets/scisor_btn1.png";
        break;
      default:

    }
//Incrementing the Score if you win
    if(Choice.gameRule[widget.gameChoice.type]![robotChoice]=="You Win"){
      setState(() {
        Game.score++;
      });
    }

    return Scaffold(
      backgroundColor: Color(0xffd496de),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 34.0,horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white,width: 5.0,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("SCORE",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${Game.score}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            /* set the game pad to allow player to choose option*/
             Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height/2,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Hero(tag:"${widget.gameChoice.type}",
                            child: gameButton(null,player_choice!,bttnWidth
                            ),
                        ),
                        Text("VS",style: TextStyle(color: Colors.white,fontSize: 28.0),
                        ),
                        gameButton(null, robotChoicePath, bttnWidth),
                      ],
                    ),
                  )
              ),
            Text("${Choice.gameRule[widget.gameChoice.type]![robotChoice]}",style: TextStyle(
              color: Colors.white,
              fontSize: 36.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
            ),
            ),
            Container(
              width: double.infinity,

              child: RawMaterialButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MainScreen(),
                ));
              },
                padding: EdgeInsets.all(10.0),
                shape: StadiumBorder(side: BorderSide(color: Colors.white,
                    width: 5.0)),
                child: Text("Play Again",
                  style: TextStyle(color: Colors.white,fontSize: 28.0),

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}