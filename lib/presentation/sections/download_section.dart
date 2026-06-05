import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../widgets/cta_button.dart';
import '../widgets/section_wrapper.dart';

class DownloadSection extends StatelessWidget {
  final VoidCallback? onDownloadTap;

  const DownloadSection({super.key, this.onDownloadTap});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return Container(
      color: AppColors.primary,
      child: SectionWrapper(
        topPadding: 60,
        bottomPadding: 60,
        child: Column(
          children: [
            Icon(Icons.android, color: Colors.white.withAlpha(200), size: 48),
            const SizedBox(height: 12),
            Text(
              'Start Thrifting Smarter Today',
              style: (isMobile
                      ? AppTextStyles.displaySmall
                      : AppTextStyles.displayMedium)
                  .copyWith(color: AppColors.textOnPrimary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              'Join buyers and sellers using Pamoja Thrift to simplify second-hand shopping.',
              style: AppTextStyles.bodyLarge.copyWith(
                color: Colors.white.withAlpha(200),
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            CtaButton(
              label: 'Download APK',
              icon: Icons.download,
              isPrimary: false,
              onPressed: onDownloadTap,
            ),
            const SizedBox(height: 28),
            _InstallInstructions(isMobile: isMobile),
            const SizedBox(height: 20),
            _QrCodePlaceholder(),
          ],
        ),
      ),
    );
  }
}

class _InstallInstructions extends StatelessWidget {
  final bool isMobile;

  const _InstallInstructions({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final steps = [
      ('1', 'Download the APK file', 'Tap the Download APK button above'),
      ('2', 'Enable Unknown Sources',
          'Go to Settings > Security > Enable Unknown Sources'),
      ('3', 'Install & Enjoy',
          'Open the downloaded file and tap Install'),
    ];

    return Column(
      children: [
        Text(
          'How to Install',
          style: AppTextStyles.titleLarge.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        if (isMobile)
          Column(
            children: steps.map((s) => _InstallStep(step: s)).toList(),
          )
        else
          Row(
            children: steps.map((s) {
              return Expanded(child: _InstallStep(step: s));
            }).toList(),
          ),
      ],
    );
  }
}

class _InstallStep extends StatelessWidget {
  final (String, String, String) step;

  const _InstallStep({required this.step});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(25),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  step.$1,
                  style: AppTextStyles.titleMedium.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              step.$2,
              style: AppTextStyles.titleMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              step.$3,
              style: AppTextStyles.bodyMedium.copyWith(
                color: Colors.white.withAlpha(180),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _QrCodePlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 130,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withAlpha(100), width: 2),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.qr_code, size: 48, color: AppColors.primary.withAlpha(150)),
            const SizedBox(height: 4),
            Text(
              'Scan to\nDownload',
              textAlign: TextAlign.center,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
