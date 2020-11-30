import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/subject_provider.dart';
import './providers/syllabusProvider.dart';
import './providers/student_provider.dart';
import './providers/authStudent.dart';

import './screen/dashboard_screen.dart';
import './screen/greet_screen.dart';
import './screen/subject_detail_screen.dart';
import './screen/subject_selection.dart';

import './widgets/register.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: AuthStudent()),
          ChangeNotifierProxyProvider<AuthStudent,Students>(
            create: (_)=>Students(),
            update: (_,auth,student)=>student..update(auth.token,student!=null ? student.studentsList : [],auth.uId),
          ),
          ChangeNotifierProvider.value(value: Subjects()),
          ChangeNotifierProxyProvider<AuthStudent,Syllabus>(
            create:(_)=> Syllabus(),
            update: (_,auth,syllabus)=>syllabus..update(auth.token,syllabus!=null ? syllabus.curSyllabus : []),
          ),
          
        ],
        child: Consumer<AuthStudent>(
          builder: (ctx, auth, _) => MaterialApp(
            home: auth.isAuth ?  DashboardScreen() :  MyHomePage(),
            theme: ThemeData(fontFamily: 'Avenir'),
            routes: {
              DashboardScreen.routeName: (ctx) => DashboardScreen(),
              SubjectDetails.routeName: (ctx) => SubjectDetails(),
              RegisterUser.routeName: (ctx) => RegisterUser(),
              SubjectSelection.routeName: (ctx) => SubjectSelection(),
              GreetScreen.routeName: (ctx) => GreetScreen(),
            },
          ),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return GreetScreen();
  }
}
