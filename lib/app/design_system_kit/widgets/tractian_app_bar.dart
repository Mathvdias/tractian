import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TractianAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool useSvgCenter;
  final String? svgCenterAsset;
  final String? textCenter;
  final String svgBackAsset;
  final VoidCallback? onBackPressed;

  const TractianAppBar({
    super.key,
    this.useSvgCenter = false,
    this.svgCenterAsset,
    this.textCenter,
    this.svgBackAsset = '',
    this.onBackPressed,
  }) : assert(useSvgCenter ? svgCenterAsset != null : textCenter != null);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: svgBackAsset.isNotEmpty
          ? IconButton(
              icon: SvgPicture.string(svgBackAsset),
              onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
            )
          : null,
      centerTitle: true,
      title: useSvgCenter
          ? SvgPicture.string(svgCenterAsset ?? '')
          : Text(
              textCenter!,
              style: const TextStyle(color: Colors.white),
            ),
      backgroundColor: const Color.fromRGBO(23, 25, 45, 1.0),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
