// ignore_for_file: non_constant_identifier_names

import 'dart:io' show Platform;

Map<String, String> vars = Platform.environment;

String BASE_URL = 'https://fake-api.tractian.com/';
String COMPANIES = 'companies';
String LOCATIONS(String companyId) => 'companies/$companyId/locations';
String ASSETS(String companyId) => 'companies/$companyId/assets';

class Env {
  var baseUrl = vars["BASE_URL"]?.isEmpty ?? BASE_URL;

  var username = vars["COMPANIES"]?.isEmpty ?? COMPANIES;
  var locations = vars["LOCATIONS"]?.isEmpty ?? LOCATIONS;
  var assets = vars["ASSETS"]?.isEmpty ?? ASSETS;
}