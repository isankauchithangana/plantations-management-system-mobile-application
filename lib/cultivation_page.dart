// cultivation_page.dart

import 'package:flutter/material.dart';
import 'widget.dart';

class CultivationPage extends StatelessWidget {
  final String userName;

  // Constructor to receive the user's name
  CultivationPage({required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ('Welcome, $userName'), // Display user's name in the app bar
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 5, 5, 5),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/logo2.png', // Replace with the path to your logo asset
              width: 100, // Adjust the size as needed
              height: 100, // Adjust the size as needed
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background_image.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
            padding: EdgeInsets.all(16.0),
            children: <Widget>[
              // Button 1: Start a New Cultivation
              ElevatedButton(
                onPressed: () {
                  // Navigate to the NewCultivationPage when pressed
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(180, 250, 251, 252),
                  minimumSize: Size(160, 160),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.link,
                        size: 60, color: Color.fromARGB(255, 4, 8, 243)),
                    Text('Connect With Sensors',
                        style: TextStyle(fontSize: 18, color: Colors.black)),
                  ],
                ),
              ),
              // Button 2: View Existing Cultivations
              ElevatedButton(
                onPressed: () {
                  // Navigate to the NewCultivationPage when pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WidgetPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(180, 236, 210, 137),
                  minimumSize: Size(160, 160),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.link_off,
                        size: 60, color: Color.fromARGB(255, 102, 46, 1)),
                    Text('Connect Without Sensors',
                        style: TextStyle(fontSize: 18, color: Colors.black)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
