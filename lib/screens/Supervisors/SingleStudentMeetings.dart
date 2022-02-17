import 'package:flutter/material.dart';
import 'package:project2/screens/meeting_page.dart';


class SingleStudentMeetings extends StatefulWidget {
  final String sv;
  final String uid;
  final String name;

  SingleStudentMeetings({@required this.sv, @required this.uid, this.name});

  @override
  _SingleStudentMeetingsState createState() => _SingleStudentMeetingsState();
}

class _SingleStudentMeetingsState extends State<SingleStudentMeetings> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            title: Text("${widget.name}"),
            backgroundColor: Theme.of(context).primaryColor,
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: MeetingsPage(sv: widget.sv, uid: widget.uid, name: widget.name,),
          ),
        ),
      ),
    );
  }
}
