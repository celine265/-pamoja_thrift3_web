import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../widgets/section_wrapper.dart';

class BuyerProblemsSection extends StatelessWidget {
  const BuyerProblemsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return SectionWrapper(
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
            child: _ProblemImage(
              isMobile: isMobile,
              icon: Icons.person_search_outlined,
              label: 'Buyer Challenges',
            ),
          ),
          ResponsiveRowColumnItem(
            rowFlex: 1,
            child: _BuyerContent(isMobile: isMobile),
          ),
        ],
      ),
    );
  }
}

class _ProblemImage extends StatelessWidget {
  final bool isMobile;
  final IconData icon;
  final String label;

  const _ProblemImage({
    required this.isMobile,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: isMobile ? double.infinity : 480,
        height: isMobile ? 280 : 360,
        decoration: BoxDecoration(
          color: AppColors.primary.withAlpha(15),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 80, color: AppColors.primary.withAlpha(100)),
            const SizedBox(height: 16),
            Text(
              label,
              style: AppTextStyles.headlineMedium.copyWith(
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BuyerContent extends StatelessWidget {
  final bool isMobile;

  const _BuyerContent({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          'Problems We Solve for Buyers',
          style: isMobile
              ? AppTextStyles.displaySmall
              : AppTextStyles.displayMedium,
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
        ),
        const SizedBox(height: 24),
        ..._buyerProblems.map((p) => _ProblemSolutionItem(
              problem: p['problem']!,
              solution: p['solution']!,
              isMobile: isMobile,
            )),
      ],
    );
  }
}

final List<Map<String, String>> _buyerProblems = [
  {
    'problem': 'Finding affordable products',
    'solution':
        'Access thousands of quality pre-owned items at prices up to 70% less than retail.',
  },
  {
    'problem': 'Limited variety',
    'solution':
        'Browse a diverse catalog spanning fashion, electronics, furniture, books, and more — updated daily.',
  },
  {
    'problem': 'Lack of trusted sellers',
    'solution':
        'Every seller is verified with ratings and reviews so you can shop with confidence.',
  },
];

class _ProblemSolutionItem extends StatelessWidget {
  final String problem;
  final String solution;
  final bool isMobile;

  const _ProblemSolutionItem({
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
              color: AppColors.primary.withAlpha(25),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.check_circle_outline,
              color: AppColors.primary,
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
