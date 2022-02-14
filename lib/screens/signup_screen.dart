import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:project2/widgets/signup_form.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitSignUpForm(
      String name,
      String email,
      String phone,
      String wechat,
      String password,
      ) async {
    UserCredential userCredential;
    try {
      setState(() {
        _isLoading = true;
      });
        userCredential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user.uid)
            .set({
          'name': name,
          'email': email,
          'phone':phone,
          'wechat':wechat
        });

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
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SignUpForm(
          _submitSignUpForm,
          _isLoading,
        ));
  }
}
