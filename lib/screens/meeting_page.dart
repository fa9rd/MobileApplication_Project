import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project2/screens/single_meeting_page.dart';
import 'package:project2/services/database.dart';
import 'package:project2/widgets/meeting.dart';

class MeetingsPage extends StatelessWidget {
  final String sv;
  final String uid;
  final String name;

  MeetingsPage({@required this.sv, @required this.uid, this.name});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Text("Meetings  List: ")),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(uid)
                .collection("meetings")
                .snapshots(),
            builder: (ctx, meetingsSnapshot) {
              if (meetingsSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final meetings = meetingsSnapshot.data.docs;

              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                reverse: true,
                itemCount: meetings.length,
                itemBuilder: (ctx, index) => Meeting(
                  key: ValueKey(meetings[index].id),
                  svId: sv,
                  studentId: uid,
                  notes: meetings[index]['notes'],
                  progress: meetings[index]['progress'],
                  dateTime: meetings[index]['dateTime'],
                  nextMeeting: meetings[index]['nextMeeting'],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
