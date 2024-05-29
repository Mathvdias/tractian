import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tractian/app/core/core.dart';
import 'package:tractian/app/core/entities/request/request_entity.dart';
import 'package:tractian/app/modules/locations/locations_page.dart';

class TractianCard extends StatelessWidget {
  const TractianCard({
    super.key,
    required this.order,
  });
  final RequestEntity order;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final ColorScheme colorScheme = theme.colorScheme;

    final TextTheme textTheme = theme.textTheme;
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () => Navigator.of(context).push(
        RouteGenerator.generateRoute<void>(
          LocationsPage(order: order),
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
                style: textTheme.headlineMedium?.copyWith(
                  color: colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
