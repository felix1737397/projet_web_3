import 'package:alfred/alfred.dart';

import 'routes/livre.dart';
import 'routes/auteur.dart';
import 'routes/user.dart';

class V1Router {
  V1Router(NestedRoute app) {
    var users = app.route('/user', middleware: []);
    var auteur = app.route('/auteur', middleware: []);
    var livre = app.route('/livre', middleware: []);

    AuteurRouter(auteur);
    LivreRouter(livre);
    UserRouter(users);
  }
}
