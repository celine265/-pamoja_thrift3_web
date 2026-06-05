import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../widgets/section_wrapper.dart';

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return Container(
      color: AppColors.surfaceLight,
      child: SectionWrapper(
        child: Column(
          children: [
            Text(
              'Why Choose Pamoja Thrift?',
              style: isMobile
                  ? AppTextStyles.displaySmall
                  : AppTextStyles.displayMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              'Discover a smarter way to thrift with features designed for buyers and sellers.',
              style: AppTextStyles.bodyLarge.copyWith(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Wrap(
              spacing: 24,
              runSpacing: 24,
              alignment: WrapAlignment.center,
              children: [
                SizedBox(
                  width: isMobile ? double.infinity : 260,
                  child: _FeatureCard(
                    icon: Icons.search,
                    title: 'Smart Search',
                    description:
                        'Find specific clothing items without spending hours searching through bales.',
                  ),
                ),
                SizedBox(
                  width: isMobile ? double.infinity : 260,
                  child: _FeatureCard(
                    icon: Icons.home_outlined,
                    title: 'Shop From Home',
                    description:
                        'Browse products from anywhere without travelling to crowded markets.',
                  ),
                ),
                SizedBox(
                  width: isMobile ? double.infinity : 260,
                  child: _FeatureCard(
                    icon: Icons.people_outline,
                    title: 'Direct Seller Access',
                    description:
                        'Connect directly with sellers offering the products you need.',
                  ),
                ),
                SizedBox(
                  width: isMobile ? double.infinity : 260,
                  child: _FeatureCard(
                    icon: Icons.monetization_on_outlined,
                    title: 'Affordable Fashion',
                    description:
                        'Discover quality second-hand clothing at affordable prices.',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  State<_FeatureCard> createState() => _FeatureCardState();
}

class _FeatureCardState extends State<_FeatureCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        transform: _isHovered ? (Matrix4.identity()..setTranslationRaw(0, -6, 0)) : Matrix4.identity(),
        child: Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? AppColors.primary.withAlpha(40)
                    : Colors.black.withAlpha(15),
                blurRadius: _isHovered ? 24 : 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.primary.withAlpha(25),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(widget.icon, color: AppColors.primary, size: 32),
              ),
              const SizedBox(height: 16),
              Text(
                widget.title,
                style: AppTextStyles.titleLarge.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.description,
                style: AppTextStyles.bodyLarge.copyWith(height: 1.6),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
