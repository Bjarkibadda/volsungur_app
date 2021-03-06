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
    final filteredList = notifications
        .where((notification) =>
            notification.gender == gender && notification.grp == grp)
        .toList();

    return Container(
      padding: EdgeInsets.all(5),
      height: 200,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
          itemCount: filteredList.length < 4 // if there are fewer then 4.
              ? filteredList.length
              : 4,
          itemBuilder: (ctx, i) {
            final item = filteredList[i];
            return Card(
              elevation: 10,
              color: Colors.black87,
              shadowColor: Colors.white,
              child: GestureDetector(
                onTap: () {
                  showGeneralDialog(
                      context: context,
                      transitionBuilder: (context, a1, a2, widget) {
                        final curvedValue =
                            Curves.easeInOutBack.transform(a1.value) - 1.0;

                        return Opacity(
                          opacity: a1.value,
                          child: Transform(
                              transform: Matrix4.translationValues(
                                  0.0, curvedValue * 200, 0.0),
                              child: SimpleDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    side: BorderSide(
                                        style: BorderStyle.solid,
                                        width: 3,
                                        color: Colors.white)),
                                title: Text(
                                  notifications[i].title,
                                  textAlign: TextAlign.center,
                                ),
                                elevation: 100.0,
                                backgroundColor: Theme.of(context).primaryColor,
                                titlePadding:
                                    EdgeInsets.only(top: 20, bottom: 15),
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 30, right: 30, bottom: 30),
                                    child: Text(
                                      notifications[i].subject,
                                      style: TextStyle(),
                                    ),
                                  ),
                                ],
                              )),
                        );
                      },
                      transitionDuration: Duration(milliseconds: 900),
                      barrierDismissible: true,
                      barrierLabel: '',
                      pageBuilder: (context, animation1, animation2) {});
                },
                child: ListTile(
                  leading:
                      Icon(Icons.notification_important, color: Colors.white),
                  title: Text('${item.title}',
                      style: TextStyle(color: Colors.white)),
                  trailing: Text(DateFormat('dd-MM-yyy').format(item.date),
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Colors.white)),
                  //${notifications.allItems[i].title}',
                  //  style: TextStyle(color: Colors.white))),
                ),
              ),
            );
          }),
    );
  }
}
