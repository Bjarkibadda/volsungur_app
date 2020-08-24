import 'package:flutter/material.dart';
import 'package:volsungur_app/widgets/app_bar.dart';
import 'package:volsungur_app/widgets/app_drawer.dart';
import '../screens/group_screen.dart';
import './filtered_all_practices_screen.dart';
import '../providers/profile.dart';
import 'package:provider/provider.dart';

class InitScreen extends StatefulWidget {
  static const routeName = '/init_screen';
  @override
  _InitScreenState createState() => _InitScreenState();
}



class _InitScreenState extends State<InitScreen> {
  int _selectedPage = 0;
  final List<Widget> _pages = [
    TrainingScreen(),
    AllTrainings(false),
    AllTrainings(true),
  ];

  @override
  Widget build(BuildContext context) {
     var _isCoach = false;
    _isCoach = Provider.of<UserProfile>(context).coach;
    return Scaffold(
      
      backgroundColor: Color.fromARGB(230, 46, 46, 46),
      appBar: PreferredSize(preferredSize: Size.fromHeight(60), child: CustomAppBar()),
      drawer: AppDrawer(),
      body:  _pages[_selectedPage],
      bottomNavigationBar: Container(
        height: 60,
        child: BottomNavigationBar(
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.white54,
          backgroundColor: Color.fromARGB(230, 32, 32, 32),
          currentIndex: _selectedPage,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Flokkur'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_play),
              title: Text('Æfingar'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              title: Text('Allar æfingar'),
            ),
          ],
          onTap: (int index) {
            setState(() {
              _selectedPage = index;
            });
          },
        ),
      ),
    );
  }
}
