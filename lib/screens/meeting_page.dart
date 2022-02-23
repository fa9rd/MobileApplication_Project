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
    return Expanded(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 30, 20, 5),
        child: Column(
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("meetings")
                  .where("studentId", isEqualTo: uid)
                  .snapshots(),
              builder: (ctx, meetingsSnapshot) {
                if (meetingsSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final meetings = meetingsSnapshot.data.docs;

                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: meetings.length,
                  itemBuilder: (ctx, index) => Meeting(
                      id: meetings[index].id,
                      eventId:meetings[index]['eventId'],
                      title: meetings[index]['title'],
                      studentId: meetings[index]['studentId'],
                      notes: meetings[index]['notes'],
                      progress: meetings[index]['progress'],
                      dateTime: meetings[index]['dateTime'],
                      nextMeetingStart: meetings[index]['nextMeetingStart'],
                      nextMeetingEnd: meetings[index]['nextMeetingEnd']),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
