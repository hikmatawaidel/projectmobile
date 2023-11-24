import 'dart:math';

class Game{
  static int score =0;
  //creating a list of option so the robot can choose randomly from it
static List<String> choices =["Rock","Paper","Scisors"];
static String? randomChoice(){
  Random random= new Random();
  int robotChoiceIndex=random.nextInt(3);//will choose an int from 0 to 2
  return choices[robotChoiceIndex];
}
}
class Choice{
  String? type ="";
  //crearing a map for the game Rules
  static var gameRule ={
    "Rock":{
      "Rock":"It's a Draw",
      "Paper":"You Lose",
      "Scisors":"You Win",
    },
    "Paper":{
    "Rock":"You Win",
    "Paper":"It's a Draw",
    "Scisors":"You Lose",
  },
    "Scisors":{
      "Rock":"You Lose",
      "Paper":"You Win",
      "Scisors":"It's a Draw",
    },
  };
  Choice(this.type);
}