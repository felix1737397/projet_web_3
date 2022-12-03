import 'package:alfred/alfred.dart';

import '../utilities/controllers/test.controller.dart';

class TestRouter {
  TestRouter(NestedRoute app) {
    app.post('/', (req, res) async {
      return await TestController.getData();
    });
  }
}
