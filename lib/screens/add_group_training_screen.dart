import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/notification_model.dart' as notif;
import '../providers/training_date_list.dart';
import '../providers/training_date_model.dart';
import 'package:intl/intl.dart';

class AddGroupTraining extends StatefulWidget {
  static const routeName = '/add_group_training_screen';
  @override
  _AddGroupTraining createState() => _AddGroupTraining();
}

enum Gender { KK, KVK }

class _AddGroupTraining extends State<AddGroupTraining> {
  final _formKey = GlobalKey<FormState>();
  Gender _genderPick = Gender.KK;
  String title;
  Map<String, dynamic> _groupTrainingInfo = {
    'title': '',
    'subject': '',
    'gender': false,
    'grp': 0,
  };

  DateTime _pickedDate = DateTime.now();

  get genderPick {
    if (_genderPick == Gender.KK) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> _addGroupTraining() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    await Provider.of<TrainingList>(context, listen: false).addGroupTraining(
      Training(
          location: _groupTrainingInfo['location'],
          id: '',
          grp: _groupTrainingInfo['grp'],
          gender: genderPick,
          time: _groupTrainingInfo['time'],
          date: _pickedDate),
    );
    Navigator.of(context).pushReplacementNamed('/init_screen');
  }

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(230, 32, 32, 32),
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Center(
          child: Container(
            color: Colors.white,
            //height: _screenSize.height * 0.8,
            width: _screenSize.width * 0.8,
            height: _screenSize.height * 0.6,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 15),
                  Text('Ný (staðbundin) æfing',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontStyle: FontStyle.italic)),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: _screenSize.width * 0.70,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Staðsetning'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Vantar staðsetningu';
                            }
                          },
                          onSaved: (value) {
                            _groupTrainingInfo['location'] = value;
                          },
                          //style: TextStyle(color: Colors.white),
                        ),
                        Container(
                          height: 60,
                          child: TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Tímasetning'),
                            onSaved: (value) {
                              _groupTrainingInfo['time'] = value;
                            },
                            //style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Row(
                          children: <Widget>[
                            Text(DateFormat('dd-MM-yyy')
                                .format(_pickedDate)
                                .toString()),
                                SizedBox(width:30),
                            RaisedButton(
                              color: Colors.green,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              child: Text('Veldu dagsetningu'),
                              onPressed: () {
                                showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2020),
                                        lastDate: DateTime(2025))
                                    .then((date) {
                                  setState(() {
                                    _pickedDate = date;
                                  });
                                });
                              },
                            ),
                          ],
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Flokkur'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Vantar flokk';
                            }
                            try {
                              int.parse(value);
                              return null;
                            } catch (FormatException) {
                              return 'Flokkur má einungis innihalda tölu';
                            }
                          },
                          onSaved: (value) {
                            _groupTrainingInfo['grp'] = int.parse(value);
                          },
                          keyboardType: TextInputType.number,
                          //style: TextStyle(color: Colors.white),
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 16),
                            ),
                            Container(
                                margin: EdgeInsets.only(left: 55),
                                child: Text('KK')),
                            Center(
                              child: ButtonBar(
                                  alignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Radio(
                                      activeColor: Colors.green,
                                      value: Gender.KK,
                                      groupValue: _genderPick,
                                      onChanged: (Gender pick) {
                                        setState(() {
                                          _genderPick = pick;
                                        });
                                      },
                                    ),
                                    Radio(
                                      activeColor: Colors.green,
                                      value: Gender.KVK,
                                      groupValue: _genderPick,
                                      onChanged: (Gender pick) {
                                        setState(() {
                                          _genderPick = pick;
                                        });
                                      },
                                    ),
                                    Text('Kvk')
                                  ]),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  RaisedButton(
                    child: Text('Bæta við tilkynningu'),
                    onPressed: _addGroupTraining,
                  ),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
