import 'package:flutter/material.dart';
import './practice_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './training_date_model.dart';

class TrainingList with ChangeNotifier {
  List<Training> _allTrainings = [];

  List<Training> get allItems {
    print('hello world');
    print(_allTrainings[0]);
    return [..._allTrainings];
  }

  Future<void> fetchTrainings() async {
    const url = 'https://volsungurapp.firebaseio.com/kukur.json';
    final rsp = await http.get(url);
    print('Hérna kemur þetta fífl');
    print(json.decode(rsp.body));
    print('aftur');
    final _data = json.decode(rsp.body) as Map<dynamic,dynamic>;
    print(_data);
    final List<Training> loadedPractices = [];
    _data.forEach(
      (trainingId,practiceData) {
        loadedPractices.add(Training(
            id: trainingId,
            location: practiceData['location'],
            time: practiceData['time'],
            date: practiceData['date']));
      },
    );
    print(loadedPractices);
    _allTrainings = loadedPractices;
    notifyListeners();
  }
}
