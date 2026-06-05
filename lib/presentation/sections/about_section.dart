import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../widgets/section_heading.dart';
import '../widgets/section_wrapper.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return Container(
      color: AppColors.surfaceLight,
      child: SectionWrapper(
        child: Column(
          children: [
            const SectionHeading(
              title: 'About Pamoja Thrift',
              subtitle: 'Building a sustainable community through thrift',
            ),
            const SizedBox(height: 48),
            ResponsiveRowColumn(
              layout: isMobile
                  ? ResponsiveRowColumnType.COLUMN
                  : ResponsiveRowColumnType.ROW,
              rowSpacing: 24,
              columnSpacing: 24,
              rowMainAxisAlignment: MainAxisAlignment.center,
              children: [
                ResponsiveRowColumnItem(
                  rowFlex: 1,
                  child: _AboutCard(
                    icon: Icons.track_changes,
                    title: 'Our Mission',
                    description:
                        'To create a trusted, accessible marketplace that makes'
                        ' second-hand shopping easy, affordable, and sustainable'
                        ' for everyone in the community.',
                  ),
                ),
                ResponsiveRowColumnItem(
                  rowFlex: 1,
                  child: _AboutCard(
                    icon: Icons.visibility,
                    title: 'Our Vision',
                    description:
                        'A world where thrift is the first choice — reducing'
                        ' waste, supporting local economies, and making quality'
                        ' products available to all.',
                  ),
                ),
                ResponsiveRowColumnItem(
                  rowFlex: 1,
                  child: _AboutCard(
                    icon: Icons.people_outline,
                    title: 'Community Impact',
                    description:
                        'Every transaction on Pamoja Thrift strengthens local'
                        ' communities, reduces environmental footprint, and'
                        ' promotes a circular economy.',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            _WhyThrift(isMobile: isMobile),
          ],
        ),
      ),
    );
  }
}

class _AboutCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _AboutCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withAlpha(25),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppColors.primary, size: 28),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: AppTextStyles.headlineMedium,
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: AppTextStyles.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}

class _WhyThrift extends StatelessWidget {
  final bool isMobile;

  const _WhyThrift({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final benefits = [
      ('Savings', 'Save up to 70% on quality products', Icons.monetization_on_outlined),
      ('Sustainability', 'Reduce waste and help the planet', Icons.eco_outlined),
      ('Community', 'Support local sellers and buyers', Icons.group_outlined),
      ('Variety', 'Discover unique items every day', Icons.diversity_3_outlined),
    ];

    return Column(
      children: [
        Text(
          'Benefits of Second-Hand Marketplaces',
          style: AppTextStyles.displaySmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        Wrap(
          spacing: 20,
          runSpacing: 20,
          alignment: WrapAlignment.center,
          children: benefits.map((b) {
            return SizedBox(
              width: isMobile ? double.infinity : 240,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.accent.withAlpha(30),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(b.$3, color: AppColors.accentDark, size: 24),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          b.$1,
                          style: AppTextStyles.titleMedium,
                        ),
                        Text(
                          b.$2,
                          style: AppTextStyles.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
