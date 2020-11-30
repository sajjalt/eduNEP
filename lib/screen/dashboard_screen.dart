import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/syllabusProvider.dart';
import '../providers/student_provider.dart';

import '../widgets/subject_tile.dart';
import '../widgets/app_drawer.dart';

class DashboardScreen extends StatefulWidget {
  static const routeName = '/dashboard-Screen';
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<Students>(context).fetchStudents();
      Provider.of<Students>(context).getLocalID();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final student = Provider.of<Students>(context).loggedInStudent();
    final subjectListProvider = Provider.of<Syllabus>(context);
    final subjectList = subjectListProvider.findByClass(student.curClass);

    final GlobalKey _scaffoldKey = new GlobalKey();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.indigo[50],
          elevation: 0,
          title: Builder(
            builder: (context) => IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.indigo[800],
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          )),
      drawer: AppDrawer(),
      backgroundColor: Colors.indigo[50],
      body: Container(
        padding: EdgeInsets.only(top: 0, left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Hello ${student.firstName}",
                  style: TextStyle(fontSize: 20, color: Colors.indigo[700]),
                ),
                Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage('assets/images/profilePic.png'))),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'What do you\nwant to \nlearn Today?',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900),
            ),
            // SizedBox(
            //   height: 5,
            // ),
            Divider(
              thickness: 3,
              color: Colors.indigo[700],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: subjectList.length,
                itemBuilder: (ctx, i) {
                  return ChangeNotifierProvider.value(
                    value: subjectList[i],
                    child: SubjectTile(),
                  );
                },
              ),
            ),
            // Container(
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: <Widget>[
            //       IconButton(
            //         onPressed: () {},
            //         icon: Icon(
            //           Icons.subscriptions,
            //           color: Colors.indigo[700],
            //           size: 30,
            //         ),
            //       ),
            //       IconButton(
            //         onPressed: () {},
            //         icon: Icon(
            //           Icons.play_circle_filled,
            //           color: Colors.indigo[700].withOpacity(0.5),
            //           size: 30,
            //         ),
            //       ),
            //       IconButton(
            //         onPressed: () {},
            //         icon: Icon(
            //           Icons.account_circle,
            //           color: Colors.indigo[700],
            //           size: 30,
            //         ),
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
