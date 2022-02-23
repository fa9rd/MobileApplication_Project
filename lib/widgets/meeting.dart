import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project2/screens/Supervisors/update_meeting.dart';
import 'package:project2/screens/single_meeting_page.dart';
import 'package:project2/services/database.dart';


class Meeting extends StatefulWidget {
  Meeting({@required this.id ,this.title,this.eventId, @required this.studentId , @required this.notes,@required this.progress ,@required this.dateTime, this.nextMeetingStart, this.nextMeetingEnd });
  final String id;
  final String title;
  final String eventId;
  final String studentId;
  final String notes;
  final String progress;
  final Timestamp dateTime;
  final Timestamp nextMeetingStart;
  final Timestamp nextMeetingEnd;

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
            child: InkWell(
              onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SingleMeetingPage(meeting: this.widget,)),
                  );

              },
              child: Card(
                elevation: 8,
                margin: EdgeInsets.all(8),
                child: Container(
                  height: 131,
                  color: Colors.white,
                  child: Row(
                    children: [
                      Center(
                        child: Padding(
                          padding: EdgeInsets.all(1),
                          child: Image.asset(
                              "assets/images/meeting.png"),
                        ),
                      ),

                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(widget.title),
                                subtitle: Text("${widget.dateTime.toDate().day}-${widget.dateTime.toDate().month}-${widget.dateTime.toDate().year}"),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    child: Text(
                                      "Modify",
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 16),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                            UpdateMeeting(meeting: this.widget,)),
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    color: Theme.of(context).primaryColor,
                                    tooltip: 'Delete',
                                    onPressed: () {
                                      DatabaseService().deleteMeeting(widget.eventId , widget.id);
                                    },
                                  ),
                                  SizedBox(
                                    width: 8,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
