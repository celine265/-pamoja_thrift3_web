import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class SectionHeading extends StatelessWidget {
  final String title;
  final String? subtitle;
  final TextAlign textAlign;
  final Color? titleColor;

  const SectionHeading({
    super.key,
    required this.title,
    this.subtitle,
    this.textAlign = TextAlign.center,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          textAlign == TextAlign.center ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.displayMedium.copyWith(
            color: titleColor ?? AppColors.textPrimary,
          ),
          textAlign: textAlign,
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 16),
          Text(
            subtitle!,
            style: AppTextStyles.bodyLarge,
            textAlign: textAlign,
          ),
        ],
        const SizedBox(height: 8),
        Container(
          width: 60,
          height: 4,
          decoration: BoxDecoration(
            color: AppColors.accent,
            borderRadius: BorderRadius.circular(2),
          ),
          margin: EdgeInsets.only(
            left: textAlign == TextAlign.center ? 0 : 0,
          ),
        ),
      ],
    );
  }
}
