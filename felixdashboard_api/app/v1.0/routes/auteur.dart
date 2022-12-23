import 'package:alfred/alfred.dart';

import '../utilities/controllers/auteur.controller.dart';
import '../utilities/entities/auteur_entity.dart';

class AuteurRouter {
  AuteurRouter(NestedRoute app) {
    app.post('/', (req, res) async {
      var body = await req.body as Map<String, dynamic>;
      var auteur = Auteur.fromMap(body);

      return await AuteurController.postData(auteur);
    });
    app.get('/getNombreAuteurs', (req, res) async {
      return await AuteurController.getNombreAuteur();
    });

    app.get('/', (req, res) async {
      return await AuteurController.getData();
    });
    app.get('/:id', (req, res) async {
      var id = req.params['id'];
      return await AuteurController.getDataById(id);
    });

    app.patch('/:id', (req, res) async {
      var body = await req.body as Map<String, dynamic>;
      var auteur = Auteur.fromMap(body);
      return await AuteurController.patchData(auteur);
    });

    app.delete('/:id', (req, res) async {
      var id = req.params['id'];
      return await AuteurController.deleteData(id);
    });
  }
}
