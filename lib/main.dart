import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volsungur_app/providers/practice_model.dart';
import './screens/home_screen.dart';
import './screens/training_screen.dart';
import 'package:provider/provider.dart';
import './providers/practice_model.dart';
import './providers/dummy_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Practices(),
      child: MaterialApp(
        title: 'Æfingaforrit Völsungs',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.green,
          accentColor: Colors.black,
        ),
        home: TrainingScreen(),
        routes: {
          TrainingScreen.routeName: (ctx) => TrainingScreen(),
          HomeScreen.routeName: (ctx) => HomeScreen(),
        },
      ),
    );
  }
}
