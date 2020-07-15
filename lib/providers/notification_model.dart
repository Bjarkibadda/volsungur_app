import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
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