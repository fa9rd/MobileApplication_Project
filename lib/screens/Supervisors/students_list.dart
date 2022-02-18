import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project2/services/database.dart';
import 'package:project2/widgets/student.dart';

class StudentsList extends StatefulWidget {
  @override
  State<StudentsList> createState() => _StudentsListState();
}

class _StudentsListState extends State<StudentsList> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          StreamBuilder(
            stream: DatabaseService(uid: DatabaseService().user.uid)
                .getStudentsList(),
            builder: (ctx, studentsSnapshot) {
              if (studentsSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final students = studentsSnapshot.data.docs;

              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                reverse: true,
                itemCount: students.length,
                itemBuilder: (ctx, index) => Student(
                  uid: students[index].id,
                  name: students[index]['name'],
                  email: students[index]['email'],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
