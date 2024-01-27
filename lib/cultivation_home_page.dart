import 'package:flutter/material.dart';
import 'New_Cultivation_Page.dart';
import 'existing_cultivation.dart';

class CultivationHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cultivations',
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
        ], // Remove app bar shadow
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
                  // Navigate to the New Cultivation page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewCultivationPage(),
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
                    Icon(
                      Icons.add,
                      size: 60,
                      color: Color.fromARGB(255, 4, 8, 243),
                    ),
                    Text(
                      'New Cultivation',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ],
                ),
              ),
              // Button 2: View Existing Cultivations
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExistingCultivationPage(),
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
                    Icon(
                      Icons.history,
                      size: 60,
                      color: Color.fromARGB(255, 102, 46, 1),
                    ),
                    Text(
                      'Existing Cultivations',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
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

void main() {
  runApp(MaterialApp(
    home: CultivationHomePage(),
  ));
}
