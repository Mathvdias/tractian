import 'package:flutter/material.dart';
import 'package:tractian/app/core/core.dart';
import 'package:tractian/app/core/entities/request/request_entity.dart';
import 'package:tractian/app/design_system_kit/design_system_kit.dart';
import 'package:tractian/app/modules/modules.dart';

class LocationsPage extends StatefulWidget {
  const LocationsPage({super.key, required this.order});
  final RequestEntity order;

  @override
  State<LocationsPage> createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  final localizationsController = di.get<LocalizationsController>();
  @override
  void initState() {
    localizationsController.call(widget.order.id ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final TextTheme textTheme = theme.textTheme;

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
              return switch (state) {
                SuccessState(:final RequestLocationsListEntity data) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child:
                            Text('Companies', style: textTheme.headlineMedium),
                      ),
                      const SizedBox(height: 24),
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            final order = data.requests[index];
                            return Column(
                              children: [
                                Text(order.name),
                                Text(order.companyId),
                                Text(order.id.toString())
                              ],
                            );
                          },
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 16),
                          itemCount: data.requests.length,
                        ),
                      ),
                    ],
                  ),
                _ => const Center(child: CircularProgressIndicator()),
              };
            }),
      ),
    );
  }
}
