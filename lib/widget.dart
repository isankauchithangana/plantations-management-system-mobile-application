import 'package:flutter/material.dart';
import 'cultivation_home_page.dart';
import 'news.dart';
import 'market_price_page.dart'; // Import your MarketPricePage file
import 'weather.dart'; // Import your MarketPricePage file
import 'Notice.dart';

class WidgetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SmartFarm',
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
                  // Navigate to the HomePage when pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CultivationHomePage(),
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
                    Icon(Icons.agriculture,
                        size: 60, color: Color.fromARGB(255, 25, 25, 31)),
                    Text('Cultivation',
                        style: TextStyle(fontSize: 18, color: Colors.black)),
                  ],
                ),
              ),
              // Button 2: View Existing Cultivations
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NoticePage()),
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
                    Icon(Icons.notifications,
                        size: 60, color: Color.fromARGB(255, 31, 19, 9)),
                    Text('Notices',
                        style: TextStyle(fontSize: 18, color: Colors.black)),
                  ],
                ),
              ),
              // Button 3: Weather
             
              // Button 4: News
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewsPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(180, 223, 151, 151),
                  minimumSize: Size(160, 160),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.article,
                        size: 60, color: Color.fromARGB(255, 36, 35, 35)),
                    Text('News',
                        style: TextStyle(fontSize: 18, color: Colors.black)),
                  ],
                ),
              ),
              // Button 5: Market Price
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MarketPricePage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(180, 150, 187, 136),
                  minimumSize: Size(160, 160),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.shopping_cart,
                        size: 60, color: Color.fromARGB(255, 36, 35, 35)),
                    Text('Market Price',
                        style: TextStyle(fontSize: 18, color: Colors.black)),
                  ],
                ),
              ),
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
            ],
          ),
        ),
      ),
    );
  }
}
