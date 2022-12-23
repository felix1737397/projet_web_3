import 'package:alfred/alfred.dart';
import 'package:mongo_dart/mongo_dart.dart';
import '../entities/livre_entity.dart';
import 'database/mongo.dart';

class LivreService {
  static Future<DbCollection> collection() async =>
      await MongoService.collection('livre');

  static Future<List<Livre>> getData(bool fr, bool en, bool under500) async {
    var query = where;
    if (fr) {
      query = query.eq('langage', 'fr');
    }
    if (en) {
      query = query.eq('langage', 'en');
    }
    if (under500) {
      query = query.lt('nb_pages', 500);
    }
    var result = await (await collection()).find(query).toList();
    return result.map((e) => Livre.fromMap(e)).toList();
  }

  static Future<Livre> postData(Livre livre) async {
    var result = await (await collection()).insert(livre.toMap());
    if (result.isEmpty) {
      throw AlfredException(500, "erreur dans l'ajout du livre");
    }
    return livre;
  }

  static Future<bool> patchData(Livre livre, String id) async {
    var result = await (await collection()).replaceOne(
        {"_id": ObjectId.fromHexString(id)}, livre.toMap(withId: false),
        upsert: true);
    if (result.isFailure) {
      throw AlfredException(500, livre.id);
    }
    return true;
  }

  static Future<bool> deleteData(String id) async {
    var result =
        await (await collection()).remove(where.id(ObjectId.parse(id)));
    if (result.isEmpty) {
      throw AlfredException(500, id);
    }
    return true;
  }

  static Future<int> getNombreLivres() async {
    var result = await (await collection()).aggregateToStream([
      {
        "\$group": {
          "_id": null,
          "nb_livres": {"\$sum": 1},
        }
      }
    ]).toList();

    return result[0]['nb_livres'];
  }
}
