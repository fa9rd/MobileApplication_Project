import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project2/screens/Supervisors/SingleStudentMeetings.dart';
import 'package:project2/screens/meeting_page.dart';
import 'package:project2/services/database.dart';

class Student extends StatelessWidget {
  Student({@required this.uid, @required this.name, @required this.email});

  final String uid;
  final String name;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(25),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(5.0),
            bottomRight: Radius.circular(5.0),
            topLeft: Radius.circular(5.0),
            bottomLeft: Radius.circular(5.0),
          ),
          color: Theme.of(context).primaryColor),
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
                      child: Image.asset("assets/images/student.png"),
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
                            title: Text("${name}"),

                            //subtitle: Text("01-02-2021"),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                child: Text(
                                  "Meetings",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 16),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SingleStudentMeetings(
                                              sv: DatabaseService().user.uid,
                                              uid: uid,
                                              name: name,
                                            )),
                                  );
                                },
                              ),
                              TextButton(
                                child: Text(
                                  "Profile",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 16),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SingleStudentMeetings(
                                          sv: DatabaseService().user.uid,
                                          uid: uid,
                                          name: name,
                                        )),
                                  );
                                },
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
          )),
    );
  }
}
