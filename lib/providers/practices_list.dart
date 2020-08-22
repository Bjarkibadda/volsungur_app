import 'package:flutter/material.dart';
import './practice_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Practices with ChangeNotifier {
  List<Practice> _allTrainings = [];
  final String authToken;
  final String userId;

  Practices(this.authToken, this.userId, this._allTrainings);

  List<Practice> get allItems {
    return [..._allTrainings];
  }

  List<Practice> get favoriteItems {
    return _allTrainings.where((practice) => practice.isFavorite).toList();
  }

  List<Practice> get notFavoriteItems {
    return _allTrainings.where((practice) => !practice.isFavorite).toList();
  }

  List<Practice> get doneItems {
    return _allTrainings.where((practice) => practice.isDone).toList();
  }

  List<Practice> get doneAndFavItems {
    return _allTrainings
        .where((practice) => practice.isDone && practice.isFavorite)
        .toList();
  }

  List<Practice> get notDoneAndNotFavItems {
    return _allTrainings
        .where((practice) => !practice.isDone && !practice.isFavorite)
        .toList();
  }

  List<Practice> get notDoneAndFavItems {
    return _allTrainings
        .where((practice) => !practice.isDone && practice.isFavorite)
        .toList();
  }

  List<Practice> get notDoneItems {
    return _allTrainings.where((practice) => !practice.isDone).toList();
  }

  List<Practice> get doneAndNotFav {
    return _allTrainings
        .where((practice) => practice.isDone && !practice.isFavorite)
        .toList();
  }

  // List<Practice> get filteredPractices(int group){
  //   return _allTrainings.where((practice) => practice.)
  // }

  Future<void> fetchTrainings() async {
    final url =
        'https://volsungurapp.firebaseio.com/kalli.json?auth=$authToken';
    final rsp = await http.get(url);
    final _data = json.decode(rsp.body) as Map<String, dynamic>;
    final List<Practice> loadedPractices = [];
    final doneUrl =
        'https://volsungurapp.firebaseio.com/doneTrainings/$userId.json?auth=$authToken';
    final doneRsp = await http.get(doneUrl);
    final doneData = json.decode(doneRsp.body);
    final favoriteUrl =
        'https://volsungurapp.firebaseio.com/favoriteTrainings/$userId.json?auth=$authToken';
    final favoriteRsp = await http.get(favoriteUrl);
    final favoriteData = json.decode(favoriteRsp.body);
    

    _data.forEach(
      (practiceId, practiceData) {
        loadedPractices.add(
          Practice(
            id: practiceId,
            name: practiceData['name'],
            url: practiceData['url'],
            flokkur: practiceData['flokkur'],
            gender: practiceData['gender'],
            isFavorite: favoriteData == null ? false : favoriteData['$practiceId'] ?? false,
            isDone: doneData == null ? false : doneData['$practiceId'] ?? false,
            date: DateTime.parse(practiceData['date'],),
            information: practiceData['information'],
          ),  
             );
             print(practiceData['information']);     
      },
    );
    
    _allTrainings = loadedPractices.reversed.toList();
    notifyListeners();
  }

    Future<void> addPractice(Practice practice) async {
    final DateTime date = DateTime.now();
    final url =
        'https://volsungurapp.firebaseio.com/kalli.json?auth=$authToken';
    final rsp = await http.post(url,
        body: json.encode({
          'name': practice.name,
          'gender': practice.gender,
          'flokkur': practice.flokkur,
          'url': practice.url,
          'date': date.toIso8601String(),
          'information': practice.information
        }));
  }
}
