import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../widgets/section_wrapper.dart';

class HowItWorksSection extends StatelessWidget {
  const HowItWorksSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return Container(
      color: Colors.white,
      child: SectionWrapper(
        bottomPadding: 40,
        child: Column(
          children: [
            Text(
              'How Pamoja Thrift Works',
              style: isMobile
                  ? AppTextStyles.displaySmall
                  : AppTextStyles.displayMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            _JourneySection(
              steps: const [
                _JourneyStepData(
                  screenshotPath: 'assets/screenshots/Screenshot 2026-06-05 120522.png',
                  title: 'Login or Register',
                  description:
                      'Create an account and access thousands of available products.',
                ),
                _JourneyStepData(
                  screenshotPath: 'assets/screenshots/Screenshot 2026-06-05 120943.png',
                  title: 'Browse Products',
                  description:
                      'Browse listings and discover clothing that matches your style and budget.',
                ),
                _JourneyStepData(
                  screenshotPath: 'assets/screenshots/Screenshot 2026-06-05 121012.png',
                  title: 'Add to Cart',
                  description:
                      'Select your preferred products and add them to your cart.',
                ),
                _JourneyStepData(
                  screenshotPath: 'assets/screenshots/Screenshot 2026-06-05 122012.png',
                  title: 'Place an Order',
                  description:
                      'Place your order and connect directly with the seller.',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _JourneyStepData {
  final String screenshotPath;
  final String title;
  final String description;

  const _JourneyStepData({
    required this.screenshotPath,
    required this.title,
    required this.description,
  });
}

class _JourneySection extends StatelessWidget {
  final List<_JourneyStepData> steps;

  const _JourneySection({
    required this.steps,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    if (isMobile) {
      return Column(
        children: steps.asMap().entries.map((entry) {
          final i = entry.key;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _JourneyStep(step: entry.value, stepNumber: i + 1, isMobile: true),
              if (i < steps.length - 1) _TimelineConnector(isVertical: true),
            ],
          );
        }).toList(),
      );
    }

    return Column(
      children: steps.asMap().entries.map((entry) {
        final i = entry.key;
        final isReversed = i.isOdd;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _AlternatingRow(
              step: entry.value,
              stepNumber: i + 1,
              isReversed: isReversed,
            ),
            if (i < steps.length - 1) _TimelineConnector(isVertical: false),
          ],
        );
      }).toList(),
    );
  }
}

class _TimelineConnector extends StatelessWidget {
  final bool isVertical;

  const _TimelineConnector({required this.isVertical});

  @override
  Widget build(BuildContext context) {
    if (isVertical) {
      return Container(
        width: 3,
        height: 32,
        color: AppColors.primary.withAlpha(60),
      );
    }
    return Container(
      height: 3,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: AppColors.primary.withAlpha(60),
    );
  }
}

class _AlternatingRow extends StatelessWidget {
  final _JourneyStepData step;
  final int stepNumber;
  final bool isReversed;

  const _AlternatingRow({
    required this.step,
    required this.stepNumber,
    required this.isReversed,
  });

  @override
  Widget build(BuildContext context) {
    final children = [
      Expanded(
        child: isReversed
            ? _StepContent(step: step, stepNumber: stepNumber)
            : _PhoneMockup(screenshotPath: step.screenshotPath),
      ),
      const SizedBox(width: 48),
      Expanded(
        child: isReversed
            ? _PhoneMockup(screenshotPath: step.screenshotPath)
            : _StepContent(step: step, stepNumber: stepNumber),
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: children,
      ),
    );
  }
}

class _JourneyStep extends StatelessWidget {
  final _JourneyStepData step;
  final int stepNumber;
  final bool isMobile;

  const _JourneyStep({
    required this.step,
    required this.stepNumber,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _PhoneMockup(screenshotPath: step.screenshotPath, isMobile: isMobile),
        const SizedBox(height: 12),
        _StepContent(step: step, stepNumber: stepNumber, isMobile: isMobile),
      ],
    );
  }
}

class _StepContent extends StatelessWidget {
  final _JourneyStepData step;
  final int stepNumber;
  final bool isMobile;

  const _StepContent({
    required this.step,
    required this.stepNumber,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: isMobile ? 32 : 36,
          height: isMobile ? 32 : 36,
          decoration: const BoxDecoration(
            color: AppColors.accent,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '$stepNumber',
              style: AppTextStyles.titleMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: isMobile ? 14 : 16,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          step.title,
          style: (isMobile ? AppTextStyles.titleMedium : AppTextStyles.titleMedium).copyWith(
            fontWeight: FontWeight.w600,
            fontSize: isMobile ? 15 : 18,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          step.description,
          style: AppTextStyles.bodyMedium.copyWith(height: 1.4, fontSize: isMobile ? 12 : 13),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _PhoneMockup extends StatelessWidget {
  final String screenshotPath;
  final bool isMobile;

  const _PhoneMockup({
    required this.screenshotPath,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final phoneWidth = isMobile
            ? (constraints.maxWidth * 0.45).clamp(120.0, 160.0)
            : 160.0;
        final phoneHeight = phoneWidth * 2.0;
        return Container(
          width: phoneWidth,
          height: phoneHeight,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.grey.shade300, width: 3),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(20),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(21),
            child: Column(
              children: [
                Container(
                  height: 24,
                  color: Colors.grey.shade200,
                  child: Center(
                    child: Container(
                      width: 50,
                      height: 6,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Image.asset(
                    screenshotPath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey.shade100,
                        child: Center(
                          child: Icon(Icons.image_outlined, color: Colors.grey.shade400, size: 40),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}