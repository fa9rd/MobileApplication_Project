import 'package:flutter/cupertino.dart';

class MeetingData {
  final Key key;
  final String svId;
  final String studentId;
  final String notes;
  final String progress;
  final DateTime dateTime;
  final String nextMeeting;

  MeetingData({@required this.key, this.svId , this.studentId , @required this.notes,@required this.progress ,@required this.dateTime, this.nextMeeting });
}