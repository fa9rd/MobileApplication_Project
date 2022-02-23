import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project2/screens/Oldstudents.dart';
import 'package:project2/services/database.dart';
import './none.dart';

class SvDashboard extends StatefulWidget {
  const SvDashboard({Key key}) : super(key: key);

  @override
  _SvDashboardState createState() => _SvDashboardState();
}

class _SvDashboardState extends State<SvDashboard> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            title: Text("Dashboard"),
            backgroundColor: Theme.of(context).primaryColor,
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.logout),
                tooltip: 'Logout',
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  DatabaseService().handleSignOut();

                },
              ),


            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.all(25),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [])),
                Container(
                    //margin: EdgeInsets.all(5),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text(
                        "Students: ",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ])),
                Container(
                  margin: EdgeInsets.all(25),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(5.0),
                        bottomRight: Radius.circular(5.0),
                        topLeft: Radius.circular(5.0),
                        bottomLeft: Radius.circular(5.0),
                      ),
                      color: Theme.of(context).primaryColor),
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
                                  child:
                                      Image.asset("assets/images/student.png"),
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
                                        title: Text("Student 1"),
                                        //subtitle: Text("01-02-2021"),
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
                                              "Details",
                                              style: TextStyle(
                                                  color: Theme.of(context).primaryColor,
                                                  fontSize: 16),
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const Students()),
                                              );
                                            },
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
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
