import 'package:flutter/material.dart';
import './notification_model.dart' as notice;
import 'package:http/http.dart' as http;
import 'dart:convert';

class Notifications with ChangeNotifier {
  List<notice.Notification> _allNotifications = [];

  List<notice.Notification> get allItems {
    return [..._allNotifications];
  }

  Future<void> fetchTrainings() async {
    const url = 'https://volsungurapp.firebaseio.com/Notifications.json';
    final rsp = await http.get(url);
    print(json.decode(rsp.body));
    final _data = json.decode(rsp.body) as Map<String, dynamic>;
    final List<notice.Notification> loadedPractices = [];
    _data.forEach(
      (notificationId, notificationData) {
        loadedPractices.add(notice.Notification(
          id: notificationId,
          title: notificationData['title'],
          subject: notificationData['subject']
        ));
      },
    );
    _allNotifications = loadedPractices;
    notifyListeners();
  }
}
