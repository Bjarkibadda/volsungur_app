import 'package:flutter/material.dart';
import '../providers/training_date_list.dart';
import 'package:provider/provider.dart';

class WeekItem extends StatelessWidget {
  final int index;
  // final DateTime date;
  // final String location;
  // final String time;

  //WeekItem(this.practiceTitle, this.date, this.location, this.time);
  WeekItem(this.index);

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<TrainingList>(context).allItems[index];
    return  Center(
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          color: Colors.green,
          child: Container(
            height: 125,
            width: 125,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(child: Text(data.date, style: TextStyle(fontSize: 15, ))),
                  SizedBox(height: 10,),
                  Center(
                    child: Container(
                      color: Colors.pink,
                      child: ListTile(
                        title: Text(data.date.split('/')[0],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)),
                        // subtitle: Text(
                        //   'Æfing',
                        //   textAlign: TextAlign.center,
                        //   style: TextStyle(
                        //       fontSize: 15, fontWeight: FontWeight.bold),
                        // ),
                      ),
                    ),
                  ),
                  //SizedBox(height: 10,),
                  Text(data.time),
                  Text(data.location)
                ],
              ),
            ),
          ),
        ),
      );
  }
}
