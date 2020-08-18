import 'package:flutter/material.dart';
import '../providers/training_date_list.dart';
import 'package:provider/provider.dart';

class WeekItem extends StatelessWidget {
  final int index;
  WeekItem(this.index);

  @override
  Widget build(BuildContext context) {
    final List<String> months = [
      'Janúar',
      'Febrúar',
      'Mars',
      'Apríl',
      'Maí',
      'Júní',
      'Júli',
      'Ágúst',
      'September',
      'Október',
      'Nóvember',
      'Desember'
    ];

    final data = Provider.of<TrainingList>(context).allItems;
    print(data);
    return Center(
      child: Card(
        elevation: 10,
        shadowColor: Colors.green,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        color: Colors.black,
        child: Container(
          height: 140,
          width: 125,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                    child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                  child: Text(months[data[index].date.month-1],
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      )),
                )),
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: Container(
                    color: Colors.black,
                    child: Center(
                      child: Text(
                          data[index].date.day.toString(),
                              //.split('-')[2], //breyta - setja æfing eða frí
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(data[index].time.toString(), style: TextStyle(color: Colors.white)),
                Text(data[index].location,
                    style: TextStyle(color: Colors.white)),
                SizedBox(height:10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
