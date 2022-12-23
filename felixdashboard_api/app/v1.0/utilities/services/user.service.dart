import 'package:alfred/alfred.dart';
import 'package:mongo_dart/mongo_dart.dart';
import '../entities/livre_entity.dart';
import 'database/mongo.dart';

class Userservice {
  static Future<DbCollection> collection() async =>
      await MongoService.collection('user');

  static Future<String> getUserPermission(
      String identifiant, String motDePasse) async {
    var result = await (await collection())
        .find(
            where.eq('identifiant', identifiant).eq('mot_de_passe', motDePasse))
        .toList();
    if (result.isEmpty) {
      throw AlfredException(500, "User inexistant");
    }
    return result[0]['permission'];
  }
}
