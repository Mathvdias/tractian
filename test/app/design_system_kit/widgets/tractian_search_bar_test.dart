import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tractian/app/design_system_kit/design_system_kit.dart';

class MockValueChanged {
  bool wasCalled = false;
  String? value;

  void call(String value) {
    wasCalled = true;
    this.value = value;
  }
}

void main() {
  late MockValueChanged mockOnChanged;
  late MockValueChanged mockOnSubmitted;

  setUp(() {
    mockOnChanged = MockValueChanged();
    mockOnSubmitted = MockValueChanged();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: Scaffold(
        body: TractianSearchBar(
          onChanged: mockOnChanged.call,
          onSubmitted: mockOnSubmitted.call,
        ),
      ),
    );
  }

  testWidgets('TractianSearchBar calls onChanged when text is changed',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    await tester.enterText(find.byType(CupertinoSearchTextField), 'test');
    await tester.pump();

    expect(mockOnChanged.wasCalled, isTrue);
    expect(mockOnChanged.value, 'test');
  });

  testWidgets('TractianSearchBar calls onSubmitted when submit is pressed',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    await tester.enterText(find.byType(CupertinoSearchTextField), 'submit');
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pump();

    expect(mockOnSubmitted.wasCalled, isTrue);
    expect(mockOnSubmitted.value, 'submit');
  });
}
