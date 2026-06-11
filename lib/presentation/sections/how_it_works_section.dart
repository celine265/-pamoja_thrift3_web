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
        topPadding: isMobile ? 24 : 32,
        bottomPadding: isMobile ? 24 : 32,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'How Pamoja Thrift Works',
              style: (isMobile
                      ? AppTextStyles.headlineMedium
                      : AppTextStyles.displaySmall)
                  .copyWith(fontSize: isMobile ? 20 : 26),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: isMobile ? 14 : 18),
            isMobile
                ? _MobileSteps()
                : const _DesktopSteps(),
          ],
        ),
      ),
    );
  }
}

const _steps = [
  _StepData(
    screenshotPath: 'assets/screenshots/Screenshot 2026-06-05 120522.png',
    title: 'Login or Register',
    description: 'Create an account and access thousands of available products.',
  ),
  _StepData(
    screenshotPath: 'assets/screenshots/Screenshot 2026-06-05 120943.png',
    title: 'Browse Products',
    description: 'Browse listings and discover clothing that matches your style.',
  ),
  _StepData(
    screenshotPath: 'assets/screenshots/Screenshot 2026-06-05 121012.png',
    title: 'Add to Cart',
    description: 'Select your preferred products and add them to your cart.',
  ),
  _StepData(
    screenshotPath: 'assets/screenshots/Screenshot 2026-06-05 122012.png',
    title: 'Place an Order',
    description: 'Place your order and connect directly with the seller.',
  ),
];

class _StepData {
  final String screenshotPath;
  final String title;
  final String description;

  const _StepData({
    required this.screenshotPath,
    required this.title,
    required this.description,
  });
}

class _DesktopSteps extends StatelessWidget {
  const _DesktopSteps();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(_steps.length * 2 - 1, (i) {
        if (i.isOdd) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Icon(
              Icons.arrow_forward,
              color: AppColors.accent,
              size: 20,
            ),
          );
        }
        final idx = i ~/ 2;
        return Expanded(
          child: _StepCard(
            step: _steps[idx],
            stepNumber: idx + 1,
          ),
        );
      }),
    );
  }
}

class _MobileSteps extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _steps.length,
      separatorBuilder: (_, i) => Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Container(
          height: 16,
          width: 2,
          color: AppColors.primary.withAlpha(100),
        ),
      ),
      itemBuilder: (_, i) => _StepCard(
        step: _steps[i],
        stepNumber: i + 1,
        isMobile: true,
      ),
    );
  }
}

class _StepCard extends StatefulWidget {
  final _StepData step;
  final int stepNumber;
  final bool isMobile;

  const _StepCard({
    required this.step,
    required this.stepNumber,
    this.isMobile = false,
  });

  @override
  State<_StepCard> createState() => _StepCardState();
}

class _StepCardState extends State<_StepCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final card = Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(_isHovered ? 16 : 8),
            blurRadius: _isHovered ? 10 : 5,
            offset: Offset(0, _isHovered ? 3 : 1),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              widget.step.screenshotPath,
              height: widget.isMobile ? 90 : 70,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: widget.isMobile ? 90 : 70,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Icon(Icons.image_outlined, color: Colors.grey.shade400, size: 26),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: 28,
            height: 28,
            decoration: const BoxDecoration(
              color: AppColors.accent,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '${widget.stepNumber}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            widget.step.title,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
              fontSize: widget.isMobile ? 13 : 12,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 3),
          Text(
            widget.step.description,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondary,
              height: 1.3,
              fontSize: widget.isMobile ? 11 : 11,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );

    if (widget.isMobile) {
      return card;
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: _isHovered
            ? (Matrix4.identity()..setTranslationRaw(0, -2, 0))
            : Matrix4.identity(),
        child: card,
      ),
    );
  }
}
