// skjár fyrir hvern flokk fyrir sig . Sýnir æfingar í lista sem þjálfarinn setur inn plús tilkynninga

import 'package:flutter/material.dart';
import 'package:volsungur_app/providers/profile.dart';
import 'package:volsungur_app/widgets/no_notification.dart';
import 'package:volsungur_app/widgets/notification_list.dart';
import '../providers/practices_list.dart';
import '../providers/training_date_list.dart';
import 'package:provider/provider.dart';
import '../widgets/practice_grid.dart';
import '../widgets/training_week.dart';
import '../providers/notifications.dart';
import '../widgets/no_trainings.dart';

class TrainingScreen extends StatefulWidget {
  static const routeName = '/group_screen';

  @override
  _TrainingScreenState createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  var _isInit = true;
  var _isPracticeLoading = true;
  var _isTrainingDateLoading = true;
  var _isNotificationsLoading = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      if (mounted) {
        setState(() {
          _isPracticeLoading = true;
          _isTrainingDateLoading = true;
        });
      }
    }

    Provider.of<Practices>(context, listen: false).fetchTrainings().then((_) {
      if (mounted) {
        setState(() {
          _isPracticeLoading = false;
        });
      }
    });

    Provider.of<TrainingList>(context, listen: false)
        .fetchTrainings()
        .then((_) {
      if (mounted) {
        setState(() {
          _isTrainingDateLoading = false;
        });
      }
    });

    _isInit = false;

    Provider.of<UserProfile>(context, listen: false).fetchUser();
    Provider.of<Notifications>(context, listen: false)
        .fetchNotifications()
        .then((_) {
      if (mounted) {
        setState(() {
          _isNotificationsLoading = false;
        });
      }
    });

    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    precacheImage(AssetImage('assets/relax.jpg'), context);
    int userGrp = Provider.of<UserProfile>(context, listen: false).flokkur;
    bool userGender = Provider.of<UserProfile>(context, listen: false).gender;
    bool isVacation =
        Provider.of<TrainingList>(context, listen: false).isTraining;
    return _isPracticeLoading ||
            _isTrainingDateLoading ||
            _isNotificationsLoading
        ? Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            ),
          )
        : SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromRGBO(0, 0, 0, 1).withOpacity(0.5),
                  Color.fromRGBO(0, 150, 0, 1).withOpacity(0.9),
                ],
              )),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Text('Heimaæfingar',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Alata')),
                  ),
                  Container(
                    height: 280,
                    child: PracticeGrid(
                        builderCount: true, grp: userGrp, gender: userGender),
                  ),
                  Divider(
                    color: Colors.green,
                    thickness: 0.5,
                    height: 30,
                  ),
                  Container(
                    height: isVacation ? 400 : 200,
                    child: Column(
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(bottom: 10),
                            height: 30,
                            child: Text('Næstu æfingar',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold))),
                        Container(
                          child: isVacation ? NoTrainings() : TrainingWeek(),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.green,
                    thickness: 0.5,
                    height: 30,
                  ),
                  Container(
                      height: 26,
                      margin: EdgeInsets.only(bottom: 10),
                      child: Text('Tilkynningar',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold))),
                  Container(
                    //height: 200,
                    child:
                        NotificationList(), // skoða hvort ég þurfi ekki eitthvað að villuprófa - await  og eitthvað.
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ); //);
  }
}
