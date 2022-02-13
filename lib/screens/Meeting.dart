// ignore_for_file: sdk_version_ui_as_code

import 'package:flutter/material.dart';
import 'package:comment_box/comment/comment.dart';

class meeting extends StatefulWidget {
  const meeting({Key key}) : super(key: key);

  @override
  _meetingState createState() => _meetingState();
}

class _meetingState extends State<meeting> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  List filedata = [
    {'name': '', 'pic': '', 'message': ''},
  ];

  Widget commentChild(data) {
    return ListView(
      children: [
        for (var i = 0; i < data.length; i++)
          Padding(
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
                      backgroundImage: NetworkImage(data[i]['pic'] + "$i")),
                ),
              ),
              title: Text(
                data[i]['name'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(data[i]['message']),
            ),
          )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meeting 1"),
        backgroundColor: Color.fromRGBO(143, 148, 251, 5),
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
            setState(() {
              var value = {
                'name': 'New User',
                'pic':
                    'https://lh3.googleusercontent.com/a-/AOh14GjRHcaendrf6gU5fPIVd8GIl1OgblrMMvGUoCBj4g=s400',
                'message': commentController.text
              };
              filedata.insert(0, value);
            });
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
