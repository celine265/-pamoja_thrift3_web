import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../widgets/cta_button.dart';
import '../widgets/section_wrapper.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback? onDownloadTap;

  const HeroSection({super.key, this.onDownloadTap});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _floatController;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
    _floatAnimation = Tween<double>(begin: -10, end: 10).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isTablet = ResponsiveBreakpoints.of(context).isTablet;

    return Container(
      color: AppColors.backgroundLight,
      child: SectionWrapper(
      topPadding: isMobile ? 40 : 60,
      bottomPadding: isMobile ? 40 : 60,
      child: isMobile
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedBuilder(
                  animation: _floatAnimation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _floatAnimation.value),
                      child: child,
                    );
                  },
                  child: _HeroImage(isMobile: true),
                ),
                const SizedBox(height: 32),
                _buildContent(isMobile: true),
              ],
            )
          : ResponsiveRowColumn(
              rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
              rowCrossAxisAlignment: CrossAxisAlignment.center,
              columnCrossAxisAlignment: CrossAxisAlignment.center,
              layout: isTablet
                  ? ResponsiveRowColumnType.COLUMN
                  : ResponsiveRowColumnType.ROW,
              columnSpacing: 40,
              rowSpacing: 40,
              children: [
                ResponsiveRowColumnItem(
                  rowFlex: 1,
                  child: SizedBox(
                    width: isTablet ? double.infinity : 560,
                    child: _buildContent(isMobile: isTablet),
                  ),
                ),
                ResponsiveRowColumnItem(
                  rowFlex: 1,
                  child: AnimatedBuilder(
                    animation: _floatAnimation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, _floatAnimation.value),
                        child: child,
                      );
                    },
                    child: _HeroImage(isMobile: false),
                  ),
                ),
              ],
            ),
      ),
    );
  }

  Widget _buildContent({required bool isMobile}) {
    return Column(
      crossAxisAlignment: isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(
          'No More Digging Through Bales to Find the Perfect Outfit',
          style: isMobile
              ? AppTextStyles.displaySmall
              : AppTextStyles.displayLarge,
          textAlign:
              isMobile ? TextAlign.center : TextAlign.start,
        ),
        const SizedBox(height: 16),
        Text(
          'Pamoja Thrift helps buyers discover second-hand clothing from the comfort of their homes while helping sellers reach more customers online. Save time, reduce transportation costs, avoid weather-related inconveniences, and find exactly what you need faster.',
          style: AppTextStyles.bodyLarge.copyWith(
            fontSize: isMobile ? 15 : 16,
          ),
          textAlign:
              isMobile ? TextAlign.center : TextAlign.start,
        ),
        const SizedBox(height: 24),
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
              onPressed: widget.onDownloadTap,
            ),
            CtaButton(
              label: 'Learn More',
              isOutlined: true,
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox(height: 28),
        _TrustIndicators(isMobile: isMobile),
      ],
    );
  }
}

class _TrustIndicators extends StatelessWidget {
  final bool isMobile;

  const _TrustIndicators({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final items = [
      'Shop from Anywhere',
      'Save Time and Transport Costs',
      'Connect Directly with Sellers',
      'Discover Affordable Fashion',
    ];

    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: items.map((item) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisSize: isMobile ? MainAxisSize.min : MainAxisSize.max,
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.primary.withAlpha(25),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(
                  Icons.check,
                  color: AppColors.primary,
                  size: 16,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                item,
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _HeroImage extends StatelessWidget {
  final bool isMobile;

  const _HeroImage({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = isMobile
            ? constraints.maxWidth * 0.65
            : (constraints.maxWidth.clamp(280, 350).toDouble());
        return Center(
          child: Container(
            width: size,
            height: size * 1.7,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: Colors.grey.shade300, width: 4),
              boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(30),
                    blurRadius: isMobile ? 20 : 40,
                    offset: isMobile ? const Offset(4, 10) : const Offset(10, 20),
                  ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Column(
                children: [
                  Container(
                    height: 28,
                    color: Colors.grey.shade200,
                    child: Center(
                      child: Container(
                        width: 60,
                        height: 7,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Image.asset(
                      'assets/images/app photo.png',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: AppColors.primary.withAlpha(15),
                          child: Center(
                            child: Icon(
                              Icons.shopping_bag_outlined,
                              size: size * 0.2,
                              color: AppColors.primary.withAlpha(100),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
