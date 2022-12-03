import 'package:alfred/alfred.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'database/mongo.dart';

class TestService {
  static Future<DbCollection> collection() async =>
      await MongoService.collection('livre');

  static Future<String> getData() async {
    var collection = await TestService.collection();
    var data = await collection.find().toList();
    return data.toString();
  }
}
