import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:project2/widgets/login_form.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitLoginForm(
    String email,
    String password,
  ) async {
    try {
      setState(() {
        _isLoading = true;
      });

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on PlatformException catch (err) {
      var massage = " Error please check your credentials !";

      if (err != null) {
        massage = err.message;
      }
      Scaffold.of(context).showSnackBar(
        SnackBar(
            content: Text(massage),
            backgroundColor: Theme.of(context).errorColor),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoginForm(
          _submitLoginForm,
          _isLoading,
        );
  }
}
