import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/notifications.dart';

class NotificationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notifications = Provider.of<Notifications>(context);
    return Container(
      height: 100,
      child: GridView.builder(
        itemCount: notifications.allItems.length,
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          value: notifications.allItems[i],
          child: Text(
            notifications.allItems[i].title
          ),
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
      ),
    );
  }
}
