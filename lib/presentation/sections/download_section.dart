import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../core/animations/scroll_animations.dart';
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
                color: Colors.white.withAlpha(217),
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            CtaButton(
              label: 'Download APK',
              icon: Icons.download,
              isPrimary: true,
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
      _StepData('⬇️', 'Download APK', 'Tap the Download APK button above.'),
      _StepData('⚙️', 'Enable Unknown Sources', 'Allow installation from outside the Play Store.'),
      _StepData('📱', 'Install & Enjoy', 'Open the APK file and start using Pamoja Thrift.'),
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
        const SizedBox(height: 24),
        ...List.generate(steps.length, (i) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _TimelineStep(step: steps[i], stepNumber: i + 1),
              if (i < steps.length - 1)
                Container(
                  width: 3,
                  height: 28,
                  color: AppColors.primary.withAlpha(120),
                ),
            ],
          );
        }),
      ],
    );
  }
}

class _StepData {
  final String emoji;
  final String title;
  final String description;

  const _StepData(this.emoji, this.title, this.description);
}

class _TimelineStep extends StatelessWidget {
  final _StepData step;
  final int stepNumber;

  const _TimelineStep({
    required this.step,
    required this.stepNumber,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSection(
      duration: const Duration(milliseconds: 600),
      delay: const Duration(milliseconds: 100),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(20),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Number circle
                Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '$stepNumber',
                      style: AppTextStyles.titleMedium.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${step.emoji} ${step.title}',
                        style: AppTextStyles.titleMedium.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        step.description,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _QrCodePlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    return Container(
      width: isMobile ? 100 : 130,
      height: isMobile ? 100 : 130,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withAlpha(100), width: 2),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.qr_code, size: 48, color: AppColors.primary),
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
