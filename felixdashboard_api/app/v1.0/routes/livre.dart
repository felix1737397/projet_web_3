import 'package:alfred/alfred.dart';

import '../utilities/controllers/livre.controller.dart';
import '../utilities/controllers/test.controller.dart';
import '../utilities/entities/livre_entity.dart';

class LivreRouter {
  LivreRouter(NestedRoute app) {
    app.get('/', (req, res) async {
      return LivreController.getData();
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
      return await LivreController.deleteData(id);
    });
  }
}
