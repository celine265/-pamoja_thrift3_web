import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../widgets/section_wrapper.dart';

class SellerProblemsSection extends StatelessWidget {
  const SellerProblemsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return Container(
      color: AppColors.surfaceLight,
      child: SectionWrapper(
        child: ResponsiveRowColumn(
          layout: isMobile
              ? ResponsiveRowColumnType.COLUMN
              : ResponsiveRowColumnType.ROW,
          rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
          rowCrossAxisAlignment: CrossAxisAlignment.center,
          columnCrossAxisAlignment: CrossAxisAlignment.center,
          columnSpacing: 40,
          rowSpacing: 40,
          children: [
            ResponsiveRowColumnItem(
              rowFlex: 1,
              child: _SellerContent(isMobile: isMobile),
            ),
            ResponsiveRowColumnItem(
              rowFlex: 1,
              child: _SellerImage(isMobile: isMobile),
            ),
          ],
        ),
      ),
    );
  }
}

class _SellerImage extends StatelessWidget {
  final bool isMobile;

  const _SellerImage({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: isMobile ? double.infinity : 480,
        height: isMobile ? 280 : 360,
        decoration: BoxDecoration(
          color: AppColors.accent.withAlpha(20),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.storefront_outlined,
              size: 80,
              color: AppColors.accentDark.withAlpha(150),
            ),
            const SizedBox(height: 16),
            Text(
              'Seller Opportunities',
              style: AppTextStyles.headlineMedium.copyWith(
                color: AppColors.accentDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SellerContent extends StatelessWidget {
  final bool isMobile;

  const _SellerContent({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          'Problems We Solve for Sellers',
          style: isMobile
              ? AppTextStyles.displaySmall
              : AppTextStyles.displayMedium,
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
        ),
        const SizedBox(height: 24),
        ..._sellerProblems.map((p) => _SellerProblemSolutionItem(
              problem: p['problem']!,
              solution: p['solution']!,
              isMobile: isMobile,
            )),
      ],
    );
  }
}

final List<Map<String, String>> _sellerProblems = [
  {
    'problem': 'Limited customer reach',
    'solution':
        'List your items once and reach thousands of active buyers across the region instantly.',
  },
  {
    'problem': 'Marketing difficulties',
    'solution':
        'No advertising skills needed. Our platform promotes your listings automatically to interested buyers.',
  },
  {
    'problem': 'Slow sales',
    'solution':
        'Smart pricing suggestions and visibility boosts help your items sell faster than traditional channels.',
  },
];

class _SellerProblemSolutionItem extends StatelessWidget {
  final String problem;
  final String solution;
  final bool isMobile;

  const _SellerProblemSolutionItem({
    required this.problem,
    required this.solution,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 4),
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.accent.withAlpha(30),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.trending_up,
              color: AppColors.accentDark,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  problem,
                  style: AppTextStyles.titleMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.earthBrown,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  solution,
                  style: AppTextStyles.bodyLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
