// ignore_for_file: file_names, avoid_print
// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project2/services/database.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {
  final String sid;

  Profile({this.sid});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
        elevation: 2.0,
      ),
      floatingActionButton: FloatingActionButton(
        child: Text('Edit'),
        backgroundColor: Colors.tealAccent[700],
        onPressed: () {
          print('edit');
        },
      ),
      body: FutureBuilder<DocumentSnapshot>(
          future: users.doc(widget.sid).get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Something went wrong"),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data =
                  snapshot.data.data() as Map<String, dynamic>;
              return Padding(
                padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: CircleAvatar(
                        child: Text(data['name'][0], style: TextStyle(fontSize: 30),),
                        radius: 50,
                      ),
                    ),
                    Divider(
                      height: 50,
                      color: Colors.white70,
                    ),
                    Text(
                      'NAME',
                      style: TextStyle(
                        color: Colors.grey,
                        letterSpacing: 2,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '${data['name']}',
                      style: TextStyle(
                        color: Colors.amberAccent[200],
                        letterSpacing: 2,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Wechat ID',
                      style: TextStyle(
                        color: Colors.grey,
                        letterSpacing: 2,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '${data['wechat']}',
                      style: TextStyle(
                        color: Colors.amberAccent[200],
                        letterSpacing: 2,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    InkWell(
                      onTap: () =>  launch("mailto:${data['email']}"),
                      child: Row(
                        children: [
                          Icon(Icons.mail, color: Colors.tealAccent),
                          SizedBox(width: 10),
                          Text(
                            '${data['email']}',
                            style: TextStyle(
                              color: Colors.amberAccent[200],
                              fontSize: 18,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    InkWell(
                      onTap: () =>  launch("tel://+60${data['phone']}"),
                      child: Row(
                        children: [
                          Icon(Icons.phone_android, color: Colors.tealAccent),
                          SizedBox(width: 10),
                          Text(
                            '+60${data['phone']}',
                            style: TextStyle(
                              color: Colors.amberAccent[200],
                              fontSize: 18,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    InkWell(
                      onTap: () =>  launch("https://wa.me/${data['phone']}"),
                      child: Row(
                        children: [
                          Icon(Icons.chat, color: Colors.tealAccent),
                          SizedBox(width: 10),
                          Text(
                            '+60${data['phone']}',
                            style: TextStyle(
                              color: Colors.amberAccent[200],
                              fontSize: 18,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(
                // value: controller.value,
                color: Theme.of(context).primaryColor,
                semanticsLabel: 'Loading',
              ),
            );
          }),
    );
  }
}
