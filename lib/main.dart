
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/subject_provider.dart';

import './screen/dashboard_screen.dart';
import './screen/greet_screen.dart';
import './screen/subject_detail_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
          create: (ctx)=>Subjects(),
          child: MaterialApp(
        home: MyHomePage(),
        theme: ThemeData(fontFamily: 'Avenir'),
        routes: {
          DashboardScreen.routeName: (ctx)=>DashboardScreen(),
          SubjectDetails.routeName: (ctx)=>SubjectDetails(),
        },
      ),
    );
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
