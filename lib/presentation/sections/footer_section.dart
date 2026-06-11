import 'dart:html' as html;

import 'package:flutter/material.dart';

import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class FooterSection extends StatelessWidget {
  final void Function(String)? onNavTap;

  const FooterSection({super.key, this.onNavTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.textPrimary,
      padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 24),
      child: Column(
        children: [
          // Logo row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo/logo 1.png',
                width: 32,
                height: 32,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Icon(
                      Icons.recycling,
                      color: Colors.white,
                      size: 18,
                    ),
                  );
                },
              ),
              const SizedBox(width: 10),
              Text(
                AppConstants.logoText,
                style: AppTextStyles.titleLarge.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Nav links
          Wrap(
            spacing: 24,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: AppConstants.navItems.map((item) {
              return _FooterLink(
                label: item['label']!,
                onTap: onNavTap != null
                    ? () => onNavTap!(item['sectionId']!)
                    : null,
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          // Contact
          Text(
            'info@pamojathrift.com  |  +254 700 000 000',
            style: AppTextStyles.bodyMedium.copyWith(
              color: Colors.white.withAlpha(150),
            ),
          ),
          const SizedBox(height: 20),
          Divider(color: Colors.white.withAlpha(40)),
          const SizedBox(height: 16),
          // Copyright
          Text(
            '© 2026 Pamoja Thrift. All rights reserved.',
            textAlign: TextAlign.center,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          // Credit
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                'Designed & Developed by ',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              _CreditLink(
                label: 'Celina Bulyar',
                url: 'https://celine-portfolio-steel.vercel.app',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FooterLink extends StatefulWidget {
  final String label;
  final VoidCallback? onTap;

  const _FooterLink({
    required this.label,
    this.onTap,
  });

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<_FooterLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: AppTextStyles.navLink.copyWith(
            color: _isHovered ? AppColors.accent : const Color(0xFFF8F9FA),
          ),
          child: Text(widget.label),
        ),
      ),
    );
  }
}

class _CreditLink extends StatefulWidget {
  final String label;
  final String url;

  const _CreditLink({
    required this.label,
    required this.url,
  });

  @override
  State<_CreditLink> createState() => _CreditLinkState();
}

class _CreditLinkState extends State<_CreditLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {
          html.AnchorElement(href: widget.url)
            ..target = '_blank'
            ..rel = 'noopener noreferrer'
            ..click();
        },
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: AppTextStyles.caption.copyWith(
            color: _isHovered
                ? AppColors.primaryLight
                : AppColors.primary,
          ),
          child: Text(widget.label),
        ),
      ),
    );
  }
}