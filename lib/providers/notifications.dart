import 'package:flutter/material.dart';
import './notification_model.dart' as notice;
import 'package:http/http.dart' as http;
import 'dart:convert';

class Notifications with ChangeNotifier {
  List<notice.Notification> _allNotifications = [];
  final String authToken;

  Notifications(this.authToken, this._allNotifications);

  List<notice.Notification> get allItems {
    return [..._allNotifications];
  }

  Future<void> fetchNotifications() async {
    final url =
        'https://volsungurapp.firebaseio.com/Notifications.json?auth=$authToken';
    final rsp = await http.get(url);
    final _data = json.decode(rsp.body) as Map<String, dynamic>;
    final List<notice.Notification> loadedPractices = [];
    _data.forEach(
      (notificationId, notificationData) {
        loadedPractices.add(notice.Notification(
            id: notificationId,
            title: notificationData['title'],
            subject: notificationData['subject'],
            gender: notificationData['gender'],
            grp: notificationData['group']));
      },
    );
    _allNotifications = loadedPractices;
    notifyListeners();
  }
}
