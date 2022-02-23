import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class Comment extends StatefulWidget {
  final String meetingId;
  final String StudentName;
  final String text;
  final Timestamp datetime;
  const Comment({this.meetingId , this.StudentName , this.text , this.datetime});

  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
      child: ListTile(
        leading: GestureDetector(
          onTap: () async {
            // Display the image in large form.
            print("Comment Clicked");
          },
          child: Container(
            height: 50.0,
            width: 50.0,
            decoration: new BoxDecoration(
                color: Colors.blue,
                borderRadius: new BorderRadius.all(Radius.circular(50))),
            child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage("")),
          ),
        ),
        title: Text(
          "${widget.StudentName}",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text("${widget.text}",),
    )
    );
  }
}
