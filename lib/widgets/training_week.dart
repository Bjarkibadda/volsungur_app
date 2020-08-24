import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volsungur_app/providers/profile.dart';
import 'package:volsungur_app/providers/training_date_model.dart';
import 'package:volsungur_app/widgets/no_trainings.dart';
import './week_item.dart';
import '../providers/training_date_list.dart';

class TrainingWeek extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final train = Provider.of<TrainingList>(context);
    final int grp = Provider.of<UserProfile>(context).flokkur;
    final bool gender = Provider.of<UserProfile>(context).gender;
    List<Training> trainingData = train.allItems;
    var filteredTrainings = trainingData.where((item) => item.grp == grp && item.gender == gender).toList();
    trainingData.forEach((element) {
    });

    print(filteredTrainings.length);

    
    return Expanded(
          child: Container(
        child: ListView.builder(
          itemCount: filteredTrainings.length,
          padding: EdgeInsets.all(5),
          scrollDirection: Axis.horizontal,
          itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
            value: filteredTrainings[index],
            child: WeekItem(index),
          ),
        ),
      ),
    );
     
  }
}
