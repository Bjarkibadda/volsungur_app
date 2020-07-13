import 'package:flutter/foundation.dart';

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

}
