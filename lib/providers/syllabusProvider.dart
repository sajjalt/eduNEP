import 'dart:async';
import 'dart:convert';

import 'package:eduNEP/providers/student_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../models/subject.dart';
import '../providers/subject_provider.dart';

class Syllabus with ChangeNotifier {
  String _authToken;

 Map<String, List<Subject>> curSyllabus = {
  
    'Class-10': [
      Subject(
        id: 's1',
        title: 'Science',
        chapters: 18,
        std: 'Class-10',
        chapterTitle: [
          'Chapter 1: Crop Production and Management',
          'Chapter 2: Microorganisms Friend and Foe',
          'Chapter 3: Synthetic Fibres and Plastics',
          'Chapter 4: Materials Metals and Non – Metals',
          'Chapter 5: Coal and Petroleum',
          'Chapter 6: Combustion and Flame',
          'Chapter 7: Conservation of Plants and Animals',
          'Chapter 8: Cell-Structure and Functions',
          'Chapter 9: Reproduction in Animals',
          'Chapter 10: Reaching the Age of Adolescence',
          'Chapter 11: Force and Pressure',
          'Chapter 12: Friction',
          'Chapter 13: Sound',
          'Chapter 14: Chemical Effects of Electric Current',
          'Chapter 15: Some Natural Phenomena',
          'Chapter 16: Light',
          'Chapter 17: Stars and the Solar System',
          'Chapter 18: Pollution of Air and Water',
        ],
        image: 'science',
        bgColor: Colors.red[700],
      ),
      Subject(
        id: 's2',
        title: 'Mathematics',
        chapters: 16,
        std: 'Class-10',
        chapterTitle: [
          'Chapter 1 Rational Numbers',
          'Chapter 2 Linear Equations in One Variable',
          'Chapter 3 Understanding Quadrilaterals',
          'Chapter 4 Practical Geometry',
          'Chapter 5 Data Handling',
          'Chapter 6 Squares and Square Roots',
          'Chapter 7 Cubes and Cube Roots',
          'Chapter 8 Comparing Quantities',
          'Chapter 9 Algebraic Expressions and Identities',
          'Chapter 10 Visualising Solid Shapes',
          'Chapter 11 Mensuration',
          'Chapter 12 Exponents and Powers',
          'Chapter 13 Direct and Inverse Proportions',
          'Chapter 14 Factorisation',
          'Chapter 15 Introduction to Graphs',
          'Chapter 16 Playing with Numbers',
        ],
        image: 'img2',
        bgColor: Colors.teal[700],
      ),
      Subject(
        id: 's3',
        title: 'English-A',
        chapters: 10,
        std: 'Class-10',
        chapterTitle: [
          'Chapter 1: The Best Christmas Present in the World',
          'Chapter 2: The Tsunami',
          'Chapter 3: Glimpses of the Past',
          'Chapter 4: Bepin Choudhury’s Lapse of Memory',
          'Chapter 5: The Summit Within',
          'Chapter 6: This is Jody’s Fawn',
          'Chapter 7: A Visit to Cambridge',
          'Chapter 8: A Short Monsoon Diary',
          'Chapter 9: The Great Stone Face-I',
          'Chapter 10: The Great Stone Face-II',
        ],
        image: 'img1',
        bgColor: Colors.blue[700],
      ),
      Subject(
        id: 's4',
        title: 'English-B',
        chapters: 11,
        std: 'Class-10',
        chapterTitle: [
          'Chapter 1: How The Camel Got His Hump',
          'Chapter 2: Children At Work',
          'Chapter 3: The Selfish Giant',
          'Chapter 4: The Treasure Within',
          'Chapter 5: Princess September',
          'Chapter 6: The Fight',
          'Chapter 7: The Open Window',
          'Chapter 8: Jalebis',
          'Chapter 9: The comet-I',
          'Chapter 10: The comet-II',
          'Chapter 11: Ancient Education System of India',
        ],
        image: 'img4',
        bgColor: Colors.blue[700],
      ),
      // Subject(
      //   id: 's5',
      //   title: 'History',
      //   chapters: 10,
      //   std: 'Class-10',
      //   chapterTitle: [
      //     'Chapter 1 -How, When & Where?',
      //     'Chapter 2 -From Trade to Territory',
      //     'Chapter 3- Ruling the Countryside',
      //     'Chapter 4 – Tribals, Dikus and the Vision of a Golden Age',
      //     'Chapter 5 – When People Rebel 1857',
      //     'Chapter 6 – Weavers, Iron Smelters and Factory Owners',
      //     'Chapter 7 – Civilising the “Native”, Educating the Nation',
      //     'Chapter 8 – Women, Caste and Reform',
      //     'Chapter 9 – The Making of the National Movement: 1870s–1947',
      //     'Chapter 10 – India After Independence',
      //   ],
      //   image: 'img2',
      //   bgColor: Colors.brown[700],
      // ),
      // Subject(
      //   id: 's6',
      //   title: 'Civics',
      //   chapters: 10,
      //   std: 'Class-10',
      //   chapterTitle: [
      //     'Chapter 1 – The Indian Constitution',
      //     'Chapter 2 – Understanding Secularism',
      //     'Chapter 3 – Why do we need a Parliament?',
      //     'Chapter 4 – Understanding Laws',
      //     'Chapter 5 – Judiciary',
      //     'Chapter 6 – Understanding Our Criminal Justice System',
      //     'Chapter 7 – Understanding Marginalisation',
      //     'Chapter 8 – Confronting Marginalisation',
      //     'Chapter 9 – Public Facilities',
      //     'Chapter 10 – Law and Social Justice',
      //   ],
      //   image: 'img3',
      //   bgColor: Colors.orange[700],
      // ),
      // Subject(
      //   id: 's7',
      //   title: 'Geography',
      //   chapters: 6,
      //   std: 'Class-10',
      //   chapterTitle: [
      //     'Chapter 1 – Resources',
      //     'Chapter 2 – Natural Vegetation and Wildlife',
      //     'Chapter 3 – Mineral and Power Resources',
      //     'Chapter 4 – Agriculture',
      //     'Chapter 5 – Industries',
      //     'Chapter 6 – Human Resources',
      //   ],
      //   image: 'img4',
      //   bgColor: Colors.green[700],
      // ),
    ],
  };

  void update(String token, Map<String, List<Subject>> subList) {
    _authToken = token;
    curSyllabus = subList;
  }

  Future<void> updateSyllabus() async {
    curSyllabus.forEach((curClass, subject) async {
      final url =
          'https://edunep-75d45.firebaseio.com/syllabus/$curClass.json?auth=$_authToken';

      subject.forEach((sub) async {
        try {
          final response = await http.post(url,
              body: json.encode({
                'title': sub.title,
                'std': sub.std,
                'chapters': sub.chapters,
                'chapterTitle': sub.chapterTitle,
                'image': sub.image,
                'bgColor': '${sub.bgColor}',
              }));

          // final newSub=Subject(
          //   title: json.decode(response.body)['title'],
          //   std: json.decode(response.body)['std'],
          //   chapters: json.decode(response.body)['chapters'],
          //   chapterTitle: json.decode(response.body)['chapterTitle'],
          //   image: json.decode(response.body)['image'],
          //   bgColor: json.decode(response.body)['bgColor'],
          //   id: json.decode(response.body)['name'],
          // );

        } catch (error) {
          throw error;
        }
      });
    });
  }

  Future<void> fetchSyllabus(String curClass) async {
    final url = 'https://edunep-75d45.firebaseio.com/syllabus/$curClass.json?auth=$_authToken';

    try {
      final response = await http.get(url);
      final List<Subject> fetchedSubjects = [];
      print(json.decode(response.body));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      print("data extracted");

      extractedData.forEach((sID, sub) {
        fetchedSubjects.add(Subject(
          title: sub['title'],
          id: sID,
          std: sub['std'],
          image: sub['image'],
          chapters: sub['chapters'],
          chapterTitle: (sub['chapterTitle'] as List<dynamic>).cast<String>(),
          bgColor: Color(int.parse(sub['bgColor'])),
        ));
      });
      print(fetchedSubjects);
      // curSyllabus.update(curClass, (_) => fetchedSubjects);
      curSyllabus[curClass]=fetchedSubjects;
      print(curSyllabus);
      print(curSyllabus['Class-10'][0].bgColor);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  List<Subject> findByClass(String curClass) {
    return curSyllabus[curClass];
  }

  Subject findbyId(String id, String curClass) {
    return curSyllabus[curClass].firstWhere((element) => element.id == id);
  }
}
