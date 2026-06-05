import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../widgets/section_wrapper.dart';

class ProblemSolutionSection extends StatelessWidget {
  const ProblemSolutionSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return SectionWrapper(
      child: Column(
        children: [
          Text(
            'From Market Frustrations to Smart Shopping',
            style: isMobile
                ? AppTextStyles.displaySmall
                : AppTextStyles.displayMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            'We understand the challenges of thrift shopping and selling. Here\'s how we solve them.',
            style: AppTextStyles.bodyLarge.copyWith(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          ResponsiveRowColumn(
            layout: isMobile
                ? ResponsiveRowColumnType.COLUMN
                : ResponsiveRowColumnType.ROW,
            rowSpacing: 24,
            columnSpacing: 32,
            children: [
              ResponsiveRowColumnItem(
                rowFlex: 1,
                child: _RoleCard(
                  title: 'For Buyers',
                  color: AppColors.primary,
                  challenges: const [
                    'Spending hours digging through clothing',
                    'Difficulty finding the right size, style, or color',
                    'Transportation costs to and from markets',
                    'Rainy weather disrupting shopping plans',
                    'Leaving the market without finding the desired item',
                  ],
                  solutions: const [
                    'Search for products directly from your phone',
                    'Browse available items before travelling',
                    'Save time and transportation costs',
                    'Shop comfortably regardless of weather',
                    'Find desired products faster and more conveniently',
                  ],
                ),
              ),
              ResponsiveRowColumnItem(
                rowFlex: 1,
                child: _RoleCard(
                  title: 'For Sellers',
                  color: AppColors.accentDark,
                  challenges: const [
                    'Not knowing every item available inside a bale',
                    'Customers becoming frustrated while searching',
                    'Buyers leaving without making purchases',
                    'Reduced customer traffic during rainy seasons',
                    'Dependence on physical market visitors',
                  ],
                  solutions: const [
                    'Showcase products online',
                    'Increase product visibility',
                    'Reach more buyers beyond physical markets',
                    'Continue receiving inquiries during all seasons',
                    'Generate more sales opportunities',
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final String title;
  final Color color;
  final List<String> challenges;
  final List<String> solutions;

  const _RoleCard({
    required this.title,
    required this.color,
    required this.challenges,
    required this.solutions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(12),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 28),
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Text(
              title,
              style: AppTextStyles.headlineMedium.copyWith(
                color: color,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Label(text: 'The Challenge', icon: Icons.close, color: Colors.redAccent),
                const SizedBox(height: 12),
                ...challenges.map((c) => _ListItem(
                      text: c,
                      icon: Icons.close,
                      iconColor: Colors.redAccent,
                    )),
                const SizedBox(height: 24),
                _Label(text: 'How Pamoja Thrift Helps', icon: Icons.check_circle, color: AppColors.primary),
                const SizedBox(height: 12),
                ...solutions.map((s) => _ListItem(
                      text: s,
                      icon: Icons.check_circle,
                      iconColor: AppColors.primary,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Label extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;

  const _Label({
    required this.text,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color, size: 22),
        const SizedBox(width: 10),
        Text(
          text,
          style: AppTextStyles.titleMedium.copyWith(
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }
}

class _ListItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color iconColor;

  const _ListItem({
    required this.text,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.bodyLarge.copyWith(height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}
