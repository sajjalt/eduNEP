import 'package:flutter/material.dart';

import './dashboard_screen.dart';

class GreetScreen extends StatelessWidget {
  static const routeName='/greet';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[800],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    "eduNEP",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      height: 1,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    "Online Learning",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w100,
                      height: 1,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    "is not the next,",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w100,
                      height: 1,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    "big thing",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      height: 1,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    "it is now the",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w100,
                      height: 1,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    "BIG THING,",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      height: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Stack(
            children: <Widget>[
              Container(
                alignment: Alignment.bottomCenter,
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/splash.png'))),
              ),
              Positioned(
                bottom: 50,
                left: 0,
                right: 0,
                child: Center(
                  child: FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 35),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(DashboardScreen.routeName);
                    },
                    child: Text("Continue...",
                    style: TextStyle(
                      color: Colors.indigo[800],
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                    ),),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}