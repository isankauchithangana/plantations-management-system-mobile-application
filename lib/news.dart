import 'package:flutter/material.dart';
import 'package:smartfarm/bdHelper/mongodb.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late List<NewsModel> newsList = []; // Initialize with an empty list

  @override
  void initState() {
    super.initState();
    loadNews();
  }

  Future<void> loadNews() async {
    final List<NewsModel> news = await MongoDatabase.getNews();
    setState(() {
      newsList = news;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'News',
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
        child: newsList.isEmpty // Check if the list is empty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: newsList.length,
                itemBuilder: (context, index) {
                  final NewsModel news = newsList[index];
                  return NewsTile(news: news);
                },
              ),
      ),
    );
  }
}

class NewsTile extends StatelessWidget {
  final NewsModel news;

  const NewsTile({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: Color.fromARGB(248, 255, 255, 255).withOpacity(0.8), // Set transparency level here
      child: ListTile(
        title: Text(
          news.title,
          style: TextStyle(color: const Color.fromARGB(255, 2, 2, 2)), // Text color for visibility
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewsDetailsPage(news: news),
            ),
          );
        },
      ),
    );
  }
}


class NewsDetailsPage extends StatelessWidget {
  final NewsModel news;

  const NewsDetailsPage({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
        title: Text(
          news.title,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 95, 3, 3),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                news.title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              news.content,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            //Image.network(
            //  news.image,
            // fit: BoxFit.cover,
            // ),
          ],
        ),
      ),
    );
  }
}
