import '../entities/auteur_entity.dart';
import '../services/auteur.service.dart';

class AuteurController {
  static Future<List<Auteur>> getData() async {
    return await AuteurService.getData();
  }

  static Future<Auteur> postData(Auteur auteur) async {
    return await AuteurService.postData(auteur);
  }

  static Future<Auteur> patchData(Auteur auteur) async {
    return await AuteurService.patchData(auteur);
  }

  static Future<bool> deleteData(String id) async {
    return await AuteurService.deleteData(id);
  }

  static Future<Auteur> getDataById(String id) async {
    return await AuteurService.getDataById(id);
  }

  static Future<int> getNombreAuteur() async {
    return await AuteurService.getNombreAuteurs();
  }
}
