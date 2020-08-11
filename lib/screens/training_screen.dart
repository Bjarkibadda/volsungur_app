// skjár fyrir hvern flokk fyrir sig . Sýnir æfingar í lista sem þjálfarinn setur inn plús tilkynninga

import 'package:flutter/material.dart';
import 'package:volsungur_app/providers/profile.dart';
import 'package:volsungur_app/screens/notification_list.dart';
import 'package:volsungur_app/widgets/app_drawer.dart';
import '../providers/dummy_data.dart';
import '../providers/training_date_list.dart';
import 'package:provider/provider.dart';
import '../widgets/practice_grid.dart';
import '../widgets/app_bar.dart';
import '../widgets/training_week.dart';
import '../providers/notifications.dart';

class TrainingScreen extends StatefulWidget {
  static const routeName = '/training_screen';

  @override
  _TrainingScreenState createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  var _isInit = true;
  var _isPracticeLoading = true;
  var _isTrainingDateLoading = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isPracticeLoading = true;
        _isTrainingDateLoading = true;
      });
    }
    Provider.of<Practices>(context, listen: false).fetchTrainings().then((_) {
      setState(() {
        _isPracticeLoading = false;
      });
    });
    Provider.of<TrainingList>(context, listen: false)
        .fetchTrainings()
        .then((_) {
      setState(() {
        _isTrainingDateLoading = false;
      });
    });
    _isInit = false;
    Provider.of<UserProfile>(context, listen:false).fetchUser();
    Provider.of<Notifications>(context, listen:false).fetchNotifications(); //mögulega bæta við then til að það sé pottþétt búið að loada þessu
  
    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    int userGrp =  Provider.of<UserProfile>(context, listen:false).flokkur;
    bool userGender = Provider.of<UserProfile>(context, listen:false).gender;
    return Scaffold(
        backgroundColor: Color.fromARGB(230, 32, 32, 32),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: CustomAppBar(),
        ),
        drawer: AppDrawer(),
        body: _isPracticeLoading || _isTrainingDateLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Text('Heimaæfingar',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          )),
                    ),
                    Container(
                      height: 280,
                      child: PracticeGrid(builderCount: true, grp: userGrp, gender: userGender),
                    ),
                    Divider(
                      color: Colors.green,
                      thickness: 2,
                      height: 30,
                    ),
                    Container(
                      height: 190,
                      child: Column(
                        children: <Widget>[
                          Container(
                              height: 20,
                              child: Text('Næstu æfingar',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold))),
                          Container(height: 170, child: TrainingWeek()),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.green,
                      thickness: 2,
                      height: 30,
                    ),
                    Container(
                      height: 200,
                      child:
                          NotificationList(), // skoða hvort ég þurfi ekki eitthvað að villuprófa - await  og eitthvað.
                    ),
                  ],
                ),
              )); //);
  }
}
