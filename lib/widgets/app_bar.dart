import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Hero(
              child: Image.asset(
          'assets/logo.png',
          width: 40,
          height: 40,
        ),
        tag: 'logo',
      ),
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
