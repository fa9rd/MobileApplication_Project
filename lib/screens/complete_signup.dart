import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project2/screens/CheckUser.dart';
import 'package:project2/services/database.dart';
import 'package:project2/widgets/field.dart';
import 'package:project2/widgets/signup_form.dart';

import 'dashboard.dart';

class CompleteSignUp extends StatefulWidget {
  final uid;

  CompleteSignUp({@required this.uid});

  @override
  _CompleteSignUpState createState() => _CompleteSignUpState();
}

class _CompleteSignUpState extends State<CompleteSignUp> {
  final _formKey = GlobalKey<FormState>();
  final _DropDownStateKey = DropDown();
  TextEditingController _userPhone = TextEditingController();
  TextEditingController _userWechat = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Student 1")),
      body: Container(
        child: ListView(
          clipBehavior: Clip.none,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Field(
                        "phone",
                        "!value.contains('@')",
                        "Enter valid Email Address!",
                        _userPhone,
                        TextInputType.phone,
                        "Phone Number",
                        false),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Field(
                        "wechat",
                        "!value.contains('@')",
                        "Enter valid Email Address!",
                        _userWechat,
                        TextInputType.text,
                        "Wechat ID",
                        false),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: _DropDownStateKey,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      child: Text("Save"),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          await DatabaseService(uid: widget.uid).updateUserData(
                              phone: _userPhone.text.toString(),
                              wechat: _userWechat.text.toString(),
                              type: _DropDownStateKey.choice);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CheckUser()),
                          );
                        }
                      },
                    ),


                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      child: Text("Cancel"),
                      onPressed: () async {
                        FirebaseAuth.instance.signOut();
                        GoogleSignIn().signOut();
                      },
                    ),


                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
