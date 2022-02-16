import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project2/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  DatabaseService({@required this.uid});

  //colection reference
  final CollectionReference UserCollection =
      FirebaseFirestore.instance.collection('usersData');

   final user= FirebaseAuth.instance.currentUser;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
    // final User = userdata.user;
    // final userlen = DatabaseService(uid: User.uid ).checkUser();
    //  if(userlen != 1){
    //    showDialog(
    //      context: context,
    //      builder: (BuildContext context) => CompleteSignUp(uid: User.uid));
    //  }



  }


  Future updateUserData(
      {
      @required String phone,
      @required String wechat,
      @required String type}) async {
    return await UserCollection.doc(uid).set(
        {'name':user.displayName , 'phone': phone, 'wechat': wechat, 'userType': type});
  }

  //Get User Document Stream
  Stream<UserData> get getUserData {
    return UserCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  //User Data from Snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: 'name',
        wechat: 'wechat',
        phone: 'phone',
        email: 'email',
        type: 'UserType');
  }
}
