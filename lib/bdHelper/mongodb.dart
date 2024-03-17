import 'dart:developer';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:smartfarm/bdHelper/constant.dart';

class NewsModel {
  late String title;
  late String content;
  //late String image;

  NewsModel({required this.title, required this.content});

  // Add any additional methods or properties if needed
}

class MongoDatabase {
  static var db,
      db2,
      userCollection,
      cropCollection,
      newCultivationCollection,
      newsCollection,
      noticeCollection,
      marketPriceCollection,
      cultivationsCollection;

  static Future<void> connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    inspect(db);
    userCollection = db.collection(USER_COLLECTION);
    newCultivationCollection = db.collection("newcultivation");

    db2 = await Db.create(TEST_MONGO_CONN_URL);
    await db2.open();
    inspect(db2);
    cropCollection = db2.collection(TEST_USER_COLLECTION);
    cultivationsCollection = db2.collection("cultivations");
    newsCollection = db2.collection("news");
    noticeCollection = db2.collection("notices");
    marketPriceCollection = db2.collection("marketprices");
  }

  static Future<Map<String, dynamic>> getCultivationById(String id) async {
    await connect();
    var cultivation =
        await newCultivationCollection.findOne(where.id(ObjectId.parse(id)));

    await db.close();
    return cultivation != null ? cultivation : {};
  }

  static Future<List<String>> getCropTypes() async {
    await connect();
    final collection = cultivationsCollection;
    final cursor = await collection.find(where.sortBy('crop').fields(['crop']));

    final List<String> cropTypes = [];
    await cursor.forEach((crop) {
      if (crop != null && crop['crop'] != null) {
        cropTypes.add(crop['crop'] as String);
      }
    });

    await db.close();
    return cropTypes;
  }

  static Future<String?> getFertilizerName(String cropType) async {
    await connect();
    var cultivation = await cultivationsCollection.findOne({
      'crop': cropType,
    });

    await db.close();
    return cultivation != null ? cultivation['fertilizer'] as String : null;
  }

  static Future<String?> getFertilizerAmount(String cropType) async {
    await connect();
    var cultivation = await cultivationsCollection.findOne({
      'crop': cropType,
    });

    await db.close();
    return cultivation != null
        ? cultivation['fertilizerAmount'] as String
        : null;
  }

  static Future<void> deleteCultivationData() async {
    await connect();

    // Replace the following with your actual MongoDB deletion code
    await newCultivationCollection.remove(where.eq('someField', 'someValue'));

    print('Cultivation data deleted successfully');

    await db.close();
  }

  static Future<String?> getFertilizerDate(String cropType) async {
    await connect();
    var cultivation = await cultivationsCollection.findOne({
      'crop': cropType,
    });

    await db.close();
    return cultivation != null ? cultivation['fertilizerDate'] as String : null;
  }

  static Future<String?> getStartedDate(String cropType) async {
    await connect();
    var cultivation = await cultivationsCollection.findOne({
      'crop': cropType,
    });

    await db.close();
    return cultivation != null ? cultivation['startingDate'] as String : null;
  }

  static Future<String?> getPlantsAmount(String cropType) async {
    await connect();
    var cultivation = await cultivationsCollection.findOne({
      'crop': cropType,
    });

    await db.close();
    return cultivation != null ? cultivation['plants'] as String : null;
  }

  static Future<void> insertData(String firstName, String lastName,
      String email, String password, String address) async {
    await connect();
    var id = ObjectId();

    await userCollection.insert({
      '_id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'address': address,
    });

    print('User data inserted successfully');

    await db.close();
  }

  static Future<void> insertNewCultivationData(
      String cropType,
      String landName,
      String landSize,
      DateTime startingDate,
      String province,
      String district,
      String nearTown) async {
    await connect();
    var id = ObjectId();

    await newCultivationCollection.insert({
      '_id': id,
      'cropType': cropType,
      'landName': landName,
      'landSize': landSize,
      'startingDate': startingDate,
      'location': {
        'province': province,
        'district': district,
        'nearTown': nearTown,
      },
    });

    print('New cultivation data inserted successfully');

    await db.close();
  }

  static Future<void> insertCultivationData(
      String cropType,
      String area,
      String plants,
      String wet,
      String fertilizer,
      String fertilizerAmount,
      String fertilizerDate,
      String temperature) async {
    await connect();
    var id = ObjectId();

    await cultivationsCollection.insert({
      '_id': id,
      'crop': cropType,
      'area': area,
      'plants': plants,
      'wet': wet,
      'fertilizer': fertilizer,
      'fertilizerAmount': fertilizerAmount,
      'fertilizerDate': fertilizerDate,
      'temperature': temperature,
    });

    print('Cultivation data inserted successfully');

    await db.close();
  }

  static Future<bool> validateUser(String email, String password) async {
    await connect();
    var user = await userCollection.findOne({
      'email': email,
      'password': password,
    });

    await db.close();
    return user != null;
  }

  static Future<List<Map<String, dynamic>>> getNewCultivations() async {
    await connect();
    final collection = newCultivationCollection;
    final cursor = await collection.find();

    final List<Map<String, dynamic>> cultivations = [];
    await cursor.forEach((cultivation) {
      if (cultivation != null) {
        cultivations.add(cultivation);
      }
    });

    await db.close();
    return cultivations;
  }

  static Future<String> getUserFirstName(String email) async {
    await connect();
    var user = await userCollection.findOne({'email': email});

    await db.close();

    return user != null ? user['firstName'] as String : '';
  }

  static Future<List<NewsModel>> getNews() async {
    await connect();
    final collection = newsCollection; // Assuming "news" is the collection name

    final cursor = await collection.find();

    final List<NewsModel> newsList = [];
    await cursor.forEach((news) {
      if (news != null) {
        // Convert MongoDB document to NewsModel
        final NewsModel newsModel = NewsModel(
          title: news['title'] as String,
          content: news['body'] as String,
          // image: news['image'] as String,
        );

        newsList.add(newsModel);
      }
    });

    await db2.close();
    return newsList;
  }

  static Future<List<NewsModel>> getNotice() async {
    await connect();
    final collection =
        noticeCollection; // Assuming "news" is the collection name

    final cursor = await collection.find();

    final List<NewsModel> noticeList = [];
    await cursor.forEach((notices) {
      if (notices != null) {
        // Convert MongoDB document to NewsModel
        final NewsModel noticeModel = NewsModel(
          title: notices['title'] as String,
          content: notices['body'] as String,
          // image: news['image'] as String,
        );

        noticeList.add(noticeModel);
      }
    });

    await db2.close();
    return noticeList;
  }

  static Future<List<Map<String, dynamic>>> getMarketPrices() async {
    await connect();
    final collection =
        marketPriceCollection; // Assuming "marketPrice" is the collection name
    final cursor = await collection.find();

    final List<Map<String, dynamic>> prices = [];
    await cursor.forEach((price) {
      if (price != null) {
        prices.add(price);
      }
    });

    await db.close();
    return prices;
  }

  static Future<void> deleteCultivationDetails(String id) async {
    await connect();

    await cultivationsCollection.remove(where.id(ObjectId.parse(id)));

    print('Cultivation data deleted successfully');

    await db2.close();
  }
}
