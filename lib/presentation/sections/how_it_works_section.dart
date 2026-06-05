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
      color: AppColors.surfaceLight,
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

    return Wrap(
      alignment: WrapAlignment.center,
      runSpacing: 32,
      spacing: 16,
      children: steps.map((step) {
        return SizedBox(
          width: isMobile ? 180 : 200,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _JourneyStep(step: step),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _JourneyStep extends StatelessWidget {
  final _JourneyStepData step;

  const _JourneyStep({
    required this.step,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _PhoneMockup(screenshotPath: step.screenshotPath),
        const SizedBox(height: 12),
        Text(
          step.title,
          style: AppTextStyles.titleMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 6),
        Text(
          step.description,
          style: AppTextStyles.bodyMedium.copyWith(height: 1.4, fontSize: 13),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _PhoneMockup extends StatelessWidget {
  final String screenshotPath;

  const _PhoneMockup({
    required this.screenshotPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 320,
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
  }
}


