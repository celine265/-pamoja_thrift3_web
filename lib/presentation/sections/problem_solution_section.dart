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
                  roleColor: AppColors.primary,
                  isMobile: isMobile,
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
                  roleColor: AppColors.accent,
                  isMobile: isMobile,
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
  final Color roleColor;
  final bool isMobile;
  final List<String> challenges;
  final List<String> solutions;

  const _RoleCard({
    required this.title,
    required this.roleColor,
    required this.isMobile,
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
          // Header strip
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: isMobile ? 16 : 20, horizontal: isMobile ? 20 : 28),
            decoration: BoxDecoration(
              color: roleColor.withAlpha(20),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Text(
              title,
              style: (isMobile ? AppTextStyles.titleLarge : AppTextStyles.headlineMedium).copyWith(
                color: roleColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          // Challenge section
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(isMobile ? 16 : 24, isMobile ? 16 : 20, isMobile ? 16 : 24, isMobile ? 12 : 16),
            color: const Color(0xFFFFF5F5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Label(text: 'The Challenge', icon: Icons.close, color: AppColors.error, isMobile: isMobile),
                const SizedBox(height: 10),
                ...challenges.map((c) => _ListItem(
                      text: c,
                      icon: Icons.close,
                      iconColor: AppColors.error,
                      isMobile: isMobile,
                    )),
              ],
            ),
          ),
          // Solution section
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(isMobile ? 16 : 24, isMobile ? 16 : 20, isMobile ? 16 : 24, isMobile ? 16 : 24),
            decoration: const BoxDecoration(
              color: Color(0xFFF0FDF4),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Label(text: 'How Pamoja Thrift Helps', icon: Icons.check_circle, color: AppColors.success, isMobile: isMobile),
                const SizedBox(height: 10),
                ...solutions.map((s) => _ListItem(
                      text: s,
                      icon: Icons.check_circle,
                      iconColor: AppColors.success,
                      isMobile: isMobile,
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
  final bool isMobile;

  const _Label({
    required this.text,
    required this.icon,
    required this.color,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color, size: isMobile ? 18 : 22),
        const SizedBox(width: 8),
        Text(
          text,
          style: (isMobile ? AppTextStyles.bodyLarge : AppTextStyles.titleMedium).copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
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
  final bool isMobile;

  const _ListItem({
    required this.text,
    required this.icon,
    required this.iconColor,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isMobile ? 6 : 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Icon(icon, color: iconColor, size: isMobile ? 16 : 18),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: (isMobile ? AppTextStyles.bodyMedium : AppTextStyles.bodyLarge).copyWith(
                height: 1.4,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}