// ignore_for_file: non_constant_identifier_names

import 'dart:io' show Platform;

Map<String, String> vars = Platform.environment;

String BASE_URL = 'https://fake-api.tractian.com/';
String COMPANIES = 'companies';
String LOCATIONS(String companyId) => 'companies/$companyId/locations';
String ASSETS(String companyId) => 'companies/$companyId/assets';
int CONNECT_TIMEOUT = 500000;
int RECEIVE_TIMEOUT = 500000;

class Env {
  var baseUrl = (vars["BASE_URL"]?.isEmpty ?? BASE_URL).toString();

  var companies = (vars["COMPANIES"]?.isEmpty ?? COMPANIES).toString();
  locations(String companyId) =>
      (vars["LOCATIONS"]?.isEmpty ?? LOCATIONS(companyId)).toString();
  assets(String companyId) =>
      (vars["ASSETS"]?.isEmpty ?? ASSETS(companyId)).toString();
  var connectTimeout =
      int.parse(vars["CONNECT_TIMEOUT"] ?? CONNECT_TIMEOUT.toString());
  var receiveTimeout =
      int.parse(vars["RECEIVE_TIMEOUT"] ?? RECEIVE_TIMEOUT.toString());
}

var env = Env();
