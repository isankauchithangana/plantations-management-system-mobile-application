import 'package:flutter/material.dart';

class EnteringPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue, // Set your background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
                'assets/logo.png'), // Replace 'your_logo.png' with your logo's asset path
            SizedBox(height: 20),
            Text(
              'Your App Name',
              style: TextStyle(
                color: Colors.white, // Set your text color
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
