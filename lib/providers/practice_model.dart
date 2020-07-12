import 'package:flutter/foundation.dart';

class Practice with ChangeNotifier {
  final String id;
  final String url;
  final bool isRequired;

  Practice({
    @required this.id,
    @required this.url,
    @required this.isRequired,
  });
}
