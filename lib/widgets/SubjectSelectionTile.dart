import 'package:eduNEP/widgets/subject_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/student_provider.dart';

class SubjectSelectionTile extends StatefulWidget {
  final subjectTitle;

  SubjectSelectionTile({@required this.subjectTitle});

  @override
  _SubjectSelectionTileState createState() => _SubjectSelectionTileState();
}

class _SubjectSelectionTileState extends State<SubjectSelectionTile> {
  List<Color> _curColor = [Colors.indigo[200],Colors.greenAccent[700]];
  

  var colorIndex=0;

  @override
  Widget build(BuildContext context) {
  
  
  
    return  InkWell(
          onTap: (){
            setState(() {
              colorIndex=(colorIndex+1)%2;
            });
            Provider.of<Students>(context,listen: false).updateSubjects(widget.subjectTitle);
          },
          child: Container(
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: _curColor[colorIndex],
            borderRadius: BorderRadius.circular(25),
          ),
          child: Text(
            widget.subjectTitle,
            style: TextStyle(fontSize: 20),
          ),
        
      ),
    );
  }
}
