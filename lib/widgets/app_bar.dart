import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Völsungur'),
      backgroundColor: Color.fromARGB(230, 32, 32, 32),
      elevation: 10,
      bottom: PreferredSize(
        child: Container(
          color: Colors.green,
          height: 2.0,
        ),
        preferredSize: Size.fromHeight(4.0),
      ),
    );
  }
}
