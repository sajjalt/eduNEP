import 'package:flutter/material.dart';

class NewStudent {
  String firstName;
  String dob;
  String curClass;
  String email;
  List<String> curSubjects;

  NewStudent(
      {@required this.firstName,
      @required this.dob,
      @required this.curClass,
      @required this.email,
      @required this.curSubjects});
}
