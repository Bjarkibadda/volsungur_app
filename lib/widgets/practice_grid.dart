import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volsungur_app/providers/practice_model.dart';
import 'package:volsungur_app/widgets/no_trainings.dart';
import '../providers/dummy_data.dart';
import './practice_item.dart';

class PracticeGrid extends StatelessWidget {
  final bool builderCount;
  final List<bool> filters;
  final int grp;
  final bool gender;
  final bool isFiltered;

  PracticeGrid(
      {@required this.builderCount,
      @required this.grp,
      @required this.gender,
      this.filters = const [false, false, false, false],
      this.isFiltered = false});

  @override
  Widget build(BuildContext context) {
    //final int userGroup = Provider.of<UserProfile>(context).flokkur;
    final train = Provider.of<Practices>(context);

    List<Practice> practiceData;
    int count = 0;
    bool notDone = filters[0];
    bool done = filters[1];
    bool favorite = filters[2];
    bool notFavorite = filters[3];

    if (done && notFavorite == false && favorite == false) {
      practiceData = train.doneItems;
    } else if (done && notFavorite) {
      practiceData = train.doneAndNotFav;
    } else if (done && favorite) {
      practiceData = train.doneAndFavItems;
    } else if (notDone && !notFavorite && !favorite) {
      practiceData = train.notDoneItems;
    } else if (notDone && notFavorite) {
      practiceData = train.notDoneAndNotFavItems;
    } else if (notDone && favorite) {
      practiceData = train.notDoneAndFavItems;
    } else if (notFavorite && !notDone && !done) {
      practiceData = train.notFavoriteItems;
    } else if (favorite && !notDone && !done) {
      practiceData = train.favoriteItems;
    } else {
      practiceData = train.allItems;
    }

    if (isFiltered == false) {
      practiceData = practiceData
          .where((item) => item.flokkur == grp && item.gender == gender)
          .toList();
    }

    count = practiceData.length;
    if (count != 0) {
      return GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: count < 4 ? count : builderCount ? 4 : count,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          value: practiceData[
              i], //filters[1] ? train.favoriteItems[i] : train.allItems[i],
          child: PracticeItem(practiceData[i].name),
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
      );
    } else {
      return NoTrainings();
    }
  }
}
