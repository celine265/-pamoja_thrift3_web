import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../widgets/cta_button.dart';
import '../widgets/section_wrapper.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isTablet = ResponsiveBreakpoints.of(context).isTablet;

    return SectionWrapper(
      topPadding: 60,
      bottomPadding: 60,
      child: ResponsiveRowColumn(
        rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
        rowCrossAxisAlignment: CrossAxisAlignment.center,
        columnCrossAxisAlignment: CrossAxisAlignment.center,
        layout: isMobile || isTablet
            ? ResponsiveRowColumnType.COLUMN
            : ResponsiveRowColumnType.ROW,
        columnSpacing: 40,
        rowSpacing: 40,
        children: [
          ResponsiveRowColumnItem(
            rowFlex: 1,
            child: SizedBox(
              width: isMobile ? double.infinity : 560,
              child: Column(
                crossAxisAlignment: isMobile
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    'Buy and Sell Quality Second-Hand Products with Ease',
                    style: isMobile
                        ? AppTextStyles.displaySmall
                        : AppTextStyles.displayLarge,
                    textAlign:
                        isMobile ? TextAlign.center : TextAlign.start,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Pamoja Thrift connects buyers and sellers in a trusted marketplace where affordable products find new homes and communities benefit from sustainable shopping.',
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontSize: isMobile ? 15 : 16,
                    ),
                    textAlign:
                        isMobile ? TextAlign.center : TextAlign.start,
                  ),
                  const SizedBox(height: 32),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    alignment: isMobile
                        ? WrapAlignment.center
                        : WrapAlignment.start,
                    children: [
                      CtaButton(
                        label: 'Download APK',
                        icon: Icons.download,
                        onPressed: () {},
                      ),
                      CtaButton(
                        label: 'Post an Item',
                        isPrimary: false,
                        icon: Icons.add_circle_outline,
                        onPressed: () {},
                      ),
                      CtaButton(
                        label: 'Learn More',
                        isOutlined: true,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          ResponsiveRowColumnItem(
            rowFlex: 1,
            child: _HeroMockup(isMobile: isMobile),
          ),
        ],
      ),
    );
  }
}

class _HeroMockup extends StatelessWidget {
  final bool isMobile;

  const _HeroMockup({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = isMobile
            ? constraints.maxWidth * 0.7
            : (constraints.maxWidth.clamp(280, 400).toDouble());
        return Center(
          child: Container(
            width: size,
            height: size * 1.6,
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: AppColors.dividerLight,
                width: 4,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(30),
                  blurRadius: 40,
                  offset: const Offset(10, 20),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: size * 0.3,
                  height: 6,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(height: 20),
                Icon(
                  Icons.shopping_bag_outlined,
                  size: size * 0.2,
                  color: AppColors.primary.withAlpha(100),
                ),
                const SizedBox(height: 12),
                Text(
                  'Pamoja Thrift',
                  style: AppTextStyles.titleMedium.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Thrift with Purpose',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
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
