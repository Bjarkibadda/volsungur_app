import 'package:flutter/material.dart';
import '../screens/training_screen.dart';
import '../screens/home_screen.dart';
class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: <Widget>[
        AppBar(
          title: Text('Hello Friend'),
          automaticallyImplyLeading: false,
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.payment),
          title: Text('Flokkur'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed(TrainingScreen.routeName);
          },
        ),
        ListTile(
          leading: Icon(Icons.shop),
          title: Text('Forsíða'),
          onTap: () {
            Navigator.of(context)
                .pushReplacementNamed(HomeScreen.routeName);
          },
        ),
      ],
    ));
  }
}