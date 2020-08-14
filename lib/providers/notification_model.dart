import 'package:flutter/foundation.dart';


class Notification with ChangeNotifier {
  final String id;
  final String title;
  final String subject;
  final bool gender;
  final int grp;
  DateTime date;

Notification({
    @required this.id,
    @required this.title,
    @required this.subject,
    @required this.gender,
    @required this.grp,
    this.date
  });
}