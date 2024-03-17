import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smartfarm/bdHelper/mongodb.dart';

class SavedCultivationPage extends StatefulWidget {
  final Map<String, dynamic> cultivationDetails;

  SavedCultivationPage({required this.cultivationDetails});

  @override
  _SavedCultivationPageState createState() => _SavedCultivationPageState();
}

class _SavedCultivationPageState extends State<SavedCultivationPage> {
  late double totalFertilizerNeeded = 0.0;
  late String formattedTotalFertilizerNeeded = '';
  late double totalPlantsNeeded = 0.0;
  late String formattedTotalPlantsNeeded = '';
  late DateTime nextFertilizationDate = DateTime.now();
  late String fertilizerName = '';

  @override
  void initState() {
    super.initState();
    calculateValues();
  }

  Future<void> calculateValues() async {
    String cropType = widget.cultivationDetails['cropType'];

    // Retrieve fertilizer name, amount, and date from MongoDB
    String fertilizerAmount =
        await MongoDatabase.getFertilizerAmount(cropType) ?? '0';
    String landSize = widget.cultivationDetails['landSize'];
    String plants = await MongoDatabase.getPlantsAmount(cropType) ?? '0';
    String fertilizerDate =
        await MongoDatabase.getFertilizerDate(cropType) ?? '0';
    DateTime startDate = widget.cultivationDetails['startingDate'] as DateTime;

    // Get fertilizer name
    fertilizerName =
        await MongoDatabase.getFertilizerName(cropType) ?? 'Unknown';

    // Perform calculations
    totalFertilizerNeeded =
        double.parse(fertilizerAmount) * double.parse(landSize);
    formattedTotalFertilizerNeeded = totalFertilizerNeeded.toStringAsFixed(2);
    totalPlantsNeeded = double.parse(plants) * double.parse(landSize);
    formattedTotalPlantsNeeded = totalPlantsNeeded.toStringAsFixed(0);

    nextFertilizationDate = startDate.add(
      Duration(days: int.parse(fertilizerDate)),
    );

    setState(() {}); // Update the UI after calculations
  }

  void deleteCultivationData() async {
    try {
      // Call the deleteCultivationData method without passing any arguments
      await MongoDatabase.deleteCultivationData();

      // After successful deletion, navigate back to the previous screen or perform any other action
      Navigator.pop(context);
    } catch (e) {
      // Handle any errors that occur during the deletion process
      print('Error deleting cultivation data: $e');
      // Optionally, show a snackbar or dialog to inform the user about the error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cultivation Details',
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
            fit: BoxFit.cover, // Cover the entire screen
          ),
        ),
        child: SingleChildScrollView(
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
                          buildTableRow("Land Name",
                              widget.cultivationDetails['landName'] ?? ''),
                          buildTableRow("Crop Type",
                              widget.cultivationDetails['cropType'] ?? ''),
                          buildTableRow(
                              "Land Size",
                              "${widget.cultivationDetails['landSize']} hectares" ??
                                  ''),
                          buildTableRow(
                              "Starting Date",
                              DateFormat('yyyy-MM-dd').format(widget
                                      .cultivationDetails['startingDate']) ??
                                  ''),
                          buildTableRow(
                              "Province",
                              widget.cultivationDetails['location']
                                      ['province'] ??
                                  ''),
                          buildTableRow(
                              "District",
                              widget.cultivationDetails['location']
                                      ['district'] ??
                                  ''),
                          buildTableRow(
                              "Near Town",
                              widget.cultivationDetails['location']
                                      ['nearTown'] ??
                                  ''),
                          buildTableRow(
                              "Fertilizer Name", fertilizerName ?? 'Unknown'),
                          buildTableRow("Total Fertilizer Needed",
                              "$formattedTotalFertilizerNeeded KG" ?? ''),
                          buildTableRow("Total Plants Needed",
                              formattedTotalPlantsNeeded ?? ''),
                          buildTableRow(
                              "Next Fertilization Date",
                              DateFormat('yyyy-MM-dd')
                                      .format(nextFertilizationDate) ??
                                  ''),
                        ],
                      ),
                      SizedBox(height: 20), // Add some spacing
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Delete Cultivation"),
                                    content: Text(
                                        "Are you sure you want to delete this cultivation?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("Cancel"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          deleteCultivationData();
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("Delete"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Text('Delete'),
                          ),
                        ),
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

  TableRow buildTableRow(String label, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(label, style: TextStyle(fontSize: 18)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(value, style: TextStyle(fontSize: 18)),
        ),
      ],
    );
  }
}
