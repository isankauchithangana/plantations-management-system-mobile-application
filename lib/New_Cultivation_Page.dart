// NewCultivationPage.dart

import 'package:flutter/material.dart';
import 'package:smartfarm/bdHelper/mongodb.dart';
import 'SummaryPage.dart';

class NewCultivationPage extends StatefulWidget {
  @override
  _NewCultivationPageState createState() => _NewCultivationPageState();
}

class _NewCultivationPageState extends State<NewCultivationPage> {
  final TextEditingController landNameController = TextEditingController();
  final TextEditingController landSizeController = TextEditingController();

  List<String> cropTypes = [];
  String selectedCropType = '';
  DateTime? selectedDate;

  final TextEditingController provinceController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController nearTownController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCropTypes();
  }

  void _loadCropTypes() async {
    List<String> fetchedCropTypes = await MongoDatabase.getCropTypes();

    setState(() {
      cropTypes.clear();
      cropTypes.addAll(fetchedCropTypes);
      selectedCropType = cropTypes.isNotEmpty ? cropTypes.first : '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Cultivation',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: selectedCropType,
                items: cropTypes.map((crop) {
                  return DropdownMenuItem(
                    value: crop,
                    child: Text(crop),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCropType = value!;
                  });
                },
                decoration: InputDecoration(labelText: 'Crop Type'),
                validator: (value) {
                  if (cropTypes.contains(value)) {
                    return null;
                  } else {
                    return 'Please select a valid crop type';
                  }
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: landNameController,
                decoration: InputDecoration(labelText: 'Land Name'),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: landSizeController,
                decoration: InputDecoration(labelText: 'Land Size (hect)'),
              ),
              SizedBox(height: 16),
              ListTile(
                title: Text(
                  selectedDate == null
                      ? 'Select Starting Date'
                      : 'Starting Date: ${selectedDate!.toLocal()}',
                ),
                trailing: Icon(Icons.calendar_today),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null && pickedDate != selectedDate) {
                    setState(() {
                      selectedDate = pickedDate;
                    });
                  }
                },
              ),
              SizedBox(height: 16),
              Text(
                'Location',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: provinceController,
                decoration: InputDecoration(labelText: 'Province'),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: districtController,
                decoration: InputDecoration(labelText: 'District'),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: nearTownController,
                decoration: InputDecoration(labelText: 'Near Town'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _startCultivation();
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 67, 235, 90),
                ),
                child: Text('Start Cultivation'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _startCultivation() async {
    String cropType = selectedCropType;
    String landName = landNameController.text;
    String landSize = landSizeController.text;
    DateTime? startingDate = selectedDate;
    String province = provinceController.text;
    String district = districtController.text;
    String nearTown = nearTownController.text;

    await MongoDatabase.insertNewCultivationData(
      cropType,
      landName,
      landSize,
      startingDate!,
      province,
      district,
      nearTown,
    );

    String? fertilizerName = await MongoDatabase.getFertilizerName(cropType);
    String? fertilizerAmount =
        await MongoDatabase.getFertilizerAmount(cropType);
    String? plants = await MongoDatabase.getPlantsAmount(cropType);
    String? fertilizerDate = await MongoDatabase.getFertilizerDate(cropType);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SummaryPage(
          cropType: cropType,
          landName: landName,
          landSize: landSize,
          fertilizerName: fertilizerName ?? 'Unknown Fertilizer',
          fertilizerAmount: fertilizerAmount ?? 'Unknown Fertilizer Amount',
          plants: plants ?? 'Unknown Plant Amount',
          fertilizerDate: fertilizerDate ?? 'Unknown Fertilizer Amount',
          startDate: startingDate, // Add your logic to get watering dates
        ),
      ),
    );
  }
}
