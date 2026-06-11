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
        topPadding: 16,
        bottomPadding: 20,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.android, color: Colors.white.withAlpha(200), size: 28),
            const SizedBox(height: 6),
            Text(
              'Start Thrifting Smarter Today',
              style: (isMobile
                      ? AppTextStyles.headlineMedium
                      : AppTextStyles.displaySmall)
                  .copyWith(color: AppColors.textOnPrimary, fontSize: isMobile ? 20 : 28),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              'Join buyers and sellers using Pamoja Thrift.',
              style: AppTextStyles.bodyMedium.copyWith(
                color: Colors.white.withAlpha(200),
                fontSize: isMobile ? 13 : 14,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            CtaButton(
              label: 'Download APK',
              icon: Icons.download,
              isPrimary: true,
              onPressed: onDownloadTap,
            ),
            const SizedBox(height: 14),
            _InstallSteps(isMobile: isMobile),
            const SizedBox(height: 10),
            _QrCodePlaceholder(),
          ],
        ),
      ),
    );
  }
}

class _InstallSteps extends StatelessWidget {
  final bool isMobile;

  const _InstallSteps({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final steps = [
      _StepData('Download APK', 'Tap the button above to download.'),
      _StepData('Enable Unknown Sources', 'Allow installation from external sources.'),
      _StepData('Install & Enjoy', 'Open the APK and complete installation.'),
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'How to Install',
          style: AppTextStyles.titleMedium.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: isMobile ? 15 : 16,
          ),
        ),
        SizedBox(height: isMobile ? 8 : 10),
        if (isMobile)
          _MobileSteps(steps: steps)
        else
          _DesktopSteps(steps: steps),
      ],
    );
  }
}

class _StepData {
  final String title;
  final String description;

  const _StepData(this.title, this.description);
}

class _MobileSteps extends StatelessWidget {
  final List<_StepData> steps;

  const _MobileSteps({required this.steps});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: steps.length,
      separatorBuilder: (_, i) => Container(
        height: 20,
        width: 2,
        color: AppColors.primary.withAlpha(120),
        margin: const EdgeInsets.only(left: 13),
      ),
      itemBuilder: (_, i) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${i + 1}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(12),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      steps[i].title,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      steps[i].description,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.3,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _DesktopSteps extends StatelessWidget {
  final List<_StepData> steps;

  const _DesktopSteps({required this.steps});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(steps.length * 2 - 1, (i) {
        if (i.isOdd) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Icon(
              Icons.arrow_forward,
              color: AppColors.accent,
              size: 22,
            ),
          );
        }
        final idx = i ~/ 2;
        return Expanded(
          child: _DesktopStepCard(
            step: steps[idx],
            stepNumber: idx + 1,
          ),
        );
      }),
    );
  }
}

class _DesktopStepCard extends StatelessWidget {
  final _StepData step;
  final int stepNumber;

  const _DesktopStepCard({
    required this.step,
    required this.stepNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(14),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 32,
            height: 32,
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
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            step.title,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 3),
          Text(
            step.description,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondary,
              height: 1.2,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _QrCodePlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    return Container(
      width: isMobile ? 80 : 100,
      height: isMobile ? 80 : 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white.withAlpha(100), width: 2),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.qr_code, size: isMobile ? 36 : 40, color: AppColors.primary),
            const SizedBox(height: 2),
            Text(
              'Scan to\nDownload',
              textAlign: TextAlign.center,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
                height: 1.2,
                fontSize: isMobile ? 10 : 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
