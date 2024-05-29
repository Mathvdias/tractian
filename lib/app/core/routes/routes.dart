import 'package:flutter/cupertino.dart';

final class RouteGenerator {
  static Route<T> generateRoute<T>(Widget page) {
    return CupertinoPageRoute<T>(
      builder: (_) => page,
      fullscreenDialog: true,
    );
  }
}
