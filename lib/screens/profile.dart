// ignore_for_file: file_names, avoid_print
// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({ Key? key }) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
   
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
        onPressed: (){
          print('edit');
        },

      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/photo-2.jpg'),
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
              'Fadi',
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
              'ID25',
              style: TextStyle(
                color: Colors.amberAccent[200],
                letterSpacing: 2,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),

            Row(
              children: [
                Icon(
                  Icons.mail,
                   color:Colors.tealAccent
                ),
                SizedBox(width: 10),
                Text(
                  'gmailgamil@gmail.com',
                style: TextStyle(
                  color:Colors.amberAccent[200],
                  fontSize: 18,
                  letterSpacing: 1,
                ),
                ),

              ],
            ),
             SizedBox(height: 20),
             Row(
              children: [
                Icon(
                  Icons.phone_android,
                   color:Colors.tealAccent
                ),
                SizedBox(width: 10),
                Text(
                  '+6011111111',
                style: TextStyle(
                  color:Colors.amberAccent[200],
                  fontSize: 18,
                  letterSpacing: 1,
                ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}