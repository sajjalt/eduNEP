import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/subject.dart';

import '../screen/subject_detail_screen.dart';

class SubjectTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sub = Provider.of<Subject>(context);
    void subDetais(){
      Navigator.of(context).pushNamed(SubjectDetails.routeName,arguments: sub.id);
    }

    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
      decoration: BoxDecoration(
        color: sub.bgColor,
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: InkWell(
        onTap: () {
          subDetais();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.indigo[50],
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Text(
                '${sub.title}',
                style: TextStyle(
                  color: Colors.indigo[700],
                  fontSize: 15,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              sub.chapterTitle[0],
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 5,),
            Hero(
              tag: '${sub.id}',
              child: Container(
                height: MediaQuery.of(context).size.height*0.15,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/images/${sub.image}.png'),
                  fit: BoxFit.cover),

                ),

              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: <Widget>[
                Container(
                  height: 10,
                  decoration: BoxDecoration(
                      color: Colors.blue[900],
                      borderRadius: BorderRadius.only(topLeft:Radius.circular(5),bottomLeft: Radius.circular(5)),
                      ),
                  width: MediaQuery.of(context).size.width * 0.7,
                ),
                Expanded(child: Container(
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.blue[200],
                    borderRadius: BorderRadius.only(topRight:Radius.circular(5),bottomRight: Radius.circular(5)),
                  ),
                ),)
              ],
            ),
            SizedBox(height: 5,)
          ],
        ),
      ),
    );
  }
}
