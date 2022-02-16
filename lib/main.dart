// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:project2/screens/CheckUser.dart';
import 'package:project2/screens/complete_signup.dart';
import 'package:project2/screens/dashboard.dart';
import 'package:project2/services/database.dart';
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
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            return CheckUser();
          }
          return LoginScreen();
        },
      ),
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.light,
        primaryColor: Colors.purple[700],
        backgroundColor: Color(0xfffdfdfdf),

        // Define the default font family.
        fontFamily: 'Georgia',
      ),
    );
  }
}
