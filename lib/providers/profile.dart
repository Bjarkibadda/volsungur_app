import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UserProfile with ChangeNotifier {
  final String authToken;
  final String userId;

  UserProfile(this.authToken, this.userId);

  Future<void> saveProfile(String name, int age, bool gender) async {
    final url =
        'https://volsungurapp.firebaseio.com/userprofiles.json?auth=$authToken';
    final rsp = await http.post(url,
        body: json.encode({
          'name':  name,
          'gender': gender,
          'age': age,
        }));
        print(json.encode(rsp.body));
  }
}
