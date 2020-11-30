import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import '../models/student.dart';
import '../models/marsk.dart';

class Students with ChangeNotifier {

List<Student> _studentList=[
];

String _authToken='token';
String _userId;


void updateUid(String id)
{
  _userId=id;
}

String get getUid {
  return _userId;
}

void updateToken(String token){
  _authToken=token;

  print("updating student token");
}
String localID='';

Future<void> getLocalID()async
{ final url='https://edunep-75d45.firebaseio.com/students.json?auth=$_authToken&orderBy="id"&equalTo="$_userId"';  
 final respose= await http.get(url);

  localID= localID!=null? localID :json.decode(respose.body)['name'];

  print("local ID: $localID");


}

Student loggedInStudent()
{
return _studentList.firstWhere((stu) => stu.id==localID);
}


void update(String token,List<Student> stuList,String uId)
{ _userId=uId;
  _authToken=token;
  _studentList=stuList;

  print("\n auth token : $_authToken");
  print("\nuser ID : $_userId");
}

List<Student> get studentsList {
  return [..._studentList];
}

Marks _curMarks=Marks(sessional1: '',sessional2: '',midSem: '',endSem: '');

Map<String,Marks> _studentMarksheet={
  'Class-1': Marks(sessional1: '',sessional2: '',midSem: '',endSem: ''),
  'Class-2': Marks(sessional1: '',sessional2: '',midSem: '',endSem: ''),
  'Class-3': Marks(sessional1: '',sessional2: '',midSem: '',endSem: ''),
  'Class-4': Marks(sessional1: '',sessional2: '',midSem: '',endSem: ''),
  'Class-5': Marks(sessional1: '',sessional2: '',midSem: '',endSem: ''),
  'Class-6': Marks(sessional1: '',sessional2: '',midSem: '',endSem: ''),
  'Class-7': Marks(sessional1: '',sessional2: '',midSem: '',endSem: ''),
  'Class-8': Marks(sessional1: '',sessional2: '',midSem: '',endSem: ''),
  'Class-9': Marks(sessional1: '',sessional2: '',midSem: '',endSem: ''),
  'Class-10': Marks(sessional1: '',sessional2: '',midSem: '',endSem: ''),
  'Class-11': Marks(sessional1: '',sessional2: '',midSem: '',endSem: ''),
  'Class-12': Marks(sessional1: '',sessional2: '',midSem: '',endSem: ''),


};

Future<void> fetchStudents() async {
  final url='https://edunep-75d45.firebaseio.com/students.json?auth=$_authToken';
try {
  final response=await http.get(url);
  final List<Student> fetchedStudents=[];
  final extractedData=json.decode(response.body) as Map<String,dynamic>;
  if(extractedData==null)
  {return;}
  extractedData.forEach((uID, studentData) {
      fetchedStudents.add(Student(
        firstName: studentData['firstName'],
        dob:studentData['dob'],
        email: studentData['email'],
        curClass: studentData['curClass'],
        curSubjects: (studentData['curSubjects'] as List<dynamic>).cast<String>(),
        newClass: studentData['newClass'],
        id: uID,
        // curMarks: studentData['curMarks'],
        // marksheet: studentData['marksheet'], implement karna h abhi
      ));
    });

    _studentList=fetchedStudents;
}catch(error){
  throw error;
}

}


Future<void> addStudent(Student newStu) async
{ final url='https://edunep-75d45.firebaseio.com/students.json?auth=$_authToken';
  

try {  final response = await http.post(url,body:json.encode({
    "firstName":newStu.firstName,
    "curClass": newStu.curClass,
    "curSubjects": tempCurSubs,
    "dob":newStu.dob,
    "email":newStu.email,
    "newClass":newStu.newClass,
    'id':_userId,
    // 'curMarks': {
    //   'sessional1':_curMarks.sessional1,
    //   'sessional2':_curMarks.sessional2,
    //   'midSem':_curMarks.midSem,
    //   'endSem':_curMarks.endSem,
    // } ,
    // 'marksheet':_studentMarksheet.forEach((std, marks) {
    //   return { '$std': { 'sessional1':marks.sessional1 ,'sessional2':marks.sessional2,'midSem':marks.midSem,'endSem':marks.endSem} };
    //  })
  })); 

  localID=json.decode(response.body)['name'];
  final newStudent= Student(
  firstName: newStu.firstName,
  curClass: newStu.curClass,
  curSubjects: newStu.curSubjects,
  dob: newStu.dob,
  email: newStu.email,
  id : json.decode(response.body)['name'],   
);
  
  _studentList.add(newStudent);
  notifyListeners();
 }catch (error) {
   throw error;
 }
}

List<String> tempCurSubs=['Science','English-A','English-B','History','Civics'
];

List<String> curSubs=[
];

void updateSubjects(String sub)
{ if(curSubs.contains(sub))
    {  curSubs.remove(sub);  }
    else
    {curSubs.add(sub);}
  print(curSubs);
}



Future<void> updateCurSubs() async {
  print("updating current subjects");
  print(_userId);
final url='https://edunep-75d45.firebaseio.com/students.json?auth=$_authToken&orderBy="id"&equalTo="$_userId"';  
   await http.patch(url,body:json.encode({
    'curSubjects':curSubs,
    'firstName':"Sajjal",
  }));
  
  final response = await http.get(url);
  print("updates subs:");
  print(json.decode(response.body)['curSubjects']);
  print(json.decode(response.body)['firstName']);
notifyListeners();
}

}