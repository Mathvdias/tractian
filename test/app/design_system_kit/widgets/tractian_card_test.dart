import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mockito/mockito.dart';
import 'package:tractian/app/core/entities/request/request_entity.dart';
import 'package:tractian/app/design_system_kit/design_system_kit.dart';
import 'package:tractian/app/modules/locations/locations_page.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  late RequestEntity mockOrder;
  late MockNavigatorObserver mockNavigatorObserver;

  setUp(() {
    mockOrder = RequestEntity(
      id: '1',
      name: 'Test Order',
    );
    mockNavigatorObserver = MockNavigatorObserver();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: Scaffold(
        body: TractianCard(order: mockOrder),
      ),
      navigatorObservers: [mockNavigatorObserver],
    );
  }

  testWidgets('TractianCard displays order name', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Test Order'), findsOneWidget);
    expect(find.byType(SvgPicture), findsOneWidget);
  });

  testWidgets('TractianCard navigates to LocationsPage on tap', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    await tester.tap(find.byType(TractianCard));
    await tester.pumpAndSettle();

    verify(mockNavigatorObserver.didPush(captureAny.call(), any));

    expect(find.byType(LocationsPage), findsOneWidget);
  });
}
