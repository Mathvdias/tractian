import 'package:flutter/material.dart';
import 'package:tractian/app/core/core.dart';
import 'package:tractian/app/core/entities/request/request_entity.dart';
import 'package:tractian/app/design_system_kit/design_system_kit.dart';
import 'package:tractian/app/modules/components/interactor/controllers/components_controller.dart';
import 'package:tractian/app/modules/components/interactor/entities/request_components_entity.dart';
import 'package:tractian/app/modules/locations/interactor/controllers/locations_controller.dart';
import 'package:tractian/app/modules/locations/interactor/entities/request_locations_entity.dart';
import 'package:tractian/app/modules/tree/tree.dart';

class LocationsPage extends StatefulWidget {
  const LocationsPage({super.key, required this.order});
  final RequestEntity order;

  @override
  State<LocationsPage> createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  final localizationsController = di.get<LocationsController>();
  final componentsController = di.get<ComponentsController>();

  @override
  void initState() {
    fetchAll();
    super.initState();
  }

  void fetchAll() async {
    Future.wait([
      localizationsController.call(widget.order.id ?? ''),
      componentsController.call(widget.order.id ?? '')
    ]);
  }

  String searchTerm = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TractianAppBar(
        svgBackAsset: SVGIcons.arrow,
        textCenter: 'Assets',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ValueListenableBuilder(
          valueListenable: localizationsController,
          builder: (context, state, __) {
            if (state is SuccessState<RequestLocationsListEntity>) {
              return ValueListenableBuilder(
                valueListenable: componentsController,
                builder: (context, compState, __) {
                  if (compState is SuccessState<RequestComponentsListEntity>) {
                    return TreePage(
                      locations: state.data.requests,
                      components: compState.data.requests,
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
