// skjár fyrir hvern flokk fyrir sig . Sýnir æfingar í lista sem þjálfarinn setur inn plús tilkynninga

import 'package:flutter/material.dart';
import 'package:volsungur_app/widgets/app_drawer.dart';
import '../providers/dummy_data.dart';
import 'package:provider/provider.dart';
import '../widgets/practice_grid.dart';
import '../widgets/app_bar.dart';

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
      backgroundColor: Color.fromARGB(230, 32, 32, 32),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: CustomAppBar(),
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Text('Æfingar vikunnar',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                  ),
                  Container(
                    height: 280,
                    child: PracticeGrid(builderCount: true),
                  ),
                  Divider(
                    color: Colors.green,
                    thickness: 2,
                    height: 30,
                  ),
                  Container(
                    child: Image.network(
                        "https://www.volsungur.is/static/files/aefingatoflur/2019-2020/aefingaplan-b.png"),
                  ),
                  Divider(
                    color: Colors.green,
                    thickness: 2,
                    height: 30,
                  ),
                  Container(
                    height: 50,
                    child: ListView(
                      children: <Widget>[
                        Text('Hello world'),
                        Text('Það er ekki æfing asni')
                      ],
                    ),
                  )
                ],
              ),
            ),
    ); //);
  }
}
