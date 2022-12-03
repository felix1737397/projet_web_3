import 'package:alfred/alfred.dart';

import 'routes/livre.dart';
import 'routes/test.dart';

class V1Router {
  V1Router(NestedRoute app) {
    var admin = app.route('/admin', middleware: []);
    var users = app.route('/users', middleware: []);
    var openweather = app.route("/openweather", middleware: []);
    var test = app.route('/test', middleware: []);
    var livre = app.route('/livre', middleware: []);

    TestRouter(test);
    LivreRouter(livre);
    // AdminRouter(admin);
    // UsersRouter(users);
    // OpenWeatherRouter(openweather);
  }
}
