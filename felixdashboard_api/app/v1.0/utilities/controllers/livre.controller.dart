import '../entities/livre_entity.dart';
import '../services/livre.service.dart';
import '../services/auteur.service.dart';

class LivreController {
  static Future<List<Livre>> getData(bool fr, bool en, bool under500) async {
    return await LivreService.getData(fr, en, under500);
  }

  static Future<Livre> postData(Livre livre) async {
    return await LivreService.postData(livre);
  }

  static Future<bool> patchData(Livre livre, String id) async {
    return await LivreService.patchData(livre, id);
  }

  static Future<bool> deleteData(String id) async {
    var data = await LivreService.deleteData(id);
    return data;
  }

  static Future<int> getNombreLivres() async {
    return await LivreService.getNombreLivres();
  }
}
