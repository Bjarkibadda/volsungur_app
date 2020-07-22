import 'package:flutter/material.dart';

class WeekItem extends StatelessWidget {
  final String practiceTitle = 'Það er æfing';

  //PracticeItem(this.practiceTitle);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          color: Colors.green,
          child: Container(
            height: 150,
            width: 150,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(child: Text('Æfing')),
                  Center(
                    child: ListTile(
                      title: Text('22',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                      subtitle: Text('svona er þetta'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
