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
    try{final rsp = await http.get(url);
    print('status code: ${rsp.statusCode}');
    if (rsp.statusCode == 200){
    final _data = json.decode(rsp.body) as Map<String, dynamic>;
    final List<notice.Notification> loadedPractices = [];
    _data.forEach(
      (notificationId, notificationData) {
        loadedPractices.add(
          notice.Notification(
            id: notificationId,
            title: notificationData['title'],
            subject: notificationData['subject'],
            gender: notificationData['gender'],
            grp: notificationData['grp'],
            date: DateTime.parse(notificationData['date']),
          ),
        );
      },
    );
    _allNotifications = List.from(loadedPractices.reversed);
    notifyListeners();
    }
    } on Error catch(error){
      print(error);
    
    } 

  }

  Future<void> addNotification(notice.Notification newNotification) async {
    // bæta við villumeðhöndlun
    final date = DateTime.now();
    print('hello world: ${newNotification.subject}');
    final url =
        'https://volsungurapp.firebaseio.com/Notifications.json?auth=$authToken';
    try{final rsp = await http.post(url,
        body: json.encode({
          'title': newNotification.title,
          'gender': newNotification.gender,
          'grp': newNotification.grp,
          'subject': newNotification.subject,
          'date': date.toIso8601String()
        }));
  } catch(Error){
    throw Error;
  }
}
}