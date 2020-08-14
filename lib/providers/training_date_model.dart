import 'package:flutter/foundation.dart';


class Training with ChangeNotifier {
  final String id;
  final String location;
  final DateTime date;
  final String time;
  final int grp;
  final bool gender;

  Training({
    @required this.id,
    @required this.location,
    @required this.time,
    @required this.date,
    @required this.grp,
    @required this.gender,
  });
}