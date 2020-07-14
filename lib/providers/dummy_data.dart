import 'package:flutter/material.dart';
import './practice_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Practices with ChangeNotifier {
  List<Practice> _fixedTrainings = [
    Practice(
        //     id: DateTime.now().toString(),
        //     name: 'training1',
        //     url:
        //         "https://www.youtube.com/watch?v=bdneye4pzMw&list=RDbdneye4pzMw&start_radio=1",
        //     isRequired: false),
        // Practice(
        //   id: DateTime.now().toString(),
        //   name: 'training2',
        //   url:
        //       "https://www.youtube.com/watch?v=OPf0YbXqDm0&list=RDbdneye4pzMw&index=2",
        //   isRequired: false,
        ),
  ];

  List<Practice> get items {
    return [..._fixedTrainings];
  }

  Future<void> fetchTrainings() async {
    const url = 'https://volsungurapp.firebaseio.com/Practices.json';
    final rsp = await http.get(url);
    final _data = json.decode(rsp.body) as Map<String, dynamic>;
    final List<Practice> loadedPractices = [];
    _data.forEach(
      (practiceId, practiceData) {
        loadedPractices.add(
          Practice(
              id: practiceId,
              name: practiceData['name'],
              url: practiceData['url'],
              isRequired: practiceData['isRequired'],
              isFavorite: practiceData['isFavorite']),
        );
      },
    );
    _fixedTrainings = loadedPractices;
    notifyListeners();
  }
}
