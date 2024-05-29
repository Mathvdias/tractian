import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tractian/app/core/core.dart';
import 'package:tractian/app/modules/modules.dart';

import 'app/design_system_kit/design_system_kit.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent,
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  setup();

  runApp(const TractianApp());
}

class TractianApp extends StatelessWidget {
  const TractianApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tractian App',
      theme: AppTheme.theme,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final homeController = di.get<HomeController>();
  @override
  void initState() {
    homeController.getCompanies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final ColorScheme colorScheme = theme.colorScheme;

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
                            return InkWell(
                              onTap: () => Navigator.of(context).push(
                                RouteGenerator.generateRoute<void>(
                                  const AssetPage(),
                                ),
                              ),
                              child: Card(
                                color: colorScheme.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(24.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SvgPicture.string(SVGIcons.process),
                                      const SizedBox(width: 16.0),
                                      Text(
                                        order.name,
                                        style:
                                            textTheme.headlineMedium?.copyWith(
                                          color: colorScheme.onPrimary,
                                        ),
                                      ),

                                      //   Text(order.id.toString())
                                    ],
                                  ),
                                ),
                              ),
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

class AssetPage extends StatefulWidget {
  const AssetPage({super.key});

  @override
  State<AssetPage> createState() => _AssetPageState();
}

class _AssetPageState extends State<AssetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TractianAppBar(
        svgBackAsset: SVGIcons.arrow,
        textCenter: 'Assets',
      ),
      body: Container(),
    );
  }
}
