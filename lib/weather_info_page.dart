import 'package:flutter/material.dart';

class WeatherInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Info'),
      ),
      body: Center(
        child: Text('This is the Weather Info page'),
      ),
    );
  }
}
