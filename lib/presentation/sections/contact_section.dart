import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../widgets/section_wrapper.dart';
import '../widgets/social_icon_row.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return SectionWrapper(
      topPadding: 40,
      bottomPadding: 40,
      child: Column(
        children: [
          Text(
            'Get in Touch',
            style: isMobile
                ? AppTextStyles.displaySmall
                : AppTextStyles.displayMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'We\'d love to hear from you',
            style: AppTextStyles.bodyLarge.copyWith(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Container(
            width: 60,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.accent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 32),
          Wrap(
            spacing: isMobile ? 16 : 40,
            runSpacing: isMobile ? 32 : 24,
            alignment: WrapAlignment.center,
            children: [
              _ContactItem(
                icon: Icons.email_outlined,
                label: 'Email',
                value: AppConstants.contactEmail,
              ),
              _ContactItem(
                icon: Icons.phone_outlined,
                label: 'Phone',
                value: AppConstants.contactPhone,
              ),
            ],
          ),
          const SizedBox(height: 20),
          const SocialIconRow(iconSize: 28),
        ],
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _ContactItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.primary.withAlpha(25),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(icon, color: AppColors.primary, size: 28),
        ),
        const SizedBox(height: 12),
        Text(
          label,
          style: AppTextStyles.caption.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTextStyles.titleMedium.copyWith(
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
