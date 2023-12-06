// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'loading_page.dart'; // Import the Loading Page
// import 'weather_info_page.dart'; // Import the Weather Info page
import 'cultivation_page.dart'; // Import the Weather Info page
import 'home_page.dart';
import 'login_page.dart';
import 'package:flutter_blue/flutter_blue.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterBlue flutterBlue = FlutterBlue.instance;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/loading', // Set the initial route to 'loading'
      routes: {
        '/loading': (context) => const LoadingPage(),
        '/home': (context) => const MyHomePage(title: 'SmartFarm'),
        '/login': (context) => LoginPage(),
      },

      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 12, 138, 1)),
        useMaterial3: true,
      ),
      home: const LoadingPage(), // Set the Loading Page as the initial page
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Stack(
        children: <Widget>[
          // Background Photo
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/background_image.jpg'), // Add your image asset path here
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: GridView.count(
              crossAxisCount: 2, // Display buttons in two columns
              mainAxisSpacing: 16.0, // Add vertical spacing between buttons
              crossAxisSpacing: 16.0, // Add horizontal spacing between buttons
              padding: EdgeInsets.all(16.0), // Adjust padding as needed
              children: <Widget>[
                // Button 1: Start a New Cultivation
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the New Cultivation page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CultivationPage()),
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
                      Icon(Icons.agriculture, // Change icon here
                          size: 60,
                          color: Color.fromARGB(255, 3, 1, 99)),
                      Text('Cultivation', // Change text here
                          style: TextStyle(fontSize: 18, color: Colors.black)),
                    ],
                  ),
                ),
                // Button 2: Get Weather Info
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the Weather Info page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(180, 144, 240, 149),
                    minimumSize: Size(160, 160),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.cloud,
                          size: 60, color: Color.fromARGB(255, 1, 94, 16)),
                      Text('Weather Info',
                          style: TextStyle(fontSize: 18, color: Colors.black)),
                    ],
                  ),
                ),
                // Button 3: View Existing Cultivations
                ElevatedButton(
                  onPressed: () {
                    // Add functionality for viewing existing cultivations
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(
                        180, 236, 210, 137), // Adjust button color
                    minimumSize: Size(160, 160), // Adjust button size
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.list,
                          size: 60, color: Color.fromARGB(255, 102, 46, 1)),
                      Text('News', // Change text here
                          style: TextStyle(fontSize: 18, color: Colors.black)),
                    ],
                  ),
                ),
                // Button 4: Notifications
                ElevatedButton(
                  onPressed: () {
                    // Add functionality for accessing notifications
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(
                        180, 247, 160, 131), // Adjust button color
                    minimumSize: Size(160, 160), // Adjust button size
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.notifications,
                          size: 60, color: Color.fromARGB(255, 143, 28, 28)),
                      Text('Notifications',
                          style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 8, 8, 8))),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
