import 'package:eduNEP/models/student.dart';
import 'package:eduNEP/screen/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/syllabusProvider.dart';
import '../providers/student_provider.dart';
import '../widgets/SubjectSelectionTile.dart';

class SubjectSelection extends StatefulWidget {
  static const routeName = '/SubjectSelection_Screen';
  
  @override
  _SubjectSelectionState createState() => _SubjectSelectionState();
}

class _SubjectSelectionState extends State<SubjectSelection> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    var curClass=ModalRoute.of(context).settings.arguments as String;

    print("class value received : ${curClass}");
    if (_isInit) {
      _isInit = false;
      setState(() {
        _isLoading = true;
      });
      Provider.of<Syllabus>(context, listen: false)
          .fetchSyllabus(curClass)
          .then((_) {
        print("syllabus fetched");
        setState(() {
          _isLoading = false;
        });
      });
    }
    super.didChangeDependencies();
  }

  // final curClass = 'Class-10';
  final _mainColor = Colors.indigo[800];

  // update subject to be done via student provider directly not here

  @override
  Widget build(BuildContext context) {
    final curClass = ModalRoute.of(context).settings.arguments as String;

    final currentSyllabus =
        Provider.of<Syllabus>(context).findByClass(curClass);

    void updateCurSubjects(){
      Provider.of<Students>(context,listen: false).updateCurSubs();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Choose your Subjects',
          style: TextStyle(
              fontSize: 30, color: _mainColor, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
      backgroundColor: Colors.indigo[50],
      body: _isLoading?  CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                          strokeWidth: 10,
                        ) :Container(
        padding: EdgeInsets.only(
          left: 15,
          right: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/subject_selection.png')),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              color: _mainColor,
              thickness: 2,
              endIndent: 0,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: currentSyllabus.length,
                  itemBuilder: (ctx, i) {
                    return SubjectSelectionTile(
                        subjectTitle: currentSyllabus[i].title);
                  }),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(bottom: 5),
              child: FlatButton(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 35),
                color: _mainColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                onPressed: () {

                  updateCurSubjects();

                  Navigator.of(context).pushReplacementNamed(DashboardScreen.routeName);
                },
                child: Text(
                  "Submit",
                  style: (TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
