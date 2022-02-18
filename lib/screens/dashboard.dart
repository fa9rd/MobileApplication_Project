import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import './none.dart';
import 'complete_signup.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            title: Text("Student 1"),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.logout),
                tooltip: 'Logout',
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  GoogleSignIn().signOut();
                },
              ),


            ],
            backgroundColor: Theme.of(context).primaryColor,
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        //color: Color.fromRGBO(143, 148, 251, 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0),
                              topLeft: Radius.circular(10.0),
                              bottomLeft: Radius.circular(10.0),
                            ),
                            color: Theme.of(context).primaryColor
                        ),
                        child: Card(
                          elevation: 8,
                          margin: EdgeInsets.all(10),
                          child: Container(
                            height: 100,
                            color: Colors.white,
                            child: Row(
                              children: [
                                Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(1),
                                    child: Expanded(
                                      child: Image.asset(
                                          "assets/images/meeting.png"),
                                      flex: 2,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.topLeft,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: ListTile(
                                            title: Text("Meeting 1"),
                                            subtitle: Text("01-02-2021"),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              TextButton(
                                                child: Text(
                                                  "View",
                                                  style: TextStyle(
                                                      color: Theme.of(context).primaryColor,
                                                      fontSize: 16),
                                                ),
                                                onPressed: () {
                                                  // Navigator.push(
                                                  //   context,
                                                  //   MaterialPageRoute(
                                                  //       builder: (context) =>
                                                  //           const meeting()),
                                                  // );
                                                },
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              TextButton(
                                                child: Text(
                                                  "ayo",
                                                  style: TextStyle(
                                                      color: Theme.of(context).primaryColor,
                                                      fontSize: 16),
                                                ),
                                                onPressed: () {},
                                              ),
                                              SizedBox(
                                                width: 8,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  flex: 8,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
