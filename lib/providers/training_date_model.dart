import 'package:flutter/foundation.dart';


class Training with ChangeNotifier {
  final String id;
  final String location;
  final String date;
  final String time;

  Training({
    @required this.id,
    @required this.location,
    @required this.time,
    @required this.date,
  });
}