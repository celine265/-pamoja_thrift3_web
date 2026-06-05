import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class SocialIconRow extends StatelessWidget {
  final double iconSize;
  final Color? iconColor;

  const SocialIconRow({
    super.key,
    this.iconSize = 24,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final color = iconColor ?? AppColors.primary;
    final icons = [
      Icons.facebook,
      Icons.camera_alt,
      Icons.alternate_email,
      Icons.chat_bubble_outline,
    ];

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: icons.map((icon) {
        return Padding(
          padding: const EdgeInsets.only(right: 8),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Container(
              decoration: BoxDecoration(
                color: color.withAlpha(25),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: null,
                icon: Icon(icon, color: color, size: iconSize),
                tooltip: _getTooltip(icon),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  String _getTooltip(IconData icon) {
    if (icon == Icons.facebook) return 'Facebook';
    if (icon == Icons.camera_alt) return 'Instagram';
    if (icon == Icons.alternate_email) return 'Twitter';
    if (icon == Icons.chat_bubble_outline) return 'WhatsApp';
    return '';
  }
}
