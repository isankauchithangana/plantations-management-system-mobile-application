import 'package:flutter/material.dart';

class CultivationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cultivation'),
        backgroundColor: Color(0xFF4CAF50),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/background_image.jpg'), // Add your image asset path here
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
                  // Navigate to the New Cultivation page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CultivationPage(),
                    ),
                  );
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
                    Icon(Icons.add, // Change icon here
                        size: 60,
                        color: Color.fromARGB(255, 4, 8, 243)),
                    Text('New Cultivation', // Change text here
                        style: TextStyle(fontSize: 18, color: Colors.black)),
                  ],
                ),
              ),
              // Button 2: View Existing Cultivations
              ElevatedButton(
                onPressed: () {
                  // Navigate to the Existing Cultivations page
                  // Replace 'ExistingCultivationsPage()' with the actual page
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => ExistingCultivationsPage(),
                  //   ),
                  // );
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
                    Icon(Icons.history,
                        size: 60, color: Color.fromARGB(255, 102, 46, 1)),
                    Text('Existing Cultivations',
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
