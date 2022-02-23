// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project2/screens/CheckUser.dart';
import '../widgets/field.dart';
import '../animation/animations.dart';
import '../screens/signup_screen.dart';
import 'package:flutter/services.dart';
import 'package:project2/services/database.dart';


class LoginForm extends StatefulWidget {
  LoginForm(this.submitFn, this.isLoading);

  final bool isLoading;
  final void Function(
    String email,
    String password,
  ) submitFn;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _loginFormKey = GlobalKey<FormState>();
  final feature = ["Login", "Sign Up"];
  int i = 0;
  TextEditingController _userEmail = TextEditingController();
  TextEditingController _userPassword = TextEditingController();

  _LoginFormState();



  void _trySubmit() {
    final isValid = _loginFormKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _loginFormKey.currentState.save();
      print(_userEmail.text);
      print(_userPassword);
      widget.submitFn(_userEmail.text.toString(), _userPassword.text.toString());
      //Used to send auth request
    }
  }

  @override
  Widget build(BuildContext context) {
    final mail = '';
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            backgroundColor: Color(0xfffdfdfdf),
            body: i == 0
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(25),
                          child: Column(
                            children: [
                              //background(),

                              Row(
                                  // TabBar Code
                                  children: [
                                    Container(
                                      height: height / 17,
                                      width: width / 2,
                                      child: TopAnime(
                                        2,
                                        5,
                                        child: ListView.builder(
                                          itemCount: feature.length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  i = index;
                                                });
                                              },
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 20),
                                                    child: Text(
                                                      feature[index],
                                                      style: TextStyle(
                                                        color: i == index
                                                            ? Colors.black
                                                            : Colors.grey,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  i == index
                                                      ? Container(
                                                          height: 2.8,
                                                          width: width / 6,
                                                          color: Color.fromRGBO(
                                                              143, 148, 251, 5),
                                                        )
                                                      : Container(),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    Expanded(child: Container()),

                                    // Profile
                                    RightAnime(
                                      1,
                                      15,
                                      curve: Curves.easeInOutQuad,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(40),
                                        child: Container(
                                          width: 60,
                                          height: 60,
                                          color: Colors.red[400],
                                          child: i == 0
                                              ? Image(
                                            image: AssetImage(
                                                "assets/images/user.png"),
                                          )
                                              : Icon(
                                            Icons.account_circle_outlined,
                                            color: Colors.white,
                                            size: 40,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]
                              )
                              ,

                              SizedBox(
                                height: 50,
                              ),

                              // Top Text
                              Container(
                                padding: EdgeInsets.only(left: 15),
                                width: width,
                                child: TopAnime(
                                  1,
                                  20,
                                  curve: Curves.fastOutSlowIn,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "WELCOME BACK",
                                        style: TextStyle(
                                          color:
                                              Color.fromRGBO(143, 148, 251, 6),
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: height / 14,
                              ),

                              // TextFiled
                              Column(
                                children: [
                                  Container(
                                    width: width / 1.2,
                                    height: height / 3.10,
                                    //  color: Colors.red,
                                    child: TopAnime(
                                      1,
                                      15,
                                      curve: Curves.easeInExpo,
                                      child: Form(
                                        key: _loginFormKey,
                                        child: ListView(
                                          shrinkWrap: true,
                                          padding: EdgeInsets.all(10),
                                          children: [
                                            Field(
                                                "email",
                                                "!value.contains('@')",
                                                "Enter valid Email Address!",
                                                _userEmail,
                                                TextInputType.emailAddress,
                                                "Email",
                                                false),
                                            SizedBox(
                                              height: 25,
                                            ),
                                            Field(
                                                "password",
                                                "value.length < 8",
                                                "Password must be  at least 7 characters",
                                                _userPassword,
                                                TextInputType.visiblePassword,
                                                "password",
                                                true),

                                            SizedBox(
                                              height: 5,
                                            ),

                                            // FaceBook and Google ICon
                                            TopAnime(
                                              1,
                                              10,
                                              child: InkWell(
                                                onTap: (){},
                                                child: Row(
                                                  children: [
                                                    IconButton(
                                                      icon: FaIcon(
                                                        FontAwesomeIcons.googlePlusG,
                                                        size: 35,
                                                      ),
                                                      onPressed:(){
                                                        DatabaseService().signInWithGoogle();
                                                      },

                                                    ),
                                                    SizedBox(
                                                      width: 15,
                                                    ),
                                                    Text(
                                                      'Login with Google',
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 15),
                                                    ),


                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        // Bottom
                        i == 0
                            ? TopAnime(
                                2,
                                29,
                                curve: Curves.fastOutSlowIn,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(right: 15),
                                      child: GestureDetector(
                                        onTap: _trySubmit,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  143, 148, 251, 6),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          width: 150,
                                          height: height / 15,
                                          child: Center(
                                            child: Text(
                                                "Log IN",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                              ),
                                            ),
                                          )

                                          // Icon(
                                          //   Icons.arrow_forward,
                                          //   size: 35,
                                          //   color: Colors.white,
                                          // ),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        )
                            : SignUpScreen()
                      ],
                    ),
                  )
                : SignUpScreen()),
      ),
    );
  }
}
