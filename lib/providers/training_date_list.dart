import 'dart:io';

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
    return [..._allTrainings];
  }

  bool get isTraining {
    // returns true if there are no training for next seven days, otherwise false!
    if (_allTrainings.length == 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> fetchTrainings() async {
    final url =
        'https://volsungurapp.firebaseio.com/groupPractice.json?auth=$authToken';
    try {
      final rsp = await http.get(url);
      if (rsp.statusCode == 200) {
        final _data = json.decode(rsp.body) as Map<String, dynamic>;
        print('status code: ${rsp.statusCode}');
        final List<Training> loadedPractices = [];
        if (_data != null && rsp.statusCode == 200) {
          _data.forEach(
            (trainingId, practiceData) {
              DateTime newDate = DateTime.parse(practiceData['date']);
              int diffDays = newDate.difference(DateTime.now()).inDays;
              if (diffDays < 7 &&
                  newDate.day.compareTo(DateTime.now().day) >= 0) {
                loadedPractices.add(Training(
                    id: trainingId,
                    location: practiceData['location'],
                    time: practiceData['time'],
                    date: DateTime.parse(practiceData['date']),
                    gender: practiceData['gender'],
                    grp: practiceData['grp']));
              }
            },
          );
        }
        _allTrainings = loadedPractices;
        loadedPractices.sort((a, b) {
          // sorting the list after date
          return a.date.compareTo(b.date);
        });
        notifyListeners();
      }
      if (rsp.statusCode != 200) {
        print(rsp.statusCode);
        return null;
      }
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<void> addGroupTraining(Training newGroupTraining) async {
    final url =
        'https://volsungurapp.firebaseio.com/groupPractice.json?auth=$authToken';
    final rsp = await http.post(url,
        body: json.encode({
          'location': newGroupTraining.location,
          'gender': newGroupTraining.gender,
          'grp': newGroupTraining.grp,
          'time': newGroupTraining.time,
          'date': newGroupTraining.date.toIso8601String()
        }));
    print(newGroupTraining.time);
  }
}
