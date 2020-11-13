import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/subject_provider.dart';

class SubjectDetails extends StatelessWidget {
  static const routeName = '/subjectDetails-Screen';
  @override
  Widget build(BuildContext context) {
    final subjectId = ModalRoute.of(context).settings.arguments as String;
    final subject = Provider.of<Subjects>(context).findbyId(subjectId);
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.indigo,
        ),
        title: Text(
          '${subject.title}',
          style: TextStyle(color: Colors.indigo[700], fontSize: 23),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(
          left: 15,
          right: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Course Content for ${subject.title}',
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(
              height: 10,
            ),
            Hero(
              tag: '${subject.id}',
              child: Container(
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: subject.bgColor,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/${subject.image}.png')),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              padding: EdgeInsets.all(10),
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.all(Radius.circular(15)),
              //   color: Colors.indigo[50],
              // ),
              margin: EdgeInsets.only(left: 0),
              child: Text(
                'Chapters List',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: subject.chapters,
                  itemBuilder: (ctx, i) {
                    return Container(
                      margin: EdgeInsets.only( bottom:1),
                      padding: EdgeInsets.all(5),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    color: Colors.indigo[700]),
                                child: Center(
                                  child: Icon(
                                    Icons.play_arrow,
                                    color: Colors.indigo[50],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  '${subject.chapterTitle[i]}',
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(fontSize: 18),
                                ),
                              )
                            ],
                          ),
                          Divider(
                            color: Colors.indigo[700],
                            thickness: 0.7,
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
