import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/student_provider.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

final Color _mainColor = Colors.indigo[800];

class _AppDrawerState extends State<AppDrawer> {
  Widget build(BuildContext context) {
    final student = Provider.of<Students>(context).loggedInStudent();

    return Drawer(
      elevation: 5,
      child: Container(
        color: Colors.indigo[50],
        child: Column(
          children: <Widget>[
            AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Center(
                child: Text(
                  "Student Details",
                  style: TextStyle(
                    color: _mainColor,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/subject_selection.png')),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                color: _mainColor,
                size: 25,
              ),
              title: Text(
                student.firstName,
                style: TextStyle(color: _mainColor, fontSize: 20),
              ),
              onTap: () {},
            ),
            // Divider(),
            ListTile(
              leading: Icon(
                Icons.payment,
                color: _mainColor,
                size: 25,
              ),
              title: Text(
                student.dob,
                style: TextStyle(color: _mainColor, fontSize: 20),
              ),
              onTap: () {},
            ),
            // Divider(),
            ListTile(
              leading: Icon(
                Icons.edit,
                color: _mainColor,
                size: 25,
              ),
              title: Text(
                student.curClass,
                style: TextStyle(color: _mainColor, fontSize: 20),
              ),
              onTap: () {},
            ),
            // Divider(),
            ListTile(
              leading: Icon(
                Icons.exit_to_app,
                color: _mainColor,
                size: 25,
              ),
              title: Text(
                'Logout',
                style: TextStyle(color: _mainColor, fontSize: 20),
              ),
              onTap: () {
                // Navigator.of(context).pushReplacementNamed(UserProductsScreen.routeName);
                // Navigator.of(context).pop();
                // Navigator.of(context).pushReplacementNamed('/');
                // Provider.of<Auth>(context,listen: false).logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
