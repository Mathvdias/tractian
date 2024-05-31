import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:tractian/app/core/entities/request/request_entity.dart';
import 'package:tractian/app/core/core.dart';
import 'package:tractian/app/modules/home/home.dart';

class MockHomeController extends ValueNotifier<BaseState>
    implements HomeController {
  MockHomeController() : super(InitialState());

  @override
  BaseState get state => value;

  void setState(BaseState state) {
    value = state;
    notifyListeners();
  }

  @override
  void update(BaseState newState) {
    value = newState;
    notifyListeners();
  }

  @override
  Future<void> getCompanies() async {
    // Implemente a lógica de teste simulada, se necessário.
  }
}

class MockException extends BaseException {
  const MockException({
    required super.message,
  });
}

void main() {
  late MockHomeController mockHomeController;
  final getIt = GetIt.instance;

  setUp(() {
    mockHomeController = MockHomeController();
    getIt.registerSingleton<HomeController>(mockHomeController);
  });

  tearDown(() {
    getIt.reset();
  });

  Widget createWidgetUnderTest() {
    return const MaterialApp(
      home: HomePage(),
    );
  }

  group('HomePage Widget Tests', () {
    testWidgets('displays CircularProgressIndicator when loading',
        (WidgetTester tester) async {
      mockHomeController.setState(LoadingState());

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('displays list of companies when loaded',
        (WidgetTester tester) async {
      final mockData = RequestListEntity(requests: [
        RequestEntity(id: '1', name: 'Company 1'),
        RequestEntity(id: '2', name: 'Company 2'),
      ]);

      mockHomeController.setState(SuccessState(data: mockData));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      expect(find.text('Companies'), findsOneWidget);
      expect(find.text('Company 1'), findsOneWidget);
      expect(find.text('Company 2'), findsOneWidget);
    });

    // testWidgets('displays error message when an error occurs',
    //     (WidgetTester tester) async {
    //   mockHomeController
    //       .setState(const ErrorState(exception: MockException(message: 'Error')));

    //   await tester.pumpWidget(createWidgetUnderTest());

    //   expect(find.text('Error'), findsOneWidget);
    // });
  });
}
