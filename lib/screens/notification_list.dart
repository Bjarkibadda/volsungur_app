import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volsungur_app/providers/profile.dart';
import '../providers/notifications.dart';
import 'package:intl/intl.dart';

class NotificationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notifications = Provider.of<Notifications>(context).allItems;
    final bool gender = Provider.of<UserProfile>(context).gender;
    final int grp = Provider.of<UserProfile>(context).flokkur;
    final filteredList = notifications.where((notification) => notification.gender == gender && notification.grp == grp).toList();

    return Container(
        padding: EdgeInsets.all(5),
        height: 200,
        child: ListView.builder(
          itemCount:
              filteredList.length < 4 // if there are fewer then 4.
                  ? filteredList.length
                  : 4,
          itemBuilder: (ctx, i) {
            final item = filteredList[i];
            return Card(
              elevation: 10,
              color: Colors.black87,
              shadowColor: Colors.white,
              child: ListTile(
                leading:
                    Icon(Icons.notification_important, color: Colors.white),
                title: Text(
                    DateFormat('dd-MM-yyy').format(DateTime.now()) +
                        '    ${item.title}',
                    style: TextStyle(color: Colors.white)),
                //${notifications.allItems[i].title}',
                //  style: TextStyle(color: Colors.white))),
              ),
            );
          }),
        );
  }
}
