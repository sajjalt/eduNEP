import 'package:flutter/material.dart';

import '../models/marsk.dart';

class Student {
  final String id;
  final String firstName;
  final String dob;
  final String curClass;
  final String email;
  final List<String> curSubjects;
  bool newClass;
  Map<String,Marks> curMarks={};
  Map<String,Map<String,Marks>> marksheet={};
   
  Student({
    @required this.id,
    @required this.firstName,
    @required this.dob,
    @required this.curClass,
    @required this.email,
    @required this.curSubjects,
    this.newClass=true,
    this.curMarks,
    this.marksheet,
  });
  
}