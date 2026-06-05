import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class NavBar extends StatefulWidget {
  final ScrollController scrollController;
  final String activeSection;

  const NavBar({
    super.key,
    required this.scrollController,
    required this.activeSection,
  });

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundLight.withAlpha(250),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Row(
            children: [
              _Logo(),
              const Spacer(),
              if (isMobile)
                _MobileDrawer(scrollController: widget.scrollController)
              else
                _DesktopNav(
                  activeSection: widget.activeSection,
                  scrollController: widget.scrollController,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.recycling,
            color: Colors.white,
            size: 22,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          AppConstants.logoText,
          style: AppTextStyles.titleLarge.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _DesktopNav extends StatelessWidget {
  final String activeSection;
  final ScrollController scrollController;

  const _DesktopNav({
    required this.activeSection,
    required this.scrollController,
  });

  void _scrollTo(String sectionId) {
    final key = _sectionKeys[sectionId];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: AppConstants.navItems.map((item) {
        final isActive = activeSection == item['sectionId'];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => _scrollTo(item['sectionId']!),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: isActive
                      ? AppColors.primary.withAlpha(25)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  item['label']!,
                  style: AppTextStyles.navLink.copyWith(
                    color: isActive ? AppColors.primary : AppColors.textPrimary,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

final Map<String, GlobalKey> _sectionKeys = {
  'home': GlobalKey(),
  'about': GlobalKey(),
  'download': GlobalKey(),
  'contact': GlobalKey(),
};

class _MobileDrawer extends StatelessWidget {
  final ScrollController scrollController;

  const _MobileDrawer({required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final scaffold = Scaffold.maybeOf(context);
        return IconButton(
          icon: const Icon(Icons.menu, color: AppColors.textPrimary),
          onPressed: () {
            scaffold?.openEndDrawer();
          },
        );
      },
    );
  }
}

class MobileDrawer extends StatelessWidget {
  final void Function(String) onNavTap;

  const MobileDrawer({super.key, required this.onNavTap});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.primary,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Logo(),
              const SizedBox(height: 48),
              ...AppConstants.navItems.map(
                (item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: GestureDetector(
                    onTap: () {
                      onNavTap(item['sectionId']!);
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      item['label']!,
                      style: AppTextStyles.titleLarge.copyWith(
                        color: AppColors.textOnPrimary,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
