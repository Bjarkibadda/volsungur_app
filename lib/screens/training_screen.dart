// skjár fyrir hvern flokk fyrir sig . Sýnir æfingar í lista sem þjálfarinn setur inn plús tilkynninga

import 'package:flutter/material.dart';
import 'package:volsungur_app/providers/practice_model.dart';
import 'package:volsungur_app/widgets/app_drawer.dart';
import '../providers/dummy_data.dart';
import 'package:provider/provider.dart';
import '../widgets/practice_item.dart';

class TrainingScreen extends StatelessWidget {
  static const routeName = '/training_screen';
  @override
  Widget build(BuildContext context) {
    final train = Provider.of<Practices>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Völsungur'),
      ),
      drawer: AppDrawer(),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
            child: Text('Æfingar vikunnar', style:TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          Container(
            height:400,
            child: GridView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: train.items.length,
              itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                value: train.items[i],
                child: PracticeItem(train.items[i].name),
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),

              //   Card(

              //       color: Colors.pink,
              //       child: PraciceItem(),),
              //   Card(
              //       margin: EdgeInsets.all(7),
              //       color: Colors.pink,
              //       child: Text(train.items[0].url.toString())),
              //   Card(
              //       margin: EdgeInsets.all(7),
              //       color: Colors.pink,
              //       child: Text(train.items[0].url.toString())),
              //   Card(
              //       margin: EdgeInsets.all(7),
              //       color: Colors.pink,
              //       child: Text(train.items[0].url.toString())),
              //   Card(
              //       margin: EdgeInsets.all(7),
              //       color: Colors.pink,
              //       child: Text(train.items[0].url
              //           .toString())), // setja þetta í nýjan file - widget
              // ],
              // gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              //maxCrossAxisExtent: 200),
            ),
          ),
        ],
      ),
    ); //);
  }
}
