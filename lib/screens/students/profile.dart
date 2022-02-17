import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Ninja ID Card'),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
        elevation: 0.0,

      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
        onPressed: (){},
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
              'CURRENT LEVEL',
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'NingaLvl',
              style: TextStyle(
                color: Colors.amberAccent[200],
                letterSpacing: 2,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),

            Row(
              children: [
                Icon(
                    Icons.mail,
                    color:Colors.tealAccent
                ),
                SizedBox(width: 10),
                Text(
                  'fadiradman2211@gmail.com',
                  style: TextStyle(
                    color:Colors.amberAccent[200],
                    fontSize: 18,
                    letterSpacing: 1,
                  ),
                ),

              ],
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Icon(
                    Icons.phone_android,
                    color:Colors.tealAccent
                ),
                SizedBox(width: 10),
                Text(
                  '+60183117057',
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

