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

    final socials = [
      (Icons.facebook, 'Facebook', 'https://facebook.com/pamojathrift'),
      (Icons.camera_alt, 'Instagram', 'https://instagram.com/pamojathrift'),
      (Icons.alternate_email, 'Twitter', 'https://twitter.com/pamojathrift'),
      (Icons.chat_bubble_outline, 'WhatsApp', 'https://wa.me/254700000000'),
    ];

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: socials.map((s) {
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
                onPressed: () {},
                icon: Icon(s.$1, color: color, size: iconSize),
                tooltip: s.$2,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
