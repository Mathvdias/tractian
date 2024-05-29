import 'package:flutter/material.dart';
import 'package:tractian/app/core/core.dart';
import 'package:tractian/app/design_system_kit/design_system_kit.dart';
import 'package:tractian/app/modules/modules.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController = di.get<HomeController>();
  @override
  void initState() {
    homeController.getCompanies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final TextTheme textTheme = theme.textTheme;

    return Scaffold(
      appBar: TractianAppBar(
        useSvgCenter: true,
        svgCenterAsset: SVGIcons.logo,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ValueListenableBuilder(
            valueListenable: homeController,
            builder: (context, state, __) {
              return switch (state) {
                SuccessState(:final RequestListEntity data) => Column(
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
                            return TractianCard(order: order);
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
