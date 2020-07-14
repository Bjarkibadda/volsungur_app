import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Practice with ChangeNotifier {
  final String id;
  final String name;
  final String url;
  final bool isRequired;
  bool isFavorite;

  Practice({
    @required this.id,
    @required this.name,
    @required this.url,
    @required this.isRequired,
    this.isFavorite = false,
  });

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  Future<void> updateFavoriteStatus() async {
    final url = 'https://volsungurapp.firebaseio.com/Practices/$id.json';
    await http.patch(url,
        body: json.encode({
          'isFavorite': isFavorite,
        })); // here should be error handling and also if failed we should roll back. He did id like that but this is my solution
  }
}
