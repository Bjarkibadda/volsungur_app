import 'package:flutter/material.dart';
import './practice_model.dart';
import 'package:flutter/foundation.dart';

class Practices with ChangeNotifier {
  List<Practice> _fixedTrainings = [
    Practice(
        id: DateTime.now().toString(),
        name: 'training1',
        url:
            "https://www.youtube.com/watch?v=bdneye4pzMw&list=RDbdneye4pzMw&start_radio=1",
        isRequired: false),
    Practice(
        id: DateTime.now().toString(),
        name: 'training2',
        url:
            "https://www.youtube.com/watch?v=OPf0YbXqDm0&list=RDbdneye4pzMw&index=2",
        isRequired: false,),
  ];

  List<Practice> get items {
    return [..._fixedTrainings];
  }
}
