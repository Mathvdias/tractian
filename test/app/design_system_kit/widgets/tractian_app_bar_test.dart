import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tractian/app/core/core.dart';
import 'package:tractian/app/design_system_kit/design_system_kit.dart';

final class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('TractianAppBar Widget Tests', () {
    testWidgets('Displays text title when useSvgCenter is false',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          appBar: TractianAppBar(
            useSvgCenter: false,
            textCenter: 'Test Title',
            svgBackAsset: SVGIcons.arrow,
          ),
        ),
      ));

      expect(find.text('Test Title'), findsOneWidget);
    });

    testWidgets('Displays SVG title when useSvgCenter is true',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          appBar: TractianAppBar(
            useSvgCenter: true,
            svgCenterAsset: SVGIcons.logo,
            svgBackAsset: SVGIcons.arrow,
          ),
        ),
      ));

      expect(find.byType(SvgPicture), findsNWidgets(2));
    });

    testWidgets('Displays back button with SVG icon',
        (WidgetTester tester) async {
      final mockObserver = MockNavigatorObserver();
      await tester.pumpWidget(MaterialApp(
        navigatorObservers: [mockObserver],
        home: Scaffold(
          appBar: TractianAppBar(
            useSvgCenter: false,
            textCenter: 'Test Title',
            svgBackAsset: SVGIcons.arrow,
          ),
        ),
      ));

      expect(find.byType(IconButton), findsOneWidget);
      expect(find.byType(SvgPicture), findsNWidgets(1));

      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();

      verify(mockObserver.didPop(captureAny.call(), any)).called(1);
    });

    testWidgets('Calls onBackPressed when back button is tapped',
        (WidgetTester tester) async {
      var backPressed = false;
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          appBar: TractianAppBar(
            useSvgCenter: false,
            textCenter: 'Test Title',
            svgBackAsset: SVGIcons.arrow,
            onBackPressed: () {
              backPressed = true;
            },
          ),
        ),
      ));

      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();

      expect(backPressed, isTrue);
    });
  });
}
