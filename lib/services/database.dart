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
import 'package:googleapis_auth/googleapis_auth.dart' as auth show AuthClient;


class DatabaseService {
  final String uid;
   static var theCalendar;
  static const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

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


Future<Function> signForClander() async {
  var _clientID = new ClientId("323266625944-eh81r1e1107lorcaveu52rdo419thunc.apps.googleusercontent.com");
  const _scopes = const [CalendarApi.calendarScope];
  await clientViaUserConsent(_clientID, _scopes, prompt).then((AuthClient client) async {
    theCalendar = CalendarApi(client);
  });
}



  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount  googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

   return await FirebaseAuth.instance.signInWithCredential(credential);
  }


  // String getUserData()  {
  //   Future<DocumentSnapshot<Object>>  theUser =  UserCollection.doc(uid).get();
  //   Map<String, dynamic> tdata;
  //     var thedata = theUser.asStream().map((event) => tdata['name'] = event.get("name"));
  //
  //     String value  = tdata.values..toString() ; // <-- The value you want to retrieve.
  //     return value.toString();
  //
  //
  // }

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
    try {

      await theCalendar.events.insert(event, calendarId,
          conferenceDataVersion:  1, sendUpdates: "all" )
          .then((value) {
        print("Event Status: ${value.status}");

        if (value.status == "confirmed") {

          print('Event added to Google Calendar');
        } else {
          print('Unable to add event to Google Calendar');

        }

      });

    } catch (e) {

      print("Error creating event $e");
    }
    return await MeetingCollection.add({
      'studentId': sid,
      'title': title,
      'notes': notes,
      'progress': progress,
      'dateTime': DateTime.now(),
      'nextMeetingStart': startTime,
      'nextMeetingEnd': endTime
    });
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



}
