import 'package:flutter/material.dart';
import 'package:smartfarm/bdHelper/mongodb.dart';

class MarketPricePage extends StatefulWidget {
  @override
  _MarketPricePageState createState() => _MarketPricePageState();
}

class _MarketPricePageState extends State<MarketPricePage> {
  List<Map<String, dynamic>> marketPrices = [];

  @override
  void initState() {
    super.initState();
    fetchMarketPrices();
  }

  Future<void> fetchMarketPrices() async {
    final List<Map<String, dynamic>> prices =
        await MongoDatabase.getMarketPrices();
    setState(() {
      marketPrices = prices;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Market Prices',
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
      body: ListView.builder(
        itemCount: marketPrices.length,
        itemBuilder: (context, index) {
          final entry = marketPrices[index];
          final date = entry['date'];
          final entries = entry['entries'] as List<dynamic>;

          return Card(
            margin: EdgeInsets.all(8.0),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.green,
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Date: $date',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      buildTableRow('Vegetable', 'Price', 0),
                      ...entries.map<TableRow>((entry) {
                        final vegetable = entry['vegetable'];
                        final price = entry['price'];

                        return buildTableRow(vegetable, 'RS.$price', 1);
                      }),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  TableRow buildTableRow(String label1, String label2, int index) {
    Color backgroundColor = index % 2 == 0
        ? Color.fromARGB(157, 131, 230, 106)
        : Color.fromARGB(139, 233, 225, 153);

    return TableRow(
      decoration: BoxDecoration(
        color: backgroundColor,
      ),
      children: [
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(label1, style: TextStyle(fontSize: 16)),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(label2, style: TextStyle(fontSize: 16)),
          ),
        ),
      ],
    );
  }
}
