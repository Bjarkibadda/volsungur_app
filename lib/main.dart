import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:volsungur_app/screens/add_group_training_screen.dart';
import 'package:volsungur_app/screens/add_notification_screen.dart';

import 'package:volsungur_app/screens/auth_screen.dart';
import 'package:volsungur_app/screens/edit_profile_screen.dart';
import 'package:volsungur_app/screens/video_screen.dart';

import './screens/group_screen.dart';

import './providers/practices_list.dart';
import './screens/init_screen.dart';
import './providers/notifications.dart' as notice;

import './providers/training_date_list.dart';
import './providers/auth.dart';

import './providers/profile.dart';

import './screens/waiting_screen.dart';

import './screens/add_practice_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, UserProfile>(
            create: (_) => null,
            update: (ctx, auth, previousPractices) =>
                UserProfile(auth.token, auth.userId),
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
              canvasColor: Colors.black,
              fontFamily: 'Alata'
            ),
            home: auth.isSigningUp
                ? EditProfileScreen()
                : auth.isAuth
                    ? InitScreen()
                    : FutureBuilder(
                        future: auth.autoLogin(),
                        builder: (ctx, authResult) => authResult
                                    .connectionState ==
                                ConnectionState.waiting
                            ? WaitingScreen()
                            : AuthScreen()), //AuthScreen(),  //InitScreen(),
            routes: {
              TrainingScreen.routeName: (ctx) => TrainingScreen(),
              VideoScreen.routeName: (ctx) => VideoScreen(),
              InitScreen.routeName: (ctx) => InitScreen(),
              AuthScreen.routeName: (ctx) => AuthScreen(),
              AddPractice.routeName: (ctx) => AddPractice(),
              AddNotification.routeName: (ctx) => AddNotification(),
              AddGroupTraining.routeName: (ctx) => AddGroupTraining(),
            },
          ),
        ));
  }
}
