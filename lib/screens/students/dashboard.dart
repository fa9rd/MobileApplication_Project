import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../single_meeting_page.dart';
import '../complete_signup.dart';
import 'accept_invitation.dart';
import 'package:project2/screens/meeting_page.dart';

class Dashboard extends StatefulWidget {
  final String uid;
  final String sv;
  final String fName;

  Dashboard({@required this.uid, @required this.sv, @required this.fName});

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
        body: Center(
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                  child: Text("Meetings List")),
              Expanded(
                  child: MeetingsPage(
                      sv: widget.sv,
                      uid: widget.uid.toString(),
                      name: widget.fName)),
            ],
            // ): SingleChildScrollView(child: AcceptSupervisorInvitation())
          ),
        ),
      ),
    ));
  }
}
