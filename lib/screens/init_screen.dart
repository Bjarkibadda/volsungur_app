import 'package:flutter/material.dart';
import '../screens/training_screen.dart';
import './all_practices_screen.dart';
import './home_screen.dart';

class InitScreen extends StatefulWidget {
  @override
  _InitScreenState createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  int _selectedPage = 0;
  final List<Widget> _pages = [
    HomeScreen(),
    TrainingScreen(),
    AllTrainings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPage],
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
              title: Text('Forsíða'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_play),
              title: Text('Flokkur'),
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
