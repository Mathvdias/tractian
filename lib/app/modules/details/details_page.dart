import 'package:flutter/material.dart';
import 'package:tractian/app/core/core.dart';
import 'package:tractian/app/core/entities/request/request_entity.dart';
import 'package:tractian/app/design_system_kit/design_system_kit.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key, required this.order});
  final RequestEntity order;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
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
