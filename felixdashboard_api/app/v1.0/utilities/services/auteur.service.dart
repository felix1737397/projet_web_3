import 'package:alfred/alfred.dart';
import 'package:mongo_dart/mongo_dart.dart';
import '../entities/auteur_entity.dart';
import 'database/mongo.dart';

class AuteurService {
  static Future<DbCollection> collection() async =>
      await MongoService.collection('auteur');

  static Future<List<Auteur>> getData() async {
    var collection = await AuteurService.collection();
    var data = await collection.find().toList();
    return data.map((e) => Auteur.fromMap(e)).toList();
  }

  static Future<Auteur> postData(Auteur auteur) async {
    var collection = await AuteurService.collection();
    var data = await collection.insert(auteur.toMap(withId: false));

    if (data.isEmpty) {
      throw AlfredException(500, "erreur dans l'ajout de l'auteur");
    }
    auteur.id = data['_id'].toString();
    return auteur;
  }

  static Future<Auteur> patchData(Auteur auteur) async {
    var collection = await AuteurService.collection();
    var data = await collection.replaceOne({
      "_id": ObjectId.fromHexString(auteur.id!)
    }, auteur.toMap(withId: false), upsert: true);

    if (data.isFailure) {
      throw AlfredException(500, auteur.id);
    }
    return auteur;
  }

  static Future<bool> deleteData(String id) async {
    var collection = await AuteurService.collection();
    var data = await collection.remove(where.id(ObjectId.parse(id)));

    if (data.isEmpty) {
      throw AlfredException(500, id);
    }
    return true;
  }

  static Future<Auteur> getDataById(String id) async {
    var collection = await AuteurService.collection();
    var data = await collection.findOne(where.id(ObjectId.parse(id)));

    if (data == null) {
      throw AlfredException(404, id);
    }
    return Auteur.fromMap(data);
  }

  static Future<int> getNombreAuteurs() async {
    var collection = await AuteurService.collection();
    var data = await collection.aggregateToStream([
      {
        "\$group": {
          "_id": null,
          "nb_auteurs": {"\$sum": 1},
        }
      }
    ]).toList();

    if (data.isEmpty) {
      throw AlfredException(500, "erreur dans le calcul du nombre d'auteurs");
    }
    return data[0]['nb_auteurs'];
  }
}
