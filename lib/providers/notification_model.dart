import 'package:flutter/foundation.dart';

import 'dart:convert';

class Notification with ChangeNotifier {
  final String id;
  final String title;
  final String subject;

Notification({
    @required this.id,
    @required this.title,
    @required this.subject,
  });

}