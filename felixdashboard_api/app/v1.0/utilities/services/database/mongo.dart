import 'dart:io';
import 'dart:convert';

import 'package:dartsv/dartsv.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:cron/cron.dart';
import '../../../../../bin/config.dart';

class MongoService {
  static DbConnection dbConnection = DbConnection._(
      Config.mongo["host"],
      Config.mongo["dbName"],
      Config.mongo["username"],
      Config.mongo["password"],
      Config.mongo["authDb"],
      (Config.mongo["connectionCert"].toString().isEmpty)
          ? null
          : Config.mongo["connectionCert"]);

  static Future<DbCollection> collection(String collection) async {
    var _database = await dbConnection.db;
    return _database.collection(collection);
  }

  static bool initialSetup = true;
  static bool inSetup = false;

  static Future setup() async {
    MongoService.inSetup = true;
    await dbConnection.db;
    MongoService.inSetup = false;
  }
}

class DbConnection {
  DbConnection._(this.host, this.dbName, this.username, this.password,
      this.authSourceDB, this.certificate);
  final String host;
  final String dbName;
  final String username;
  final String password;
  final String? certificate;
  final String authSourceDB;
  bool importedCertificate = false;

  String get connectionString =>
      'mongodb://$username:$password@$host/$authSourceDB?authSource=admin&retryWrites=true';

  int retryAttempts = 5;

  static bool started = false;

  Db? _db;
  Future<Db> get db async => getConnection();

  Future<void> close() async {
    if (_db != null) {
      await _db!.close();
    }
  }

  Future<Db> getConnection() async {
    if (_db == null || !_db!.isConnected) {
      await close();
      var retry = 0;
      while (true) {
        try {
          retry++;
          File? dataCert;
          String completeConnectionString = connectionString;
          if (certificate != null && !importedCertificate) {
            var cert = utf8.decode(base64Decode(certificate!));
            dataCert = await File('cert.crt').writeAsString(cert);
            // completeConnectionString += "&tlsCAFile=${dataCert.absolute.path}";
          }
          var db = Db(completeConnectionString);
          await db.open(
              secure: (dataCert == null) ? true : false,
              tlsCAFile: dataCert?.absolute.path);
          db.databaseName = dbName;
          _db = db;
          print('OK after "$retry" attempts');
          break;
        } catch (e) {
          print(e);
          if (retryAttempts < retry) {
            print('Exiting after "$retry" attempts');
            rethrow;
          }
          // each time waits a little bit more before re-trying
          await Future.delayed(Duration(milliseconds: 100 * retry));
        }
      }
    }
    return _db!;
  }
}
