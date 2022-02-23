import 'package:flutter/material.dart';
import 'package:project2/screens/meeting_page.dart';
import 'package:project2/services/database.dart';

import 'add_meeting.dart';


class SingleStudentMeetings extends StatefulWidget {
  final String sv;
  final String uid;
  final String name;

  SingleStudentMeetings({@required this.sv, @required this.uid, this.name});

  @override
  _SingleStudentMeetingsState createState() => _SingleStudentMeetingsState();
}

class _SingleStudentMeetingsState extends State<SingleStudentMeetings> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            title: Text("${widget.name}"),
            backgroundColor: Theme.of(context).primaryColor,
            centerTitle: true,
          ),
          body: Container(
            child: ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
                  child: GestureDetector(
                    onTap: () {
                       Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddNewMeeting(sv: widget.sv, uid: widget.uid,)),
                    );
                       print(" the calender is : ${DatabaseService.theCalendar}");

                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(20)),
                      width: 250,
                      height: 50,
                      child: Center(
                        child: Text(
                          "Record a New Meeting",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Text("Meetings List")),
                MeetingsPage(sv: widget.sv, uid: widget.uid, name: widget.name,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
