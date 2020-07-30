import 'package:flutter/material.dart';
import 'package:volsungur_app/screens/all_practices_screen.dart';
import './practice_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './training_date_model.dart';
import 'package:intl/intl.dart';

class TrainingList with ChangeNotifier {
  List<Training> _allTrainings = [];
  final String authToken;

  TrainingList(this.authToken, this._allTrainings);

  List<Training> get allItems {
    print(_allTrainings);
    return [..._allTrainings];
  }

  Future<void> fetchTrainings() async {
    final url =
        'https://volsungurapp.firebaseio.com/kukur.json?auth=$authToken'; //breyta
    final rsp = await http.get(url);
    final _data = json.decode(rsp.body) as Map<String, dynamic>;
    final List<Training> loadedPractices = [];
    _data.forEach(
      (trainingId, practiceData) {
        DateTime newDate = DateTime.parse(practiceData['date']);
        int diffDays = newDate.difference(DateTime.now()).inDays;
        if (diffDays < 7) {
          loadedPractices.add(Training(
              id: trainingId,
              location: practiceData['location'],
              time: practiceData['time'],
              date: practiceData['date']));
        }
      },
    );
    _allTrainings = loadedPractices;
    notifyListeners();
  }

  // List<Training> get nextWeek {
  //   var dateFormat = DateFormat('MM-dd-yyyy');
  //   final List<Training> loadedPractices = [];
  //   _allTrainings.forEach((element) {
  //     print('dateSTRING: ${element.date}');
  //     DateTime newDate = DateTime.parse(element.date);
  //     print('Newdate: $newDate');
  //     print(DateTime.now().day);
  //     int diffDays = newDate.difference(DateTime.now()).inDays;

  //     String newnewDate = dateFormat.format(newDate);
  //     if (diffDays < 7) {
  //       print('element: $diffDays');
  //       print(element.location);
  //       loadedPractices.add(element);
  //     }
  //   });
  //   _weekTrainings = loadedPractices;
  //   return [..._weekTrainings];
  //}
}
