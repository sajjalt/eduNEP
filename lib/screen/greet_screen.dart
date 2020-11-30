import 'package:eduNEP/providers/syllabusProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/authStudent.dart';

import './dashboard_screen.dart';
import '../widgets/register.dart';
import '../models/http_exception.dart';

class GreetScreen extends StatelessWidget {
  static const routeName = '/greet';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.indigo[800],
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Greeting(),
            SizedBox(
              height: 20,
            ),
            Expanded(child: Auth()),
          ],
        ),
      ),
    );
  }
}

class Greeting extends StatelessWidget {
  const Greeting({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 70, left: 30),
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
    );
  }
}

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final _loginForm = GlobalKey<FormState>();
  final _passFocusNode = FocusNode();
  final _mainColor = Colors.indigo[800];
  var _studentEmail = '';
  var _stuPass = '';
  var _isLoading = false;
  @override
  void dispose() {
    _passFocusNode.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text(
                "Some error has occured",
                style: TextStyle(color: Colors.indigo[800]),
              ),
              content: Text(message),
              actions: [
                FlatButton(
                  child: Text(
                    "Okay",
                    style: TextStyle(
                        color: Colors.indigo[800],
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                )
              ],
            ));
  }

  Future<void> loginStudent() async {
    setState(() {
      _isLoading = true;
    });
    final isValid = _loginForm.currentState.validate();
    if (!isValid) {
       setState(() {
      _isLoading = false;
    });
      return;
    }

    _loginForm.currentState.save();

    try {
      await Provider.of<AuthStudent>(context, listen: false)
          .login(_studentEmail, _stuPass);
    } on HttpException catch (error) {
      var errorMessage = "Authentication failed";
      if (error.toString().contains("EMAIL_EXISTS")) {
        errorMessage = "This email address already exists";
      } else if (error.toString().contains("INVALID_EMAIL")) {
        errorMessage = "This email address is not valid";
      } else if (error.toString().contains("WEAK_PASSWORD")) {
        errorMessage = "Password is too short";
      } else if (error.toString().contains("EMAIL_NOT_FOUND")) {
        errorMessage = "No user found with this email address";
      } else if (error.toString().contains("INVALID_PASSWORD")) {
        errorMessage = "Wrong password";
      }

      _showErrorDialog(errorMessage);
    } catch (error) {
      var errorMessage = 'Could not authenticate you';
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          bottom: 0,
          child: Container(
            alignment: Alignment.bottomCenter,
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    image: AssetImage('assets/images/splash.png'))),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 30, right: 30),
          child: Form(
              key: _loginForm,
              child: ListView(
                children: [
                  Center(
                    child: Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    cursorColor: _mainColor,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.indigo[50],
                      prefixIcon: Icon(
                        Icons.alternate_email,
                        color: _mainColor,
                      ),
                      hintText: "E-mail",
                      // labelText: "E-mail",
                      // labelStyle: TextStyle(color: _mainColor),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_passFocusNode);
                    },
                    onSaved: (val) {
                      _studentEmail = val;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return "This Cannot be Empty";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    obscureText: true,
                    cursorColor: _mainColor,
                    decoration: InputDecoration(
                      fillColor: Colors.indigo[50],
                      filled: true,
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: _mainColor,
                      ),
                      hintText: "Password",
                      // labelText: "Password",
                      // labelStyle: TextStyle(color: _mainColor),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none),
                    ),
                    textInputAction: TextInputAction.next,
                    onSaved: (val) {
                      _stuPass = val;
                    },
                    focusNode: _passFocusNode,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "This Cannot be Empty";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (_isLoading)
                    Center(
                      child: Container(
                        height: 100,
                        width: 100,
                        margin: EdgeInsets.only(top: 10, bottom: 20),
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                          strokeWidth: 10,
                        ),
                      ),
                    )
                  else
                    Container(
                      margin: EdgeInsets.only(
                          top: 10, bottom: 10, left: 70, right: 70),
                      child: FlatButton(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 35),
                        color: _mainColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        onPressed: () {
                          loginStudent();
                        },
                        child: Text(
                          "Login",
                          style: (TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10, left: 70, right: 70),
                    child: FlatButton(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 35),
                      color: Colors.indigo[50],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      onPressed: () {
                        // Navigator.of(context).pop();
                        Navigator.of(context)
                            .pushReplacementNamed(RegisterUser.routeName);
                      },
                      child: Text(
                        "Sign-Up",
                        style: (TextStyle(
                            fontSize: 22,
                            color: _mainColor,
                            fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                  // Container(
                  //   margin: EdgeInsets.only(bottom: 10, left: 70, right: 70),
                  //   child: FlatButton(
                  //     padding:
                  //         EdgeInsets.symmetric(vertical: 10, horizontal: 35),
                  //     color: Colors.indigo[50],
                  //     shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(30)),
                  //     onPressed: () {
                  //       Provider.of<Syllabus>(context,listen:false).fetchSyllabus('Class-10');
                  //       // Navigator.of(context).pop();
                  //       // Navigator.of(context)
                  //       //     .pushReplacementNamed(RegisterUser.routeName);
                  //     },
                  //     child: Text(
                  //       "Syllabus",
                  //       style: (TextStyle(
                  //           fontSize: 22,
                  //           color: _mainColor,
                  //           fontWeight: FontWeight.bold)),
                  //     ),
                  //   ),
                  // ),
                ],
              )),
        ),
      ],
    );
  }
}
