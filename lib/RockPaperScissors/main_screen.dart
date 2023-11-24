import 'package:flutter/material.dart';
import 'package:projectmobile/homescreen.dart';
import 'package:projectmobile/RockPaperScissors/game_screen.dart';
import 'package:projectmobile/RockPaperScissors/game_button.dart';
import 'package:projectmobile/RockPaperScissors/game.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {


  /* set a width for the button so it can be addaptable to each  screen size */
  @override
  Widget build(BuildContext context) {
    double bttnWidth =MediaQuery.of(context).size.width /2-40;
    
    return Scaffold(

      backgroundColor: Color(0xffd496de),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 34.0,horizontal: 20.0),
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
                child: Stack(
                  children: [
                    /*create a custom widget for the button*/
                    Positioned(
                         top:0,
                        left:
                        MediaQuery.of(context).size.width/2-bttnWidth/ 2-20,
                        child: Hero(
                          tag: "Rock",
                          child: gameButton(() {
                            print("Tou choosed Rock!");
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>GameScreen(Choice("Rock"),
                            ),
                            ));
                          },"assets/rock_btn2.png", bttnWidth),
                        ),
                    ),
                    Positioned(
                      top: bttnWidth,
                      left:
                      MediaQuery.of(context).size.width /2 -
                          bttnWidth-40,
                      child: Hero(
                        tag: "Paper",
                        child: gameButton(() {
                          print("Tou choosed Paper!");
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>GameScreen(Choice("Paper"),
                          ),
                          ));
                        },"assets/paper_btn1.png", bttnWidth),
                      ),
                    ),
                    Positioned(
                      top: bttnWidth,
                      right:
                      MediaQuery.of(context).size.width /2 -bttnWidth -40,
                      child: Hero(
                        tag: "Scisors",
                        child: gameButton(() {
                          print("Tou choosed Scisor!");
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>GameScreen(Choice("Scisors"),
                          ),
                          ));
                        },"assets/scisor_btn1.png", bttnWidth),
                      ),
                    ),
                  ],
                ),
              )
            ),

            Container(
              width: double.infinity,
              
              child: RawMaterialButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(),
              ));
                },
                  padding: EdgeInsets.all(16.0),
                  shape: StadiumBorder(side: BorderSide(color: Colors.white,
                  width: 5.0)),
                  child: Text("QUIT",
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
