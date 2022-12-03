import '../entities/livre_entity.dart';
import '../services/livre.service.dart';
import '../services/test.service.dart';

class LivreController {
  static Future<List<Livre>> getData() async {
    return await LivreService.getData();
  }

  static Future<Livre> postData(Livre livre) async {
    return await LivreService.postData(livre);
  }

  static Future<bool> patchData(Livre livre, String id) async {
    return await LivreService.patchData(livre, id);
  }

  static Future<String> deleteData(String id) async {
    var data = await LivreService.deleteData(id);
    return data.toString();
  }
}
