import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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