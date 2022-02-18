import 'package:flutter/material.dart';
import 'Animation/FadeAnimation.dart';
import './screens/login_screen.dart';
import '../animation/animations.dart';
class background extends StatefulWidget {
  const background({ Key key }) : super(key: key);

  @override
  _backgroundState createState() => _backgroundState();
}

class _backgroundState extends State<background> {

final i = new LoginScreen();

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    // final height = MediaQuery.of(context).size.height;
    // final feature = ["Login", "Sign Up"];
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.blue.shade200,
              Colors.purple[200],
            ],
            // stops: [0.2, 0.8, 1],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
    );
  }
}