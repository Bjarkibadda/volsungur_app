import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volsungur_app/providers/practice_model.dart';
import '../providers/dummy_data.dart';
import './practice_item.dart';

class PracticeGrid extends StatelessWidget {
  final bool builderCount;
  final List<bool> filters;

  PracticeGrid({
    @required this.builderCount,
    this.filters = const [false, false, false, false],
  });

  @override
  Widget build(BuildContext context) {
    final train = Provider.of<Practices>(context);
    List<Practice> practiceData;
    int count = 0;
    bool notDone = filters[0];
    bool done = filters[1];
    bool favorite = filters[2];
    bool notFavorite = filters[3];
    print(filters);

    if (done && notFavorite==false && favorite==false) {
      practiceData = train.doneItems;
      count = practiceData.length;
    } 

    else if (done && notFavorite) {
      practiceData = train.doneAndNotFav;
      count = practiceData.length;
    } 

    else if (done && favorite) {
      practiceData = train.doneAndFavItems;
      count = practiceData.length;
    } 
    
    
    else if (notDone && !notFavorite && !favorite) {
      print('notDone');
      practiceData = train.notDoneItems;
      count = practiceData.length;
    } 
    
    else if (notDone && notFavorite) {
      practiceData = train.notDoneAndNotFavItems;
      count = practiceData.length;
    }

    else if (notDone && favorite) {
      practiceData = train.notDoneAndFavItems;
      count = practiceData.length;
    } 

     
    else if (notFavorite && !notDone && !done) {
      practiceData = train.notFavoriteItems;
      count = practiceData.length;
      print('hello');
    } 

    else if (favorite && !notDone && !done) {
      practiceData = train.favoriteItems;
      count = practiceData.length;
    } 
    
    else {
      practiceData = train.allItems;
      print('all items');
      count = practiceData.length;
    }

    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: builderCount ? 4 : count,
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
  }
}
