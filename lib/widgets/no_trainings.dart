import 'package:flutter/material.dart';

class NoTrainings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     ImageProvider noTrainingImg = AssetImage('assets/relax.jpg');
    return Expanded(
      child: Card(
        color: Colors.black,
        child: Column(
          children: [
            ListTile(
              title: Text('Frí!',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white)),
              subtitle: Text('Engin æfing fyrirhuguð næstu vikuna.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green)),
            ),
            Container(
                height: 230,
                child: Image.asset('assets/relax.jpg', fit: BoxFit.contain)),
            SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}
