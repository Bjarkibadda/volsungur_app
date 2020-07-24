import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volsungur_app/providers/training_date_model.dart';
import './week_item.dart';
import '../providers/training_date_list.dart';

class TrainingWeek extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final train = Provider.of<TrainingList>(context);
    List<Training> trainingData = train.allItems;
    int count = 0;

    return Container(
      child: ListView.builder(
        itemCount: trainingData.length,
        padding: EdgeInsets.all(5),
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
          value: trainingData[index],
          child: WeekItem(index),
        ),
      ),
    );
  }
}
