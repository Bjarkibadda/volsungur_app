import 'package:flutter/material.dart';
import 'package:volsungur_app/providers/profile.dart';
import 'package:volsungur_app/screens/add_group_training_screen.dart';
import 'package:volsungur_app/screens/add_notification_screen.dart';
import 'package:volsungur_app/screens/add_practice_screen.dart';
import 'package:volsungur_app/screens/init_screen.dart';
import '../providers/auth.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  final bool _isCoach;

  AppDrawer(this._isCoach);
  // void didChangeDependencies(){
  //   Provider.of<UserProfile>(context)
  // }

  @override
  Widget build(BuildContext context) {
    var _isCoach = false;
    _isCoach = Provider.of<UserProfile>(context).coach;
    print(_isCoach);
    return 
         Drawer(
            child: Column(
            children: <Widget>[
              AppBar(
                title: Text('Aðgerðir'),
                automaticallyImplyLeading: false,
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.payment),
                title: Text('Flokkur'),
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(InitScreen.routeName);
                },
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Skrá út'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacementNamed('/');
                  Provider.of<Auth>(context, listen: false).logout();
                },
              ),
              _isCoach ? 
                ListTile(
                  leading: Icon(Icons.power),
                  title: Text('Bæta við æfingu'),
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(AddPractice.routeName);
                  },
                ): Container(),
                _isCoach ?
                 ListTile(
                  leading: Icon(Icons.power),
                  title: Text('Bæta við tilkynningu'),
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(AddNotification.routeName);
                  },
                ) : Container(),
                _isCoach ?
                 ListTile(
                  leading: Icon(Icons.power),
                  title: Text('Bæta við æfingaáætlun'),
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(AddGroupTraining.routeName);
                  },
                ) : Container()
            ],
          ));
  }
}
