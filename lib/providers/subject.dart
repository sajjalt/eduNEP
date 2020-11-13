import 'package:flutter/material.dart';

class Subject with ChangeNotifier{
  final String id;
  final String title;
  final int chapters;
  final List<String> chapterTitle;
  final String image;
  final Color bgColor;
  


  Subject({
    @required this.id,
    @required this.title,
    @required this.chapters,
    @required this.chapterTitle,
    @required this.image,
    @required this.bgColor
  });
}