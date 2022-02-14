// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:project2/screens/dashboard.dart';
import 'screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges() ,
        builder: (ctx , snapshot) {
          if(snapshot.hasData){
            return Dashboard();
          }
          return LoginScreen();
        },
      ),
    );
  }
}
