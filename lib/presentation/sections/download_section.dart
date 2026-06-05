import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/constants/app_constants.dart';
import '../widgets/cta_button.dart';
import '../widgets/section_heading.dart';
import '../widgets/section_wrapper.dart';

class DownloadSection extends StatelessWidget {
  const DownloadSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return Container(
      color: AppColors.primary,
      child: SectionWrapper(
        child: Column(
          children: [
            SectionHeading(
              title: 'Download the Pamoja Thrift App',
              subtitle:
                  'Buy and sell products anytime, anywhere. Download the Pamoja'
                  ' Thrift app and enjoy a seamless marketplace experience'
                  ' directly from your phone.',
              titleColor: AppColors.textOnPrimary,
            ),
            const SizedBox(height: 32),
            CtaButton(
              label: 'Download APK',
              icon: Icons.download,
              isPrimary: false,
              onPressed: () {},
            ),
            const SizedBox(height: 32),
            _AppMetadata(isMobile: isMobile),
          ],
        ),
      ),
    );
  }
}

class _AppMetadata extends StatelessWidget {
  final bool isMobile;

  const _AppMetadata({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final metadata = [
      ('Version', AppConstants.appVersion),
      ('Size', AppConstants.appSize),
      ('Updated', AppConstants.lastUpdated),
    ];

    return Wrap(
      spacing: 24,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: metadata.map((m) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(30),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${m.$1}: ',
                style: AppTextStyles.caption.copyWith(
                  color: Colors.white70,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                m.$2,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
