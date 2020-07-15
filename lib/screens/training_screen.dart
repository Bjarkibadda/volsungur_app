// skjár fyrir hvern flokk fyrir sig . Sýnir æfingar í lista sem þjálfarinn setur inn plús tilkynninga

import 'package:flutter/material.dart';
import 'package:volsungur_app/widgets/app_drawer.dart';
import '../providers/dummy_data.dart';
import 'package:provider/provider.dart';
import '../widgets/practice_grid.dart';


class TrainingScreen extends StatefulWidget {
  static const routeName = '/training_screen';

  @override
  _TrainingScreenState createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  var _isInit = true;
  var _isLoading = true;
  

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
    }
    Provider.of<Practices>(context, listen: false).fetchTrainings().then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    _isInit = false;
    super.didChangeDependencies();
  }

  Widget build(BuildContext context) { 
    return Scaffold(
      appBar: AppBar(
        title: Text('Völsungur'),
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                  child: Text('Æfingar vikunnar',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                Container(
                  height: 300,
                  child: PracticeGrid(builderCount:true),
                ),
                Divider(color: Colors.pink),
              ],
            ),
    ); //);
  }
}
