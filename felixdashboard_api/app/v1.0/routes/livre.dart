import 'package:alfred/alfred.dart';

import '../utilities/controllers/livre.controller.dart';
import '../utilities/controllers/auteur.controller.dart';
import '../utilities/entities/livre_entity.dart';

class LivreRouter {
  LivreRouter(NestedRoute app) {
    app.get('/', (req, res) async {
      bool fr = req.uri.queryParameters['fr'].toString() == "true";
      bool en = req.uri.queryParameters['en'].toString() == "true";
      bool under500 = req.uri.queryParameters['under500'].toString() == "true";
      return LivreController.getData(fr, en, under500);
    });

    app.post('/', (req, res) async {
      var body = await req.body as Map<String, dynamic>;
      var livre = Livre.fromMap(body);

      return await LivreController.postData(livre);
    });

    app.patch('/:id', (req, res) async {
      var body = await req.body as Map<String, dynamic>;
      var livre = Livre.fromMap(body);
      return await LivreController.patchData(livre, req.params['id']);
    });

    app.delete('/:id', (req, res) async {
      var id = req.params['id'];
      var header = req.headers['permission'];
      if (header != null && header[0] != "admin") {
        return 403;
      }
      return await LivreController.deleteData(id);
    });

    app.get('/getNombreLivres', (req, res) async {
      return await LivreController.getNombreLivres();
    });
  }
}
