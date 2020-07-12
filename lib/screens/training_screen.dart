// skjár fyrir hvern flokk fyrir sig . Sýnir æfingar í lista sem þjálfarinn setur inn plús tilkynninga

import 'package:flutter/material.dart';
import '../providers/dummy_data.dart';
import 'package:provider/provider.dart';

class TrainingScreen extends StatelessWidget {
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final train = Provider.of<Practices>(context);
    return Scaffold(
        body: GridView(
      children: <Widget>[
        Text(train.items[0].url.toString()),
        Text(train.items[1].url.toString()),
      ],
      gridDelegate:
          SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 100),
    ));
  }
}
