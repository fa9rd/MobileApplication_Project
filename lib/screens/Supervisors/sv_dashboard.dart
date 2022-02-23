import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project2/screens/Supervisors/students_list.dart';
import 'package:project2/services/database.dart';

class SvDashboard extends StatefulWidget {
  final String code;
   SvDashboard({this.code});

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
                    //margin: EdgeInsets.all(5),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                    Center(
                      child: InkWell(
                        onTap: (){
                          Clipboard.setData(ClipboardData(text: widget.code));
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Invitation Code is copied Successfully!"),
                          ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 3,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(30,10,30,10),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        child: Text(widget.code, style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold
                                        ),),
                                      ),

                                    ),
                                    SizedBox(width: 70,),
                                    Icon(Icons.copy , color: Theme.of(context).primaryColor,),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
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
