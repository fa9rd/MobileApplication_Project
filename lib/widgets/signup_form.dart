// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project2/models/user.dart';
import 'package:project2/screens/complete_signup.dart';
import 'package:project2/services/database.dart';
import 'package:project2/widgets/field.dart';
import '../animation/animations.dart';
import '../screens/login_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project2/models/user.dart' as UserModel;
import '../background.dart';

class SignUpForm extends StatefulWidget {
  SignUpForm(this.submitFn, this.isLoading);

  final bool isLoading;
  final void Function(
    String name,
    String email,
    String phone,
    String wechat,
    String password,
    String userType
  ) submitFn;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _SignUpFormKey = GlobalKey<FormState>();
  final _DropDownStateKey = GlobalKey<_DropDownState>();
  final feature = ["Login", "Sign Up"];
  int i = 1;
  TextEditingController _userFullName = TextEditingController();
  TextEditingController _userEmail = TextEditingController();
  TextEditingController _userPhone = TextEditingController();
  TextEditingController _userWechat = TextEditingController();
  TextEditingController _userPassword = TextEditingController();
  TextEditingController _userPasswordConfirmation = TextEditingController();


  void _trySubmit() {
    final isValid = _SignUpFormKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _SignUpFormKey.currentState.save();
      if(_userPassword.text.toString() == _userPasswordConfirmation.text.toString()){
      widget.submitFn(
          _userFullName.text.toString(),
          _userEmail.text.toString(),
          _userPhone.text.toString(),
          _userWechat.text.toString(),
          _userPassword.text.toString(),
          _DropDownStateKey.currentState.valueChoose.toString());
      }
      else{
        print("passwords doesnot match");
      }
      //Used to send signup request
    }
  }



  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            backgroundColor: Color(0xfffdfdfdf),
            body: i == 1
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        // TabBar Code
                        Row(children: [
                          Container(
                            height: height / 15,
                            width: width / 2,
                            child: TopAnime(
                              2,
                              5,
                              child: ListView.builder(
                                itemCount: feature.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder:
                                    (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        i = index;
                                      });
                                    },
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 20),
                                          child: Text(
                                            feature[index],
                                            style: TextStyle(
                                              color: i == index
                                                  ? Colors.black
                                                  : Colors.grey,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
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
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                width: 60,
                                height: 60,
                                color: Colors.red[400],
                                child: i == 0
                                    ? Image(
                                        image: NetworkImage(
                                            "https://i.pinimg.com/564x/5d/a3/d2/5da3d22d08e353184ca357db7800e9f5.jpg"),
                                      )
                                    : Icon(
                                        Icons.account_circle_outlined,
                                        color: Colors.white,
                                        size: 40,
                                      ),
                              ),
                            ),
                          ),
                        ]),

                        SizedBox(
                          height: 30,
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
                                  "WELCOME ",
                                  style: TextStyle(

                                    color:
                                    Color.fromRGBO(143, 148, 251, 6),
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(
                          height: height / 20,
                        ),

                        // TextFiled
                        Container(
                          width: width / 1.2,
                          height: height / 2,
                          child: TopAnime(
                            1,
                            16,
                            curve: Curves.easeInExpo,
                            child: Form(
                              key: _SignUpFormKey,
                              child: ListView(
                                shrinkWrap: true,
                                padding: EdgeInsets.all(10),
                                children: [
                                  Field(
                                      "fullName",
                                      "!value.contains('@')",
                                      "Enter valid Email Address!",
                                      _userFullName,
                                      TextInputType.name,
                                      "Full Name",
                                      false),
                                  SizedBox(
                                    height: 25,
                                  ),
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
                                      "phone",
                                      "!value.contains('@')",
                                      "Enter valid Email Address!",
                                      _userPhone,
                                      TextInputType.phone,
                                      "Phone Number",
                                      false),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Field(
                                      "wechat",
                                      "!value.contains('@')",
                                      "Enter valid Email Address!",
                                      _userWechat,
                                      TextInputType.text,
                                      "Wechat ID",
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

                                  Field(
                                      "passwordConfirmation",
                                      _userPasswordConfirmation == _userPassword ,
                                      "Passwords does not match",
                                      _userPasswordConfirmation,
                                      TextInputType.visiblePassword,
                                      "Confirm Password",
                                      true),

                                  SizedBox(
                                    height: 5,
                                  ),
                                  DropDown(key: _DropDownStateKey),
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
                                  ),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.end,
                                  //   children: [
                                  //     Container(
                                  //       padding: EdgeInsets.only(right: 15),
                                  //       child: GestureDetector(
                                  //         onTap: _trySubmit,
                                  //         child: Container(
                                  //             decoration: BoxDecoration(
                                  //                 color: Color.fromRGBO(143, 148, 251, 6),
                                  //                 borderRadius:
                                  //                 BorderRadius.circular(20)),
                                  //             width: 150,
                                  //             height: height / 15,
                                  //             child: Center(
                                  //               child: Text(
                                  //                 "Sign up",
                                  //                 style: TextStyle(
                                  //                   fontSize: 20,
                                  //                   fontWeight: FontWeight.bold,
                                  //                   color: Colors.white,
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.only(right: 15),
                              child: GestureDetector(
                                onTap: _trySubmit,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(143, 148, 251, 6),
                                      borderRadius:
                                      BorderRadius.circular(20)),
                                  width: 150,
                                  height: height / 15,
                                  child: Center(
                                    child: Text(
                                      "Sign up",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                : LoginScreen()),
      ),
    );
  }
}

class DropDown extends StatefulWidget {
  String choice;
  DropDown({Key key,}) : super(key: key);


     get()=> _DropDownState(this.choice).valueChoose.toString();
  @override
  _DropDownState createState() => _DropDownState(choice);
}

class _DropDownState extends State<DropDown> {
  final items = ['Supervisor', 'Co-Supervisor', 'Student'];
  String valueChoose;
  _DropDownState(this.valueChoose);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: DropdownButtonFormField(
            hint: Text('User Type'),
            dropdownColor: Colors.white,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 20,
            isExpanded: true,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
            value: valueChoose ,
            onChanged: (newValue) {
              setState(() => valueChoose = newValue);
            },
              onSaved:(value){
              widget.choice = value.toString();
              },
              items: items.map((valueItem) {
              return DropdownMenuItem(
                value: valueItem,
                child: Text(valueItem),
              );
            }).toList(),

          ),
        ),
      ),
    );
  }
}
