import 'package:flutter/material.dart';
import '../providers/practices_list.dart';
import 'package:provider/provider.dart';
import '../providers/practice_model.dart';

class AddPractice extends StatefulWidget {
  static const routeName = '/add_training_screen';
  @override
  _AddPracticeState createState() => _AddPracticeState();
}

enum Gender { KK, KVK }

class _AddPracticeState extends State<AddPractice> {
  final _formKey = GlobalKey<FormState>();
  Gender _genderPick = Gender.KK;
  String title ;
  Map<String, dynamic> _practiceInfo = {
    'name': '',
    'gender': false,
    'flokkur': 0,
    'url': '',
    'id' :'',
    'information': '',
  };

  get genderPick{
    if (_genderPick == Gender.KK){
      return true;
    }
    else{
      return false;
    }
  }


  Future<void> _addPractice() async {
    if(!_formKey.currentState.validate()){
      return;
    }
    _formKey.currentState.save();


    await Provider.of<Practices>(context, listen: false).addPractice(Practice(
        name: _practiceInfo['name'],
        id: '',
        flokkur: _practiceInfo['flokkur'],
        gender: genderPick,
        url: _practiceInfo['url'],
        information: _practiceInfo['information']));
    Navigator.of(context).pushReplacementNamed('/init_screen');
  }

  @override
  Widget build(BuildContext context) {
    
    final _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(230, 32, 32, 32),
      appBar: AppBar(),
      body: Form(
        key:_formKey,
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
                  Text('Upplýsingar um æfingu',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20, fontStyle: FontStyle.italic)),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: _screenSize.width * 0.70,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Titill á æfingu'),
                        validator:(value){
                          if(value.isEmpty){
                            return 'Vantar titil';
                          }
                        },
                        onSaved: (value){
                          _practiceInfo['name'] = value;
                        },
                          //style: TextStyle(color: Colors.white),
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Youtube link'),
                        validator:(value){
                          if(value.isEmpty){
                            return 'Vantar link';
                          }
                          else if(!value.contains('youtube')){
                            return 'Vinsamlegast settu inn Youtube link';
                          }
                        },
                        onSaved: (value){
                          if (!value.startsWith('https://')){
                            _practiceInfo['url'] = 'https://$value';
                          }
                          else{
                            _practiceInfo['url'] = value; // skoða betur
                          }
                        },
                          //style: TextStyle(color: Colors.white),
                        ),
                            TextFormField(
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                          decoration: InputDecoration(labelText: 'Upplýsingar um æfingu'),
                        onSaved: (value){
                          _practiceInfo['information'] = value;
                        },
                          //style: TextStyle(color: Colors.white),
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Flokkur'),
                        validator:(value){
                          if(value.isEmpty){
                            return 'Vantar flokk';
                          }
                          try{
                            int.parse(value);
                            return null;
                          } catch(FormatException){
                            return 'Flokkur má einungis innihalda tölu';
                          }
              

                        },
                        onSaved: (value){
                          _practiceInfo['flokkur'] = int.parse(value);
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
                      ],
                    ),
                  ),
                  RaisedButton(child:Text('Bæta við æfingu'), onPressed: _addPractice,),
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
