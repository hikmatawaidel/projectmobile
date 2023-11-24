import 'package:flutter/material.dart';
import 'package:projectmobile/BubbleBobble/BubbleBobble.dart';
import 'package:projectmobile/FlappyBird/flappybird.dart';
import 'package:projectmobile/RockPaperScissors/RockPaperScissors.dart';
import 'package:projectmobile/Snake/snake.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> games = ["Flappy Bird", "Snake", "Bubble Trouble","Rock paper scissors"];
  List<String> images = ["Bird.png","Snake.png","Bubble.png","Rock.png"];

  void navigateToGameScreen(int index) {
    switch (index) {
      case 0: // Flappy Bird game
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FlappyBird()),
        );
        break;
      case 1: // Flappy Bird game
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Snake()),
        );
        break;
      case 2: // Flappy Bird game
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Bubble()),
        );
        break;
      case 3: // Flappy Bird game
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyApp()),
        );
        break;
    // Add cases for other games
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
        appBar: AppBar(
          title: Text("Variety of Games", style: TextStyle(fontSize: 25),),
          backgroundColor: Colors.pinkAccent,
          centerTitle: true,
        ),
        body: Padding(
            padding: EdgeInsets.all(8),
            child: GridView.builder(
              itemCount: games.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height/1.2)
              ),
              itemBuilder: (BuildContext context, int index){
                return Padding(
                    padding: EdgeInsets.all(8),
                      child: GestureDetector(
                        onTap: () {
                          navigateToGameScreen(index);
                          },
                        child: Card(
                          child: Column(
                            children: <Widget> [
                              SizedBox(height: 20,),
                              Image.asset(images.elementAt(index), height: 80, width: 80,),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(games.elementAt(index), style: TextStyle(fontSize: 15,height: 1.5, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                              ),
                            ],
                          ),
                        ),
                      ),
                );
              },
            ),
        ),

    bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        selectedItemColor: Colors.pinkAccent,
      ),
    );
  }
}

