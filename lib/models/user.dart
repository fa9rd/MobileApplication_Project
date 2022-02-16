import 'package:flutter/cupertino.dart';

class User {
  final String uid;
  User({this.uid});
}

class UserData {
  final String uid;
  final String type;
  final String name;
  final String email;
  final String phone;
  final String wechat;

  UserData({ this.uid, @required this.type , @required this.name, @required this.email, @required this.phone , @required this.wechat});
}
