import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:projectmobile/homescreen.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState(){
    var initState = super.initState();
    _navigatetohome();
  }
  _navigatetohome()async {
    await Future.delayed(Duration(milliseconds: 10000));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  const HomeScreen()));
  }
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("animated.jpeg"), fit: BoxFit.fill),
      ),
      child:  Container(
        child: Lottie.network('https://lottie.host/efdd97f8-0099-4d94-ba19-e34c63791817/TO6p0Ushy4.json'),
      ),
    );
  }
}