// ignore_for_file: constant_identifier_names, non_constant_identifier_names

const String BASE_URL = String.fromEnvironment(
  'BASE_URL',
  defaultValue: 'https://fake-api.tractian.com/',
);
const String COMPANIES = String.fromEnvironment(
  'COMPANIES',
  defaultValue: 'companies',
);
const int CONNECT_TIMEOUT = int.fromEnvironment(
  'CONNECT_TIMEOUT',
  defaultValue: 500000,
);
const int RECEIVE_TIMEOUT = int.fromEnvironment(
  'RECEIVE_TIMEOUT',
  defaultValue: 500000,
);

String LOCATIONS(String companyId) => 'companies/$companyId/locations';
String ASSETS(String companyId) => 'companies/$companyId/assets';

class Env {
  final String baseUrl = BASE_URL;
  final String companies = COMPANIES;
  final int connectTimeout = CONNECT_TIMEOUT;
  final int receiveTimeout = RECEIVE_TIMEOUT;

  String locations(String companyId) => LOCATIONS(companyId);
  String assets(String companyId) => ASSETS(companyId);
}

final env = Env();
