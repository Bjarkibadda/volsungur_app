import 'package:flutter/material.dart';
import 'package:volsungur_app/providers/profile.dart';
import 'package:volsungur_app/screens/add_group_training_screen.dart';
import 'package:volsungur_app/screens/add_notification_screen.dart';
import 'package:volsungur_app/screens/add_practice_screen.dart';
import '../providers/auth.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  // void didChangeDependencies(){
  //   Provider.of<UserProfile>(context)
  // }

  @override
  Widget build(BuildContext context) {
    var _isCoach = false;
    _isCoach = Provider.of<UserProfile>(context).coach;
    print(_isCoach);
    return Drawer(
        child: Container(
      decoration: BoxDecoration(
        color: Colors.black,
      ),
      child: ListView(
        children: <Widget>[
          Container(
            color: Colors.black,
            child: AppBar(
              title: Text('Aðgerðir', style: TextStyle(color: Colors.white)),
              automaticallyImplyLeading: false,
            ),
          ),
          Divider(),
          _isCoach
              ? ListTile(
                  leading: Icon(Icons.power, color: Colors.white),
                  title: Text('Bæta við æfingu',
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.of(context).pushNamed(AddPractice.routeName);
                  },
                )
              : Container(),
          _isCoach
              ? ListTile(
                  leading: Icon(Icons.power, color: Colors.white),
                  title: Text('Bæta við tilkynningu',
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.of(context).pushNamed(AddNotification.routeName);
                  },
                )
              : Container(),
          _isCoach
              ? ListTile(
                  leading: Icon(Icons.power, color: Colors.white),
                  title: Text('Bæta við æfingaáætlun',
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.of(context).pushNamed(AddGroupTraining.routeName);
                  },
                )
              : Container(),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            title: Text('Skrá út', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
        ],
      ),
    ));
  }
}
