import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/notification_model.dart' as notif;
import '../providers/notifications.dart';

class AddNotification extends StatefulWidget {
  static const routeName = '/add_notitification_screen';
  @override
  _AddNotification createState() => _AddNotification();
}

enum Gender { KK, KVK }

class _AddNotification extends State<AddNotification> {
  final _formKey = GlobalKey<FormState>();
  Gender _genderPick = Gender.KK;
  String title;
  Map<String, dynamic> _notificationInfo = {
    'title': '',
    'subject': '',
    'gender': false,
    'grp': 0,
  };

  get genderPick {
    if (_genderPick == Gender.KK) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> _addNotitifcation() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    await Provider.of<Notifications>(context, listen: false).addNotification(
        notif.Notification(
            title: _notificationInfo['title'],
            id: '',
            grp: _notificationInfo['grp'],
            gender: genderPick,
            subject: _notificationInfo['subject']));
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
                  Text('Ný tilkynning',
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
                          decoration:
                              InputDecoration(labelText: 'Titill  tilkynningu'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Vantar titil';
                            }
                          },
                          onSaved: (value) {
                            _notificationInfo['title'] = value;
                          },
                          //style: TextStyle(color: Colors.white),
                        ),
                        Container(
                          height: 60,
                          child: TextField(
                            decoration:
                                InputDecoration(labelText: 'Nánari upplýsingar'),
                            onSubmitted: (value) {
                              _notificationInfo['subject'] = value;
                            },
                            //style: TextStyle(color: Colors.white),
                          ),
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
                            _notificationInfo['grp'] = int.parse(value);
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
                    onPressed: _addNotitifcation,
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
