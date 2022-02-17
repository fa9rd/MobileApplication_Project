import 'package:flutter/material.dart';
import './single_meeting_page.dart';

class Student extends StatefulWidget {
  const Student({ Key key }) : super(key: key);

  @override
  _StudentState createState() => _StudentState();
}

class _StudentState extends State<Student> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Color(0xfffdfdfdf),
      appBar:  AppBar(
        title: Text("Student 1"),
        actions: [
          GestureDetector(
            onTap: (){},
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xffEB5757),
                  borderRadius:
                  BorderRadius.circular(20)),
              width: 40,
              height: 40,
              child: Icon(
                Icons.logout,
                size: 25,
                color: Colors.white,
              ),
            ),
          ),
        ],
        backgroundColor: Color.fromRGBO(143, 148, 251, 5),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
                //margin: EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Student details: ",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ],
          ),
      ),
      Expanded(
        
        child: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
        ListTile( title: Text("Name"), leading: Icon(Icons.supervised_user_circle)),
        ListTile( title: Text("Email"), leading: Icon(Icons.email)),
        ListTile( title: Text("Phone number"), leading: Icon(Icons.phone)),
        ListTile( title: Text("Whatsapp"), leading: Icon(Icons.chat))
      ],
          ),
      ),
      Container(
                //margin: EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Meetings: ",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ],
          ),
      ),
      SizedBox(height: 20,),
      Row(
        children: [
          	
  ElevatedButton(
    child: Text('Add Meeting'),
    style: ElevatedButton.styleFrom(
      primary: Color.fromRGBO(143, 80, 251, 5),
      onPrimary: Colors.white,
      onSurface: Colors.grey,
    ),
    onPressed: () {
      print('Pressed');
    },
  )
        ],
      ),
      Container(
        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0),
                              topLeft: Radius.circular(10.0),
                              bottomLeft: Radius.circular(10.0),
                            ),
                            color: Color.fromRGBO(143, 148, 251, 5)),
        child: Card(
                            elevation: 8,
                            margin: EdgeInsets.all(10),
                            child: Container(
                              height: 100,
                              color: Colors.white,
                              child: Row(
                                children: [
                                  Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(1),
                                      child: Expanded(
                                        child: Image.asset(
                                            "assets/images/meeting.png"),
                                        flex: 2,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.topLeft,
                                      child: Column(
                                        children: [
                                          Expanded(
                                            flex: 5,
                                            child: ListTile(
                                              title: Text("Meeting 1"),
                                              subtitle: Text("01-02-2021"),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 5,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                TextButton(
                                                  child: Text(
                                                    "View",
                                                    style: TextStyle(
                                                        color: Colors.purple[700],
                                                        fontSize: 16),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const SingleMeetingPage()),
                                                    );
                                                  },
                                                ),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                TextButton(
                                                  child: Text(
                                                    "ayo",
                                                    style: TextStyle(
                                                        color: Colors.purple[700],
                                                        fontSize: 16),
                                                  ),
                                                  onPressed: () {},
                                                ),
                                                SizedBox(
                                                  width: 8,
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    flex: 8,
                                  ),
                                ],
                              ),
                            ),
                            
                          ),
      )
        ]
    )
    );
  }
}