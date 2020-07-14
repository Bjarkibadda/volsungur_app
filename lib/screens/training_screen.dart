// skjár fyrir hvern flokk fyrir sig . Sýnir æfingar í lista sem þjálfarinn setur inn plús tilkynninga

import 'package:flutter/material.dart';
import 'package:volsungur_app/providers/practice_model.dart';
import 'package:volsungur_app/widgets/app_drawer.dart';
import '../providers/dummy_data.dart';
import 'package:provider/provider.dart';
import '../widgets/practice_item.dart';

class TrainingScreen extends StatefulWidget {
  static const routeName = '/training_screen';

  @override
  _TrainingScreenState createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  @override
  void didChangeDependencies() {
    Provider.of<Practices>(context).fetchTrainings();
    super.didChangeDependencies();
  }

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
            child: Text('Æfingar vikunnar',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          Container(
            height: 300,
            child: PracticeGrid(train: train),
          ),
          Divider(color: Colors.pink),
        ],
      ),
    ); //);
  }
}

class PracticeGrid extends StatelessWidget {
  const PracticeGrid({
    Key key,
    @required this.train,
  }) : super(key: key);

  final Practices train;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
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
    );
  }
}
