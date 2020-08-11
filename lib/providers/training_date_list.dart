import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './training_date_model.dart';


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
        'https://volsungurapp.firebaseio.com/groupPractice.json?auth=$authToken'; //breyta
    final rsp = await http.get(url);
    final _data = json.decode(rsp.body) as Map<String, dynamic>;
    print('hello gamli: ${json.decode(rsp.body)}');
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
              date: practiceData['date'],
              gender: practiceData['gender'],
              grp: practiceData['grp']));
        }
      },
    );
    _allTrainings = loadedPractices;
    notifyListeners();
  }
}
