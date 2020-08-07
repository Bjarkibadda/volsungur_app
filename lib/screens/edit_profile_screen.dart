import 'package:flutter/material.dart';
import 'package:volsungur_app/widgets/app_bar.dart';

import '../widgets/app_bar.dart';
import '../providers/profile.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60), child: CustomAppBar()),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(0, 0, 0, 1).withOpacity(0.8),
                  Color.fromRGBO(0, 150, 0, 1).withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0, 1],
              ),
            ),
          ),
          Positioned(
            left: deviceSize.width * 0.20,
            top: 30,
            child: Container(
                width: deviceSize.width * 0.6,
                height: deviceSize.height * 0.1,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.green,
                      style: BorderStyle.solid,
                      width: 4,
                    ),
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10.0)),
                child: Center(
                    child: Text(
                  'Prófillinn þinn',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                  textAlign: TextAlign.center,
                ))),
          ),
          Center(
            child: SingleChildScrollView(child: ProfileInformationForm()),
          ),
        ],
      ),
    );
  }
}

enum Gender { KK, KVK }

class ProfileInformationForm extends StatefulWidget {
  @override
  _ProfileInformationFormState createState() => _ProfileInformationFormState();
}

class _ProfileInformationFormState extends State<ProfileInformationForm> {
  final _formKey = GlobalKey<FormState>();
  Gender _genderPick = Gender.KK;
  var _isLoading = false;

  Map<String, dynamic> _userInformation = {
    'name': '',
    'gender': false,
    'age': 0,
  };

  get genderPick{
    if (_genderPick == Gender.KK){
      return true;
    }
    else{
      return false;
    }
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    await Provider.of<UserProfile>(context, listen: false).saveProfile(
      _userInformation['name'],
      _userInformation['age'],
      genderPick,
    );
    Navigator.of(context).pushReplacementNamed('/init_screen');
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.white,
      margin: EdgeInsets.all(5),
      child: Container(
        height: deviceSize.height * 0.5,
        width: deviceSize.width * 0.75,
        child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(10),
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      cursorColor: Colors.white,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Vinsamlegast skráðu nafn þitt';
                        }
                      },

                      onSaved: (value) {
                        _userInformation['name'] = value;
                      },
                      
                      decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Colors.black),
                      cursorColor: Colors.white,
                      //initialValue: 'Enter your name',
                      decoration: InputDecoration(
                        labelText: 'Aldur',
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                      ),
                      validator: (value){
                        if (value.isEmpty){
                          return 'Vinsamlegast settu inn aldur þinn';
                        }
                      },
                      onSaved: (value) {
                        _userInformation['age'] = int.parse(value); // bæta við checki
                      },
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 16),
                        // child: Text('Kyn',
                        //     style: TextStyle(
                        //         color: Colors.black,
                        //         fontWeight: FontWeight.bold)),
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 55), child: Text('KK')),
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
                  SizedBox(
                    height: 30,
                  ),
                  if (_isLoading)
                    CircularProgressIndicator()
                  else
                    RaisedButton(
                      child: Text('Uppfæra'),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      onPressed: _saveProfile,
                      textColor: Colors.white,
                      color: Colors.green,
                      hoverColor: Colors.blue,
                    )
                ],
              ),
            )),
      ),
    );
  }
}
