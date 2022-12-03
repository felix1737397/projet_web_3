import 'package:alfred/alfred.dart';

class IndexRouter {
  IndexRouter(NestedRoute app) {
    app.get('/loaderio-c35ca604e3b97034dde9e25fcf605f1e/', (req, res) => 'loaderio-c35ca604e3b97034dde9e25fcf605f1e');
    app.get('/', (req, res) => 'Index text router');
  }
}
