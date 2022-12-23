import 'package:alfred/alfred.dart';

import '../utilities/controllers/livre.controller.dart';
import '../utilities/controllers/auteur.controller.dart';
import '../utilities/controllers/user.controller.dart';
import '../utilities/entities/livre_entity.dart';

class UserRouter {
  UserRouter(NestedRoute app) {
    app.post('/', (req, res) async {
      var body = await req.body as Map<String, dynamic>;
      var username = body['username'];
      var mot_de_passe = body['mot_de_passe'];
      var response =
          await UserController.getUserPermission(username, mot_de_passe);
      return response;
    });
  }
}
