import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project2/models/meeting_data.dart';
import 'package:project2/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  DatabaseService({@required this.uid});

  //colection reference
  final CollectionReference UserCollection =
      FirebaseFirestore.instance.collection('users');

  final MeetingCollection = FirebaseFirestore.instance.collection('meetings');

  final user = FirebaseAuth.instance.currentUser;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
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
    return await UserCollection.doc(uid).set({
      'name': user.displayName,
      'email': user.email,
      'phone': phone,
      'wechat': wechat,
      'userType': type
    });
  }


  Future addMeeting(
      {
        @required String sid,
        @required String notes,
        @required String progress,
        @required String nextMeeting}) async {
    return await MeetingCollection.add({
      'studentId': sid,
      'notes':notes,
      'progress': progress,
      'dateTime': DateTime.now(),
      'nextMeeting': nextMeeting
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
