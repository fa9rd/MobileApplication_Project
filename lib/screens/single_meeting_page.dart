// ignore_for_file: sdk_version_ui_as_code

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:project2/services/database.dart';
import 'package:project2/widgets/comment.dart';
import 'package:project2/widgets/meeting.dart';

class SingleMeetingPage extends StatefulWidget {
  final Meeting meeting;
  const SingleMeetingPage({this.meeting});

  @override
  _SingleMeetingPageState createState() => _SingleMeetingPageState();
}

class _SingleMeetingPageState extends State<SingleMeetingPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  List filedata = [
    {'name': '', 'pic': '', 'message': ''},
  ];

  Widget details(){
   return Padding(
     padding: const EdgeInsets.all(10),
     child: Card(
        elevation: 5,
        child: Column(
          children: [

            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Notes',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.amberAccent[200],

                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Text(
                  '${widget.meeting.notes}',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w200,
                  ),
                ),


              ],
            ),

            SizedBox(height: 10),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Progress',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.amberAccent[200],

                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Text(
                  '${widget.meeting.progress}',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w200,
                  ),
                ),


              ],
            ),

            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Next Meeting',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.amberAccent[200],

                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Date : ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.amberAccent[200],

                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${widget.meeting.nextMeetingStart.toDate().day}/${widget.meeting.nextMeetingStart.toDate().month}/${widget.meeting.nextMeetingStart.toDate().year}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,

                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 1, 20),
                  child: Text(
                    'From : ',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.amberAccent[200],

                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(2, 10, 1, 20),
                  child: Text(
                    '${widget.meeting.nextMeetingStart.toDate().hour} : ${widget.meeting.nextMeetingStart.toDate().minute}',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,

                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(70, 8, 8, 20),
                  child: Text(
                    'To : ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.amberAccent[200],

                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(2, 8, 20, 20),
                  child: Text(
                    '${widget.meeting.nextMeetingEnd.toDate().hour} : ${widget.meeting.nextMeetingEnd.toDate().minute}',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,

                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
   );
  }
  Widget commentChild(data) {
    return ListView(
      children: [
        details(),
        StreamBuilder(
          stream: DatabaseService().getComments(widget.meeting.id),
          builder: (ctx, studentsSnapshot) {
            if (studentsSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final comments = studentsSnapshot.data.docs;

            return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: comments.length,
              itemBuilder: (ctx, index) => Comment(
                StudentName: comments[index]['StudentName'],
                text: comments[index]['text'],
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.meeting.title}"),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
      ),
      body: CommentBox(
        userImage:
            "https://lh3.googleusercontent.com/a-/AOh14GjRHcaendrf6gU5fPIVd8GIl1OgblrMMvGUoCBj4g=s400",
        child: commentChild(filedata),
        labelText: 'Write a comment...',
        withBorder: false,
        errorText: 'Comment cannot be blank',
        sendButtonMethod: () {
          if (formKey.currentState.validate()) {
            print(commentController.text);
            DatabaseService().addComment(sid: FirebaseAuth.instance.currentUser.uid, mid: widget.meeting.id, text: commentController.text.toString());
            commentController.clear();
            FocusScope.of(context).unfocus();
          } else {
            print("Not validated");
          }
        },
        formKey: formKey,
        commentController: commentController,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        sendWidget: Icon(Icons.send_sharp, size: 30, color: Colors.white),
      ),
    );
  }
}
