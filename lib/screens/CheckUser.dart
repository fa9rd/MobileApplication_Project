import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project2/screens/students/dashboard.dart';
import 'package:project2/screens/Supervisors/sv_dashboard.dart';
import 'complete_signup.dart';

class CheckUser extends StatefulWidget {
  @override
  _CheckUserState createState() => _CheckUserState();
}



class _CheckUserState extends State<CheckUser> {



  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    var uid = FirebaseAuth.instance.currentUser.uid;
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot>(
        future: users.doc(uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Something went wrong"),
            );
          }

          if (snapshot.hasData && !snapshot.data.exists) {
            return CompleteSignUp(uid: uid);
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data.data() as Map<String, dynamic>;
            // return Text("Full Name: ${data['full_name']} ${data['last_name']}");
            print("type : " + data['userType'].toString());
            if(data['userType'] == "Supervisor"){
              return SvDashboard();
            }
            else{
              print("first Sv : " +  data['sv'].toString());
              return Dashboard(uid: uid, sv: data['sv'],fName: data['name'],);
            }
          }

          return Center(
            child: CircularProgressIndicator(
              // value: controller.value,
              color:Theme.of(context).primaryColor ,
              semanticsLabel: 'Loading',
            ),
          );
        },
      ),
    );

    // var isOld = ds.id;
    // print(isOld );
    // if(DatabaseService(uid: FirebaseAuth.instance.currentUser.uid).checkIfUserExists == true){
    //   print("uid : " + FirebaseAuth.instance.currentUser.uid);
    //   return CompleteSignUp(uid: FirebaseAuth.instance.currentUser.uid);
    // }
    // else{
    //   return Dashboard();
    // }

    // if(DatabaseService(uid: user.uid).UserCollection.doc(user.uid).get() == null){
    //   // return ListView.builder(
    //   //     itemCount: snapshot.data.docs.length,
    //   //     itemBuilder: itemBuilder)
    //   return CompleteSignUp(uid: user.uid);
    // }
  }
}
