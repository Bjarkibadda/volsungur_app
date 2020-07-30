import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volsungur_app/providers/practice_model.dart';
import 'package:volsungur_app/screens/auth_screen.dart';
import 'package:volsungur_app/screens/video_screen.dart';
import 'package:volsungur_app/widgets/training_week.dart';
import './screens/home_screen.dart';
import './screens/training_screen.dart';
import 'package:provider/provider.dart';
import './providers/practice_model.dart';
import './providers/dummy_data.dart';
import './screens/init_screen.dart';
import './providers/notifications.dart' as notice;
import './widgets/week_item.dart';
import './providers/training_date_list.dart';
import './providers/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, Practices>(
              create: (_) => null,
              update: (ctx, auth, previousPractices) => Practices(
                    auth.token,
                    auth.userId,
                    previousPractices == null ? [] : previousPractices.allItems,
                  )),
          ChangeNotifierProxyProvider<Auth, notice.Notifications>(
            create: (_) => null,
            update: (ctx, auth, previousNotifications) => notice.Notifications(
              auth.token,
              previousNotifications == null
                  ? []
                  : previousNotifications.allItems,
            ),
          ),
          ChangeNotifierProxyProvider<Auth, TrainingList>(
            create: (_) => null,
            update: (ctx, auth, previousTrainings) => TrainingList(
              auth.token,
              previousTrainings == null ? [] : previousTrainings.allItems,
            ),
          ),
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
            title: 'Æfingaforrit Völsungs',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: Colors.green,
              accentColor: Colors.black,
            ),
            home: auth.isAuth ? InitScreen() : AuthScreen(), //InitScreen(),
            routes: {
              TrainingScreen.routeName: (ctx) => TrainingScreen(),
              HomeScreen.routeName: (ctx) => HomeScreen(),
              VideoScreen.routeName: (ctx) => VideoScreen(),
            },
          ),
        ));
  }
}
