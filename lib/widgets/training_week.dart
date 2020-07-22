import 'package:flutter/material.dart';
import './app_bar.dart';
import './app_drawer.dart';

class TrainingWeek extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: CustomAppBar(),
        ),
        drawer: AppDrawer(),
        body: Container(
          height: 200,
          child: ListView(
            padding: EdgeInsets.all(10),
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              // gera sér widget sem býr til Cardið? svo það þurfi ekki að stæla hvert og eitt
              Container(
                width: 150,
                child: Card(
                  color: Colors.pink,
                  child: Container(
                      decoration: BoxDecoration(shape: BoxShape.rectangle),
                      child: Text('hello world')),
                ),
              ),
              Card(
                child: Text('hello world'),
              ),
              Card(
                child: Text('hello world'),
              ),
              Card(
                child: Text('hello world'),
              ),
              Card(
                child: Text('hello world'),
              ),
              Card(
                child: Text('hello world'),
              ),
            ],
          ),
        ));
  }
}
