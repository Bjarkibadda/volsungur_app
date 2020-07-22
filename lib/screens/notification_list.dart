import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/notifications.dart';
import 'package:intl/intl.dart';

class NotificationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notifications = Provider.of<Notifications>(context);
    return Container(
        padding: EdgeInsets.all(5),
        height: 200,
        child: ListView.builder(
          itemCount:
              notifications.allItems.length < 4 // if there are fewer then 4.
                  ? notifications.allItems.length
                  : 4,
          itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
            value: notifications.allItems[i],
            child: Card(
              elevation: 10,
              color: Colors.black87,
              shadowColor: Colors.white,
              child: ListTile(
                leading:
                    Icon(Icons.notification_important, color: Colors.white),
                title: Text(
                    DateFormat('dd-MM-yyy').format(DateTime.now()) +
                        '    ${notifications.allItems[i].title}',
                    style: TextStyle(color: Colors.white)),
                //${notifications.allItems[i].title}',
                //  style: TextStyle(color: Colors.white))),
              ),
            ),
          ),
        ));
  }
}
