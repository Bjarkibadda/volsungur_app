import 'package:flutter/material.dart';
import 'package:volsungur_app/widgets/practice_grid.dart';

class AllTrainings extends StatefulWidget {
  @override
  _AllTrainingsState createState() => _AllTrainingsState();
}

class _AllTrainingsState extends State<AllTrainings> {
  final List<bool> _isSelected = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Völsungur')),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 12,
            ),
            ToggleButtons(
              color: Colors.black,
              selectedColor: Colors.pink,
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
                Icon(Icons.radio_button_unchecked),
                Icon(Icons.done),
                Icon(Icons.favorite),
                Icon(Icons.favorite_border),
              ],
            ),
            Expanded(
                child: PracticeGrid(builderCount: false, filters: _isSelected)),
          ],
        ));
  }
}
