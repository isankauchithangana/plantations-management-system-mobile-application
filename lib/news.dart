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
        title: Text('News'),
      ),
      body: newsList.isEmpty // Check if the list is empty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: newsList.length,
              itemBuilder: (context, index) {
                final NewsModel news = newsList[index];
                return NewsTile(news: news);
              },
            ),
    );
  }
}

class NewsTile extends StatelessWidget {
  final NewsModel news;

  const NewsTile({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(news.title),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsDetailsPage(news: news),
          ),
        );
      },
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
        title: Text(news.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.blue,
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
