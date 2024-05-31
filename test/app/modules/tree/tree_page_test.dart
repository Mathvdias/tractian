import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tractian/app/core/core.dart';
import 'package:tractian/app/core/entities/request/request.dart';
import 'package:tractian/app/core/entities/request/request_entity.dart';
import 'package:tractian/app/modules/components/components.dart';
import 'package:tractian/app/modules/modules.dart';
import 'package:tractian/app/modules/tree/tree_page.dart';

class MockLocationsController extends Mock implements LocationsController {
  @override
  ValueNotifier<BaseState> get valueNotifier =>
      ValueNotifier<InitialState>(InitialState());
}

class MockComponentsController extends Mock implements ComponentsController {
  @override
  ValueNotifier<BaseState> get valueNotifier =>
      ValueNotifier<InitialState>(InitialState());
}

void main() {
  late MockLocationsController mockLocationsController;
  late MockComponentsController mockComponentsController;

  setUp(() {
    mockLocationsController = MockLocationsController();
    mockComponentsController = MockComponentsController();

    di.registerSingleton<LocationsController>(mockLocationsController);
    di.registerSingleton<ComponentsController>(mockComponentsController);
  });

  tearDown(() {
    di.reset();
  });

  Widget createWidgetUnderTest(RequestEntity order) {
    return MaterialApp(
      home: LocationsPage(order: order),
    );
  }

  group('LocationsPage Tests', () {
    final RequestEntity testOrder = RequestEntity(id: '1', name: 'Test Order');

    testWidgets('displays CircularProgressIndicator when loading',
        (WidgetTester tester) async {
      when(mockLocationsController.valueNotifier.value)
          .thenReturn(LoadingState());
      when(mockComponentsController.valueNotifier.value)
          .thenReturn(LoadingState());

      await tester.pumpWidget(createWidgetUnderTest(testOrder));
      await tester.pump(); // Ensure the widget tree is fully built

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('displays TreePage when data is loaded',
        (WidgetTester tester) async {
      final locationsData = RequestLocationsListEntity(
        requests: [
          RequestLocationsEntity(id: '1', name: 'Location 1', parentId: '')
        ],
      );
      final componentsData = RequestComponentsListEntity(
        requests: [
          RequestComponentsEntity(
            id: '1',
            name: 'Component 1',
            parentId: '',
            locationId: '1',
            sensorId: '',
            sensorType: '',
            status: '',
            gatewayId: '',
          ),
        ],
      );

      when(mockLocationsController.valueNotifier.value).thenReturn(
          SuccessState<RequestLocationsListEntity>(data: locationsData));
      when(mockComponentsController.valueNotifier.value).thenReturn(
          SuccessState<RequestComponentsListEntity>(data: componentsData));

      await tester.pumpWidget(createWidgetUnderTest(testOrder));
      await tester.pump(); // Ensure the widget tree is fully built

      expect(find.byType(TreePage), findsOneWidget);
    });

    testWidgets('displays error message when an error occurs',
        (WidgetTester tester) async {
      when(mockLocationsController.valueNotifier.value).thenReturn(
          const ErrorState<BaseException>(
              exception: MockException(message: 'Error')));
      when(mockComponentsController.valueNotifier.value).thenReturn(
          const ErrorState<BaseException>(
              exception: MockException(message: 'Error')));

      await tester.pumpWidget(createWidgetUnderTest(testOrder));
      await tester.pump(); // Ensure the widget tree is fully built

      expect(find.text('Error'), findsWidgets);
    });
  });
}

class MockException extends BaseException {
  const MockException({
    required super.message,
  });
}
