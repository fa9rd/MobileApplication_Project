import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:project2/models/meeting_data.dart';
import 'package:project2/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:googleapis_auth/googleapis_auth.dart' as auth show AuthClient;




class DatabaseService {
  final String uid;
  static var theCalendar;
  static String evId;
  static const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();
  static  GoogleSignIn _googleSignIn =  GoogleSignIn(
  // clientId: '[323266625944-eh81r1e1107lorcaveu52rdo419thunc.apps.googleusercontent.com]',
  scopes: <String>[CalendarApi.calendarScope],
  );
  DatabaseService({@required this.uid});


  //colection reference
  final CollectionReference UserCollection =
      FirebaseFirestore.instance.collection('users');

  final MeetingCollection = FirebaseFirestore.instance.collection('meetings');

  final user = FirebaseAuth.instance.currentUser;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void prompt(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));


  signInWithGoogle3() async {
    await _googleSignIn.signIn();

  }




   signInWithGoogle() async {
     // Trigger the authentication flow


     // GoogleSignInAccount user = await GoogleSignIn().signIn();
     await _googleSignIn.signIn();
     GoogleSignInAuthentication googleAuth = await _googleSignIn.currentUser
         .authentication;

     final credential = await GoogleAuthProvider.credential(
       accessToken: googleAuth.accessToken,
       idToken: googleAuth.idToken,
     );
     await FirebaseAuth.instance.signInWithCredential(credential);
   }

  Future<void> handleSignOut() async {
    return _googleSignIn.disconnect();
  }


  Future updateUserData(
      {@required String phone,
      @required String wechat,
      @required String type}) async {
    if (type == "Supervisor"){
      String invCode = getRandomString(16);
      return await UserCollection.doc(uid).set({
        'name': user.displayName,
        'email': user.email,
        'phone': phone,
        'wechat': wechat,
        'userType': type,
        'code': invCode
      });
    }
    else{
      return await UserCollection.doc(uid).set({
        'name': user.displayName,
        'email': user.email,
        'phone': phone,
        'wechat': wechat,
        'userType': type,

      });
    }

  }
  Future<Map> getStudentProfile(id) async {
    Map<String, dynamic> student;
      await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .get().asStream().map((event) {
          student['name'] = event.get('name');
          student['email'] = event.get('email');
          student['phone'] = event.get('phone');
          student['wechat'] = event.get('wechat');
        });

    return student;
  }

  Future<String> getStudentEmail(String id) async {
    var studentEmail = await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .get()
        .then((value) {
      print("email is  : ${value.data()['email']}");
      return value.data()['email']; // Access your after your get the data
    });
    return studentEmail;
  }
  // final String student_email = getStudentEmail(sid).toString();
  Future addMeeting({
    @required String sid,
    @required String title,
    @required String notes,
    @required String progress,
    @required DateTime startTime,
    @required DateTime endTime,

  }) async {
    var studentEmail = await FirebaseFirestore.instance
        .collection('users')
        .doc(sid)
        .get()
        .then((value) {
      print("email is  : ${value.data()['email']}");
      return value.data()['email']; // Access your after your get the data
    });

    String calendarId = "primary";
    Event event = Event();
    event.summary = title;
    print("uid : ${sid}");
    print("email : ${studentEmail.toString()}");
    print("start : ${startTime}");
    print("end : ${endTime}");
    final mail = studentEmail.toString();
    print("mmail : ${mail.toString()}");
    EventAttendee student = EventAttendee(email:mail );
      List<EventAttendee> attendeeEmails = [];
      attendeeEmails.add(student);
      event.attendees = attendeeEmails;
    ConferenceData conferenceData = ConferenceData();
    CreateConferenceRequest conferenceRequest = CreateConferenceRequest();
    conferenceRequest.requestId =
        "${startTime.millisecondsSinceEpoch}-${endTime.millisecondsSinceEpoch}";
    conferenceData.createRequest = conferenceRequest;

    event.conferenceData = conferenceData;

    EventDateTime start = new EventDateTime();
    start.dateTime = startTime;
    start.timeZone = "GMT+08";
    event.start = start;

    EventDateTime end = new EventDateTime();
    end.timeZone = "GMT+08";
    end.dateTime = endTime;
    event.end = end;
    // signForClander();

    if(await _googleSignIn.currentUser == null){
      await _googleSignIn.signIn();
    }
    await _googleSignIn.currentUser.authentication;
    // final headers = await _googleSignIn.currentUser.authHeaders;
    // final httpClient = GoogleHttpClient(headers);
    var calendar = CalendarApi(await _googleSignIn.authenticatedClient());
    // auth.AuthClient client = await _googleSignIn.authenticatedClient();

    try {

      await calendar.events.insert(event, calendarId,
          conferenceDataVersion:  1 , sendUpdates: "all")
          .then((value) {
        print("Event Status: ${value.status}");

        if (value.status == "confirmed") {
          evId = value.id;
          print("id1 : ${value.id.toString()}");
          print("evId : ${evId}");
          print("event.id : ${event.id}");
          return  MeetingCollection.add({
            'studentId': sid,
            'eventId':evId,
            'title': title,
            'notes': notes,
            'progress': progress,
            'dateTime': DateTime.now(),
            'nextMeetingStart': startTime,
            'nextMeetingEnd': endTime
          });
          print('Event added to Google Calendar');
        } else {
          print('Unable to add event to Google Calendar');

        }

      });

    } catch (e) {

      print("Error creating event $e");
    }

  }













  Future updateMeeting({
    @required String sid,
    @required String docid,
    @required String evid,
    @required String title,
    @required String notes,
    @required String progress,
    @required DateTime startTime,
    @required DateTime endTime,

  }) async {
    var studentEmail = await FirebaseFirestore.instance
        .collection('users')
        .doc(sid)
        .get()
        .then((value) {
      print("email is  : ${value.data()['email']}");
      return value.data()['email']; // Access your after your get the data
    });

    String calendarId = "primary";
    Event event = Event();
    event.summary = title;
    print("uid : ${sid}");
    print("email : ${studentEmail.toString()}");
    print("start : ${startTime}");
    print("end : ${endTime}");
    final mail = studentEmail.toString();
    print("mmail : ${mail.toString()}");
    EventAttendee student = EventAttendee(email:mail );
    List<EventAttendee> attendeeEmails = [];
    attendeeEmails.add(student);
    event.attendees = attendeeEmails;
    ConferenceData conferenceData = ConferenceData();
    CreateConferenceRequest conferenceRequest = CreateConferenceRequest();
    conferenceRequest.requestId =
    "${startTime.millisecondsSinceEpoch}-${endTime.millisecondsSinceEpoch}";
    conferenceData.createRequest = conferenceRequest;

    event.conferenceData = conferenceData;

    EventDateTime start = new EventDateTime();
    start.dateTime = startTime;
    start.timeZone = "GMT+08";
    event.start = start;

    EventDateTime end = new EventDateTime();
    end.timeZone = "GMT+08";
    end.dateTime = endTime;
    event.end = end;
    // signForClander();

    if(await _googleSignIn.currentUser == null){
      await _googleSignIn.signIn();
    }
    await _googleSignIn.currentUser.authentication;
    // final headers = await _googleSignIn.currentUser.authHeaders;
    // final httpClient = GoogleHttpClient(headers);
    var calendar = CalendarApi(await _googleSignIn.authenticatedClient());
    // auth.AuthClient client = await _googleSignIn.authenticatedClient();

    try {

      await calendar.events.patch(event, calendarId,evid ,conferenceDataVersion:  1 , sendUpdates: "all" )
          .then((value) {
        print("Event Status: ${value.status}");

        if (value.status == "confirmed") {
          evId = value.id;
          print("id1 : ${value.id.toString()}");
          print("evId : ${evId}");
          print("event.id : ${event.id}");
          return  MeetingCollection.doc(docid).update({
            'title': title,
            'notes': notes,
            'progress': progress,
            'dateTime': DateTime.now(),
            'nextMeetingStart': startTime,
            'nextMeetingEnd': endTime
          });
          print('Event added to Google Calendar');
        } else {
          print('Unable to add event to Google Calendar');

        }

      });

    } catch (e) {

      print("Error creating event $e");
    }
  }

  Future<void> deleteMeeting(String eventId, String docId) async {
    String calendarId = "primary";
    if(await _googleSignIn.currentUser == null){
      await _googleSignIn.signIn();
    }
    await _googleSignIn.currentUser.authentication;
    // final headers = await _googleSignIn.currentUser.authHeaders;
    // final httpClient = GoogleHttpClient(headers);
    var calendar = CalendarApi(await _googleSignIn.authenticatedClient());
    try {
       calendar.events.delete(calendarId, eventId, sendUpdates: "all").then((value) {
        print('Event deleted from Google Calendar');
      });
    } catch (e) {
      print('Error deleting event: $e');
    }
    return await MeetingCollection.doc(docId).delete();
  }

  Future acceptInvitation({@required String code}) async {
    var sv = await UserCollection.where('code', isEqualTo: code).get();
    return await UserCollection.doc(user.uid).update({'sv': sv.docs[0].id});
  }

  Stream getStudentsList() {
    return UserCollection.where('userType', isEqualTo: 'Student')
        .where('sv', isEqualTo: uid)
        .snapshots();
  }

  Stream getComments(mid) {
    return FirebaseFirestore.instance
        .collection('comments').where('meetingId', isEqualTo: mid).snapshots();
  }



Future addComment({
  @required String sid,
  @required String mid,
  @required String text,
}) async {
  var studentName = await FirebaseFirestore.instance
      .collection('users')
      .doc(sid)
      .get()
      .then((value) {
    print("name is  : ${value.data()['name']}");
    return value.data()['name']; // Access your after your get the data
  });
  return  FirebaseFirestore.instance.collection('comments').add({
    'meetingId': mid,
    'StudentName': studentName.toString(),
    'text': text,
    'dateTime': DateTime.now()
  });

}

checkUserType() async {
  var userType = await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .get()
      .then((value) {
    print("UserType is  : ${value.data()['userType']}");
    return value.data()['userType'].toString(); // Access your after your get the data
  });
  return userType;
}
}
