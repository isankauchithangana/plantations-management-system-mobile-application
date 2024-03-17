import 'package:flutter/material.dart';
import 'package:smartfarm/bdHelper/mongodb.dart';
import 'SavedCultivationPage.dart';

class ExistingCultivationPage extends StatefulWidget {
  @override
  _ExistingCultivationPageState createState() =>
      _ExistingCultivationPageState();
}

class _ExistingCultivationPageState extends State<ExistingCultivationPage> {
  List<Map<String, dynamic>> cultivationData = [];

  @override
  void initState() {
    super.initState();
    loadCultivationData();
  }

  Future<void> loadCultivationData() async {
    List<Map<String, dynamic>> data = await MongoDatabase.getNewCultivations();
    setState(() {
      cultivationData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Existing Cultivations',
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
            image: AssetImage(
                'assets/background_image.jpg'), // Replace with your image asset
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: cultivationData.length,
                  itemBuilder: (context, index) {
                    String landName = cultivationData[index]['landName'];
                    String cropType = cultivationData[index]['cropType'];

                    // Set background color based on the index
                    Color backgroundColor = index % 2 == 0
                        ? Color.fromARGB(216, 250, 250, 248)
                        : Color.fromARGB(209, 255, 255, 255);

                    return Column(
                      children: [
                        SizedBox(height: 10), // Space between rows
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Land Name:',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(width: 5),
                                        Text(landName,
                                            style: TextStyle(fontSize: 18)),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Text(
                                          'Crop Type:',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(width: 5),
                                        Text(cropType,
                                            style: TextStyle(fontSize: 18)),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          SavedCultivationPage(
                                              cultivationDetails:
                                                  cultivationData[index]),
                                    ),
                                  );
                                },
                                child: Text('View'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
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
    home: ExistingCultivationPage(),
  ));
}
