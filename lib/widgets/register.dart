import 'package:eduNEP/screen/subject_selection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/new_student.dart';
import '../models/student.dart';
import '../screen/dashboard_screen.dart';
import '../providers/student_provider.dart';
import '../providers/authStudent.dart';

import '../screen/greet_screen.dart';

import '../models/http_exception.dart';

class RegisterUser extends StatefulWidget {
  static const routeName = "/register";

  @override
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  final _emailFocusNode = FocusNode();
  final _passFocusNode = FocusNode();

  final _form = GlobalKey<FormState>();
  final _mainColor = Colors.indigo[800];
  var _pass = '';

  var _newStudent = NewStudent(
      firstName: '', dob: '', curClass: '', curSubjects: [], email: '');
  var userName = '';
  var newStu = Student(
    firstName: '',
    curClass: '',
    dob: '',
    curSubjects: [],
    email: '',
    id: '',
  );

  @override
  void dispose() {
    _emailFocusNode.dispose();
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

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }

    _form.currentState.save();

    setState(() {
      newStu = Student(
          id: '',
          firstName: _newStudent.firstName,
          curClass: _newStudent.curClass,
          dob: _newStudent.dob,
          email: _newStudent.email,
          curSubjects: _newStudent.curSubjects);
    });

    try {
      await Provider.of<AuthStudent>(context, listen: false)
          .signup(newStu.email, _pass);
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

   await Provider.of<Students>(context, listen: false).addStudent(newStu);
  
    Navigator.of(context).pushReplacementNamed(SubjectSelection.routeName,arguments: newStu.curClass);
  }

  @override
  Widget build(BuildContext context) {
    var classValue;
    List<String> _classes = [
      "Class-1",
      "Class-2",
      "Class-3",
      "Class-4",
      "Class-5",
      "Class-6",
      "Class-7",
      "Class-8",
      "Class-9",
      "Class-10",
      "Class-11",
      "Class-12",
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[50],
        elevation: 0,
        leading: InkWell(
          onTap: () {
            // Navigator.of(context).pop();
            Navigator.of(context).pushReplacementNamed(GreetScreen.routeName);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.indigo[700],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Container(
          color: Colors.indigo[50],
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 10, bottom: 5),
                child: Center(
                  child: Text(
                    "Register Student",
                    style: TextStyle(
                        color: _mainColor,
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Form(
                      key: _form,
                      child: ListView(
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height * 0.25,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      'assets/images/subject_selection.png')),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            cursorColor: _mainColor,
                            decoration: InputDecoration(
                              fillColor: Colors.indigo[200],
                              filled: true,
                              prefixIcon: Icon(
                                Icons.person,
                                color: _mainColor,
                              ),
                              hintText: "Name",
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                            textInputAction: TextInputAction.next,
                            onSaved: (val) {
                              _newStudent.firstName = val;
                              print(_newStudent.firstName);
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "This cannot be empty";
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              fillColor: Colors.indigo[200],
                              filled: true,
                              prefixIcon: Icon(
                                Icons.mode_edit,
                                color: _mainColor,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            hint: Text("Choose your class"),
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: _mainColor,
                            ),
                            items: _classes
                                .map((newVal) => DropdownMenuItem(
                                      child: Text(
                                        newVal,
                                        style: TextStyle(color: _mainColor),
                                      ),
                                      value: newVal,
                                    ))
                                .toList(),
                            onChanged: (String newVal) {
                              setState(() {
                                classValue = newVal;
                                print(newVal);
                                print(classValue);
                              });
                            },
                            value: classValue,
                            onSaved: (val) {
                              _newStudent.curClass = val;
                              print(_newStudent.curClass);
                            },
                            validator: (value) {
                              if (value == null) {
                                return "Choose a Class";
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.datetime,
                            cursorColor: _mainColor,
                            decoration: InputDecoration(
                              fillColor: Colors.indigo[200],
                              filled: true,
                              focusColor: _mainColor,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              prefixIcon: Icon(
                                Icons.calendar_today,
                                color: _mainColor,
                              ),
                              hintText: "DD/MM/YYYY",
                            ),
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_emailFocusNode);
                            },
                            onSaved: (val) {
                              _newStudent.dob = val;
                              print(_newStudent.dob);
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "This cannot be empty";
                              } else if (!value
                                  .contains(RegExp('[0-9/]{10}'))) {
                                return "Enter in the specified format";
                              } else if (value.contains(RegExp('[0-9/]{10}'))) {
                                var test = value.split('/');
                                if ((int.parse(test[0]) < 1) ||
                                    (int.parse(test[0]) > 31)) {
                                  return "Choose a valid date";
                                } else if (int.parse(test[1]) < 1 ||
                                    int.parse(test[1]) > 12) {
                                  return "Choose a valid month";
                                } else if (int.parse(test[2]) > 2020 ||
                                    int.parse(test[2]) < 1998) {
                                  return "Choose a valid year";
                                }
                                return null;
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            cursorColor: _mainColor,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.indigo[200],
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
                            focusNode: _emailFocusNode,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_passFocusNode);
                            },
                            onSaved: (val) {
                              _newStudent.email = val;
                              print(_newStudent.email);
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
                              fillColor: Colors.indigo[200],
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
                            focusNode: _passFocusNode,
                            onSaved: (val) {
                              _pass = val;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "This Cannot be Empty";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ],
                      )),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: FlatButton(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 35),
                  color: _mainColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  onPressed: () {
                    _saveForm();
                  },
                  child: Text(
                    "Register",
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
      ),
    );
  }
}
