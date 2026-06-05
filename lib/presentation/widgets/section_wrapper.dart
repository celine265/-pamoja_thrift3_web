import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class SectionWrapper extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final double topPadding;
  final double bottomPadding;

  const SectionWrapper({
    super.key,
    required this.child,
    this.backgroundColor,
    this.topPadding = 60,
    this.bottomPadding = 60,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? AppColors.backgroundLight,
      padding: EdgeInsets.only(
        top: topPadding,
        bottom: bottomPadding,
        left: 16,
        right: 16,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: child,
        ),
      ),
    );
  }
}
