import 'package:flutter/material.dart';
import 'package:tractian/app/core/core.dart';
import 'package:tractian/app/modules/modules.dart';

class TractianApp extends StatelessWidget {
  const TractianApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tractian App',
      theme: AppTheme.theme,
      home: const HomePage(),
    );
  }
}
