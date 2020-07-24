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
    final data = Provider.of<TrainingList>(context).allItems;
    print(data[0].location);
    print(data[1].location);
    return Center(
      child: Card(
        elevation: 10,
        shadowColor: Colors.green,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        color: Colors.green,
        child: Container(
          height: 125,
          width: 125,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                    child: Text(data[index].date,
                        style: TextStyle(
                          fontSize: 15,
                        ))),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Container(
                    color: Colors.black,
                    child: ListTile(
                      title: Text(
                          data[index]
                              .date
                              .split('-')[2], //breyta - setja æfing eða frí
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                  ),
                ),
                //SizedBox(height: 10,),
                Text(data[index].time),
                Text(data[index].location)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
