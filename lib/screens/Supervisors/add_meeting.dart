import 'package:flutter/material.dart';
import 'package:project2/services/database.dart';
import 'package:project2/widgets/field.dart';

class AddNewMeeting extends StatefulWidget {
  final Key key;
  final String sv;
  final String uid;

  AddNewMeeting({this.key, this.sv, this.uid});

  @override
  _AddNewMeetingState createState() => _AddNewMeetingState();
}

class _AddNewMeetingState extends State<AddNewMeeting> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _notes = TextEditingController();
  TextEditingController _progress = TextEditingController();
  TextEditingController _nextMeeting = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text("Add New Meeting"),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
                child: Text(
                    "Insert Meeting Data"),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
                      child: Field("notes", " ", "Noted can not be empty",
                          _notes, TextInputType.multiline, "Notes", false),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
                      child: Field(
                          "progress",
                          " ",
                          "Progress can not be empty",
                          _progress,
                          TextInputType.multiline,
                          "Progress ",
                          false),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
                      child: Field(
                          "nextMeeting",
                          " ",
                          "Next Meeting can not be empty",
                          _nextMeeting,
                          TextInputType.datetime,
                          "Next Meeting",
                          false),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
                      child: GestureDetector(
                        onTap: () async {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            await DatabaseService().addMeeting(
                              sid: widget.uid.toString(),
                              notes: _notes.text.toString(),
                              progress: _progress.text.toString(),
                              nextMeeting: _nextMeeting.text.toString(),
                            );
                            Navigator.pop(context);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(20)),
                          width: 250,
                          height: 50,
                          child: Center(
                            child: Text(
                              "Add Meeting",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
