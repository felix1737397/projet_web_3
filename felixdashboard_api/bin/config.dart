import 'dart:convert';
import 'dart:io';

class Config {
  static bool inDev = bool.fromEnvironment(
      'DEV'); // ((Platform.environment['DEV'] ?? String.fromEnvironment('DEV')) == "true") ? true : false;

  static String apiUrl =
      Platform.environment['API_URL'] ?? String.fromEnvironment('API_URL');

  static dynamic mongo = {
    "connectionCert": Platform.environment['MONGO_CONNECTION_CERT'] ??
        String.fromEnvironment('MONGO_CONNECTION_CERT'),
    "host": Platform.environment['MONGO_HOST'] ??
        String.fromEnvironment('MONGO_HOST'),
    "dbName": Platform.environment['MONGO_DBNAME'] ??
        String.fromEnvironment('MONGO_DBNAME'),
    "username": Platform.environment['MONGO_USER'] ??
        String.fromEnvironment('MONGO_USER'),
    "password": Platform.environment['MONGO_PASSWORD'] ??
        String.fromEnvironment('MONGO_PASSWORD'),
    "authDb": Platform.environment['MONGO_AUTHDB'] ??
        String.fromEnvironment('MONGO_AUTHDB')
  };
}
