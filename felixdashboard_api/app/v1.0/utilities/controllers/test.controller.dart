import '../services/test.service.dart';

class TestController {
  static Future<String> getData() async {
    var data = await TestService.getData();
    return data.toString();
  }
}
