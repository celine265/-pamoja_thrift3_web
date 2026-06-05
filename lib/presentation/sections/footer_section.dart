import 'package:flutter/material.dart';

import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class FooterSection extends StatelessWidget {
  final void Function(String)? onNavTap;

  const FooterSection({super.key, this.onNavTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.earthBrown,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(
                  Icons.recycling,
                  color: AppColors.earthBrown,
                  size: 18,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                AppConstants.logoText,
                style: AppTextStyles.titleLarge.copyWith(
                  color: AppColors.textOnDark,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 24,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: AppConstants.navItems.map((item) {
              return GestureDetector(
                onTap: onNavTap != null
                    ? () => onNavTap!(item['sectionId']!)
                    : null,
                child: Text(
                  item['label']!,
                  style: AppTextStyles.navLink.copyWith(
                    color: AppColors.textOnDark.withAlpha(200),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          const Divider(color: AppColors.earthBrownLight),
          const SizedBox(height: 16),
          Text(
            '© 2026 Pamoja Thrift. All Rights Reserved.',
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textOnDark.withAlpha(150),
            ),
          ),
        ],
      ),
    );
  }
}
