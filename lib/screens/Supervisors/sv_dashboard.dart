import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project2/screens/Supervisors/students_list.dart';
import 'package:project2/services/database.dart';
import '../single_meeting_page.dart';

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
                  GoogleSignIn().signOut();
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
                      Center(
                        child: Text(
                          "Students: ",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                          StudentsList(),
                    ])),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
