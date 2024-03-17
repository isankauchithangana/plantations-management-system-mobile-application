import 'package:flutter/material.dart';
import 'existing_cultivation.dart';
import 'package:smartfarm/bdHelper/mongodb.dart';

class SummaryPage extends StatelessWidget {
  final String cropType;
  final String landName;
  final String landSize;
  final String fertilizerName;
  final String fertilizerAmount;
  final String plants;
  final DateTime startDate;
  final String fertilizerDate;

  SummaryPage({
    required this.cropType,
    required this.landName,
    required this.landSize,
    required this.fertilizerName,
    required this.fertilizerAmount,
    required this.plants,
    required this.fertilizerDate,
    required this.startDate,
  });

  @override
  Widget build(BuildContext context) {
    double totalFertilizerNeeded =
        double.parse(fertilizerAmount) * double.parse(landSize);
    String formattedTotalFertilizerNeeded =
        totalFertilizerNeeded.toStringAsFixed(2);
    double totalPlantsNeeded = double.parse(plants) * double.parse(landSize);
    String formattedTotalPlantsNeeded = totalPlantsNeeded.toStringAsFixed(0);

    DateTime nextFertilizationDate = startDate.add(
      Duration(days: int.parse(fertilizerDate)),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Start Cultivation',
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
              'assets/logo2.png',
              width: 100,
              height: 100,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background_image.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: [
                          buildTableRow("Crop Type", cropType, 0),
                          buildTableRow("Land Name", landName, 1),
                          buildTableRow("Land Size (hect)", landSize, 2),
                          buildTableRow("Fertilizer", fertilizerName, 3),
                          buildTableRow(
                              "Fertilizer Amount for 1 hectare (Kg)",
                              fertilizerAmount,
                              4),
                          buildTableRow("Total Fertilizer Needed (Kg)",
                              formattedTotalFertilizerNeeded, 5),
                          buildTableRow("Plants for 1 hectare", plants, 6),
                          buildTableRow("Total Plants Needed",
                              formattedTotalPlantsNeeded, 7),
                          buildTableRow("Started Date", startDate.toString(), 8),
                          buildTableRow("Next Fertilization Date",
                              nextFertilizationDate.toString(), 9),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              // Save data to the database
                              await MongoDatabase.insertCultivationData(
                                cropType,
                                landSize,
                                plants,
                                'wet', // Add actual value for wet
                                fertilizerName,
                                fertilizerAmount,
                                fertilizerDate,
                                'temperature', // Add actual value for temperature
                              );

                              // Navigate to the existing cultivation page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ExistingCultivationPage(),
                                ),
                              );
                            },
                            child: Text("Save"),
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 67, 235, 90),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              // Delete data from the database
                              await MongoDatabase.deleteCultivationData();

                              // Navigate back to the previous screen
                              Navigator.pop(context);
                            },
                            child: Text("Cancel"),
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 201, 199, 199),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TableRow buildTableRow(String label, String value, int index) {
    Color backgroundColor = index % 2 == 0
        ? Color.fromARGB(139, 233, 225, 153)
        : Color.fromARGB(157, 131, 230, 106);

    return TableRow(
      decoration: BoxDecoration(
        color: backgroundColor,
      ),
      children: [
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(label, style: TextStyle(fontSize: 18)),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(9.0),
            child: Text(value, style: TextStyle(fontSize: 18)),
          ),
        ),
      ],
    );
  }
}
