import 'package:flutter/material.dart';

class NoNotification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _screen = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(0),
      width: _screen.width * 0.8,
      height: 300,
      child: Image.asset('assets/relax.jpg', fit: BoxFit.fill),
    );
  }
}
