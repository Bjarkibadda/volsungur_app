import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UserProfile with ChangeNotifier {
  final String authToken;
  final String userId;
  int _flokkur = 0;
  bool _gender = true;
  bool _coach = false;

  UserProfile(
    this.authToken,
    this.userId,
  );

  Future<void> saveProfile(String name, int flokkur, bool gender) async {
    final url =
        'https://volsungurapp.firebaseio.com/userprofiles/$userId.json?auth=$authToken';
    final rsp = await http.put(url,
        body: json.encode({
          'name': name,
          'gender': gender,
          'flokkur': flokkur,
          'coach' : false,
        }));
  }

  Future<void> fetchUser() async {
    final url =
        'https://volsungurapp.firebaseio.com/userprofiles/$userId/.json?auth=$authToken';
    final rsp = await http.get(url);
    final _userList = json.decode(rsp.body) as Map<String, dynamic>;
    _flokkur = _userList['flokkur'];
    _gender = _userList['gender'];
    _coach = _userList['coach'];
  }

  get flokkur {
    return _flokkur;
  }

  get gender {
    return _gender;
  }

    get coach {
    return _coach;
  }
}
