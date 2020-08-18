import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Practice with ChangeNotifier {
  final String id;
  final String name;
  final String url;
  final String information;
  final int flokkur;
  final bool gender;
  final DateTime date;
  bool isDone;
  bool isFavorite;

  Practice({
    @required this.id,
    @required this.name,
    @required this.url,
    @required this.flokkur,
    @required this.gender,
    this.date,
    this.isDone = false,
    this.isFavorite = false,
    this.information = '',
  });

  void toggleDoneStatus() {
    isDone = !isDone;
    notifyListeners();
  }

  Future<void> updateDoneStatus(String auth, String userId) async {
    final url =
        'https://volsungurapp.firebaseio.com/doneTrainings/$userId/$id.json?auth=$auth';

    await http.put(url,
        body: json.encode(
          isDone,
        )); // here should be error handling and also if failed we should roll back. He did id like that but this is my solution
  }

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  Future<void> updateFavoriteStatus(String auth, String userId) async {
    final url =
        'https://volsungurapp.firebaseio.com/favoriteTrainings/$userId/$id.json?auth=$auth';
    try {final rsp = await http.put(url,
        body: json.encode(
          isFavorite,
        )); // here should be error handling and also if failed we should roll back. He did id like that but this is my solution
  } catch(error){
    print('error');
    throw Error;
  }}
}
