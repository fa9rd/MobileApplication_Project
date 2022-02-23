import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project2/services/database.dart';
import 'package:project2/widgets/field.dart';
import 'package:intl/intl.dart';
import 'package:project2/widgets/meeting.dart';

class UpdateMeeting extends StatefulWidget {
  final Meeting meeting;

  UpdateMeeting({@required this.meeting});

  @override
  _UpdateMeetingState createState() => _UpdateMeetingState();
}

class _UpdateMeetingState extends State<UpdateMeeting> {
  final _formKey = GlobalKey<FormState>();


  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedStartTime = TimeOfDay.now();
  TimeOfDay selectedEndTime = TimeOfDay.now();
  TextEditingController _title = TextEditingController();
  TextEditingController _notes = TextEditingController();
  TextEditingController _progress = TextEditingController();
  TextEditingController _textControllerDate =  TextEditingController();
  TextEditingController _textControllerStartTime =  TextEditingController();
  TextEditingController _textControllerEndTime =  TextEditingController();


  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2050),
    );
    if (picked != null ) {
      setState(() {
        selectedDate = picked;
        _textControllerDate.text = DateFormat.yMMMMd().format(selectedDate).toString();
        print("date ${_textControllerDate.text}");
      });
    }
  }

  _selectStartTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedStartTime,
    );
    if (picked != null  ) {
      setState(() {
        selectedStartTime = picked;
        _textControllerStartTime.text = selectedStartTime.format(context);
      });
    } else {
      setState(() {
        _textControllerStartTime.text = selectedStartTime.format(context);
      });
    }
  }

  _selectEndTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedEndTime,
    );
    if (picked != null ) {
      setState(() {
        selectedEndTime = picked;
        _textControllerEndTime.text = selectedEndTime.format(context);
      });
    } else {
      setState(() {
        _textControllerEndTime.text = selectedEndTime.format(context);
      });
    }
  }

  @override
  void initState() {
    DateTime startTime = widget.meeting.nextMeetingStart.toDate();
    DateTime endTime = widget.meeting.nextMeetingEnd.toDate();

    selectedStartTime = TimeOfDay.fromDateTime(startTime);
    selectedEndTime = TimeOfDay.fromDateTime(endTime);
    String dateString = DateFormat.yMMMMd().format(startTime);
    String startString = DateFormat.jm().format(startTime);
    String endString = DateFormat.jm().format(endTime);
     _title = TextEditingController(text: widget.meeting.title);
     _notes = TextEditingController(text: widget.meeting.notes);
     _progress = TextEditingController(text: widget.meeting.progress);
     _textControllerDate =  TextEditingController(text:dateString);
     _textControllerStartTime =  TextEditingController(text:startString);
     _textControllerEndTime =  TextEditingController(text:endString);
  }
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
                child: Text("Insert Meeting Data"),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
                      child: Field("title", " ", "Title can not be empty",
                          _title, TextInputType.text, "Title", false),
                    ),
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
                    TextField(
                      cursorColor: Theme.of(context).primaryColor,
                      controller: _textControllerDate,
                      textCapitalization: TextCapitalization.characters,
                      onTap: () => _selectDate(this.context),
                      readOnly: true,
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                      decoration: new InputDecoration(
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor, width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor, width: 2),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                          BorderSide(color: Colors.redAccent, width: 2),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        contentPadding: EdgeInsets.only(
                          left: 16,
                          bottom: 16,
                          top: 16,
                          right: 16,
                        ),
                        hintText: 'eg: September 10, 2020',
                        hintStyle: TextStyle(
                          color: Colors.grey.withOpacity(0.6),
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                        errorStyle: TextStyle(
                          fontSize: 12,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    RichText(
                      text: TextSpan(
                        text: 'Start Time',
                        style: TextStyle(
                          color: Colors.white60,
                          fontFamily: 'Raleway',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '*',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 28,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      cursorColor: Theme.of(context).primaryColor,
                      controller: _textControllerStartTime,
                      onTap: () => _selectStartTime(context),
                      readOnly: true,
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                      decoration: new InputDecoration(
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor, width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor, width: 2),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                          BorderSide(color: Colors.redAccent, width: 2),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        contentPadding: EdgeInsets.only(
                          left: 16,
                          bottom: 16,
                          top: 16,
                          right: 16,
                        ),
                        hintText: 'eg: 09:30 AM',
                        hintStyle: TextStyle(
                          color: Colors.grey.withOpacity(0.6),
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                        errorStyle: TextStyle(
                          fontSize: 12,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    RichText(
                      text: TextSpan(
                        text: 'End Time',
                        style: TextStyle(
                          color: Colors.white60,
                          fontFamily: 'Raleway',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '*',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 28,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      cursorColor: Theme.of(context).primaryColor,
                      controller: _textControllerEndTime,
                      onTap: () => _selectEndTime(context),
                      readOnly: true,
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                      decoration: new InputDecoration(
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor, width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor, width: 2),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                          BorderSide(color: Colors.redAccent, width: 2),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        contentPadding: EdgeInsets.only(
                          left: 16,
                          bottom: 16,
                          top: 16,
                          right: 16,
                        ),
                        hintText: 'eg: 11:30 AM',
                        hintStyle: TextStyle(
                          color: Colors.grey.withOpacity(0.6),
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                        errorStyle: TextStyle(
                          fontSize: 12,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
                      child: GestureDetector(
                        onTap: () async {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            if (selectedDate != null &&
                                selectedStartTime != null &&
                                selectedEndTime != null &&
                                _title != null) {
                              int startTimeInEpoch = DateTime(
                                selectedDate.year,
                                selectedDate.month,
                                selectedDate.day,
                                selectedStartTime.hour,
                                selectedStartTime.minute,
                              ).millisecondsSinceEpoch;
                              int endTimeInEpoch = DateTime(
                                selectedDate.year,
                                selectedDate.month,
                                selectedDate.day,
                                selectedEndTime.hour,
                                selectedEndTime.minute,
                              ).millisecondsSinceEpoch;

                              print(
                                  'DIFFERENCE: ${endTimeInEpoch - startTimeInEpoch}');

                              print(
                                  'Start Time: ${DateTime.fromMillisecondsSinceEpoch(startTimeInEpoch)}');
                              print(
                                  'End Time: ${DateTime.fromMillisecondsSinceEpoch(endTimeInEpoch)}');

                              await DatabaseService().updateMeeting(
                                  sid: widget.meeting.studentId,
                                  docid: widget.meeting.id,
                                  evid:widget.meeting.eventId,
                                  title :_title.text.toString(),
                                  notes: _notes.text.toString(),
                                  progress: _progress.text.toString(),
                                  startTime:
                                  DateTime.fromMillisecondsSinceEpoch(
                                      startTimeInEpoch),
                                  endTime: DateTime.fromMillisecondsSinceEpoch(
                                      endTimeInEpoch));
                            }
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
                              "Update Meeting",
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
