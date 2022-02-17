import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../single_meeting_page.dart';
import '../complete_signup.dart';
import 'accept_invitation.dart';
import '../meeting_page.dart';

class Dashboard extends StatefulWidget {
  final String uid;
  final String sv;
  final String fName;
  Dashboard({@required this.uid ,@required this.sv ,@required this.fName});

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
            title: Text("${widget.fName}"),
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
          child: (widget.sv != null ? MeetingsPage(sv: widget.sv ,uid: widget.uid,name: widget.fName) : AcceptSupervisorInvitation()),
          ),
        ),
      ),
    );
  }
}
