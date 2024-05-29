import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tractian/app/app_widget.dart';
import 'package:tractian/app/core/core.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent,
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  setup();

  runApp(const TractianApp());
}
