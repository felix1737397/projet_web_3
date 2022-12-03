import 'dart:convert';
import 'dart:io';

import 'package:alfred/alfred.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../app/index.dart';
import '../app/v1.0/utilities/services/database/mongo.dart';
import '../app/v1.0/v1.0.dart';
import 'config.dart';

late Alfred app;

void main() async {
  app = Alfred(simultaneousProcessing: 100);
  app.all('*', cors(origin: '*'));

  var v1 = app.route('/v1.0', middleware: []);
  var ws = app.route('/ws');
  var index = app.route('/');

  V1Router(v1);

  IndexRouter(index);

  await MongoService.setup();
  // MongoS

  await app.listen(8080);
}
