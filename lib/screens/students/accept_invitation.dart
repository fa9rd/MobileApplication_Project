import 'package:flutter/material.dart';
import 'package:project2/screens/CheckUser.dart';
import 'package:project2/screens/students/dashboard.dart';
import 'package:project2/services/database.dart';
import 'package:project2/widgets/field.dart';

class AcceptSupervisorInvitation extends StatefulWidget {
  // const AcceptSupervisorInvitation({Key key}) : super(key: key);
  @override
  State<AcceptSupervisorInvitation> createState() =>
      _AcceptSupervisorInvitationState();
}

class _AcceptSupervisorInvitationState
    extends State<AcceptSupervisorInvitation> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _invetiationCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
            child: Text(
                "You do not have Supervisor Yet.\n Please Enter your Supervisor Invitation Code to start using the app."),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
                  child: Field(
                      "code",
                      "_invetiationCode == 16",
                      "Invitation Code Should contain 16 character",
                      _invetiationCode,
                      TextInputType.text,
                      "Invitation Code ",
                      false),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
                  child: GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        print("Inv code : " + _invetiationCode.text.toString());
                        await DatabaseService().acceptInvitation(
                            code: _invetiationCode.text.trim().toString());
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CheckUser()),
                        );
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
                          "Accept Invitation",
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
    );
  }
}
