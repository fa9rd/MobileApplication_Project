import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class Meeting extends StatefulWidget {
  Meeting({@required this.key , @required this.studentId , @required this.notes,@required this.progress ,@required this.dateTime, this.nextMeeting });
  final Key key;
  final String studentId;
  final String notes;
  final String progress;
  final Timestamp dateTime;
  final Timestamp nextMeeting;

  @override
  _MeetingState createState() => _MeetingState();
}

class _MeetingState extends State<Meeting> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(15,8,15,8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            //color: Color.fromRGBO(143, 148, 251, 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                ),
                color: Theme.of(context).primaryColor
            ),
            child: Card(
              elevation: 8,
              margin: EdgeInsets.all(8),
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
                                subtitle: Text("${widget.dateTime.toDate().day}-${widget.dateTime.toDate().month}-${widget.dateTime.toDate().year}"),
                              ),
                            ),
                            SizedBox(
                              height: 38,
                            ),
                            Expanded(
                              flex: 10,
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    child: Text(
                                      "View",
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 16),
                                    ),
                                    onPressed: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //       builder: (context) =>
                                      //       const meeting()),
                                      // );
                                    },
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  TextButton(
                                    child: Text(
                                      "ayo",
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
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
          ),
        ],
      ),
    );
  }
}
