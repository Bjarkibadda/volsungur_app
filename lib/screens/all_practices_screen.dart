import 'package:flutter/material.dart';
import 'package:volsungur_app/providers/profile.dart';
import 'package:volsungur_app/widgets/practice_grid.dart';
import '../widgets/app_bar.dart';
import 'package:provider/provider.dart';

class AllTrainings extends StatefulWidget {
  @override
  _AllTrainingsState createState() => _AllTrainingsState();
}

class _AllTrainingsState extends State<AllTrainings> {
  final List<bool> _isSelected = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    final int userGrp = Provider.of<UserProfile>(context).flokkur;
    final bool userGender = Provider.of<UserProfile>(context).gender;
    return Scaffold(
        backgroundColor: Color.fromARGB(230, 32, 32, 32),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: CustomAppBar(),
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 12,
            ),
            ToggleButtons(
              borderColor: Colors.white,
              selectedBorderColor: Colors.white,
              fillColor: Colors.black38,
              highlightColor: Colors.green,
              color: Colors.yellow,
              isSelected: _isSelected,
              onPressed: (int index) {
                setState(() {
                  _isSelected[index] = !_isSelected[index];

                  if (_isSelected[2] && index == 2) {
                    _isSelected[3] = false;
                  }

                  if (_isSelected[3] && index == 3) {
                    _isSelected[2] = false;
                  }

                  if (_isSelected[0] && index == 0) {
                    _isSelected[1] = false;
                  }

                  if (_isSelected[1] && index == 1) {
                    _isSelected[0] = false;
                  }
                });
              },
              children: <Widget>[
                _isSelected[0]
                    ? Icon(Icons.radio_button_unchecked, color: Colors.green)
                    : Icon(Icons.radio_button_unchecked, color: Colors.white),
                _isSelected[1]
                    ? Icon(Icons.done, color: Colors.green)
                    : Icon(Icons.done, color: Colors.white),
                _isSelected[2]
                    ? Icon(Icons.favorite, color: Colors.green)
                    : Icon(Icons.favorite, color: Colors.white),
                _isSelected[3]
                    ? Icon(Icons.favorite_border, color: Colors.green)
                    : Icon(Icons.favorite_border, color: Colors.white),
              ],
            ),
            Expanded(
                child: PracticeGrid(builderCount: false, gender: userGender, grp: userGrp ,filters: _isSelected)),
          ],
        ));
  }
}
