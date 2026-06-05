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
  double _scrollOffset = 0;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    setState(() => _scrollOffset = widget.scrollController.offset);
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final shadowOpacity = (_scrollOffset.clamp(0, 100) / 100 * 0.15).toDouble();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((shadowOpacity * 255).round()),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Row(
            children: [
              _Logo(),
              const Spacer(),
              if (isMobile)
                const _MobileDrawer()
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
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/logo/logo 1.png',
            width: 36,
            height: 36,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.recycling, color: Colors.white, size: 22),
              );
            },
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
      ),
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
      children: [
        ...AppConstants.navItems.map((item) {
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
                    borderRadius: BorderRadius.circular(8),
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
        }),
        const SizedBox(width: 12),
        _DownloadButton(onTap: () => _scrollTo('download')),
      ],
    );
  }
}

class _DownloadButton extends StatefulWidget {
  final VoidCallback onTap;

  const _DownloadButton({required this.onTap});

  @override
  State<_DownloadButton> createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<_DownloadButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: _isHovered ? (Matrix4.identity()..setTranslationRaw(0, -2, 0)) : Matrix4.identity(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: _isHovered ? AppColors.primaryDark : AppColors.primary,
            borderRadius: BorderRadius.circular(8),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.primary.withAlpha(80),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.download, color: Colors.white, size: 18),
              const SizedBox(width: 8),
              Text(
                'Download APK',
                style: AppTextStyles.buttonSmall.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final Map<String, GlobalKey> _sectionKeys = {
  'home': GlobalKey(),
  'features': GlobalKey(),
  'how-it-works': GlobalKey(),
  'download': GlobalKey(),
  'contact': GlobalKey(),
};

class _MobileDrawer extends StatelessWidget {
  const _MobileDrawer();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.menu, color: AppColors.textPrimary),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const _FullScreenMenu(),
            fullscreenDialog: true,
          ),
        );
      },
    );
  }
}

class _FullScreenMenu extends StatelessWidget {
  const _FullScreenMenu();

  void _scrollTo(String sectionId, BuildContext context) {
    final key = _sectionKeys[sectionId];
    Navigator.of(context).pop();
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
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _Logo(),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white, size: 28),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 60),
              ...AppConstants.navItems.map(
                (item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: GestureDetector(
                    onTap: () => _scrollTo(item['sectionId']!, context),
                    child: Text(
                      item['label']!,
                      style: AppTextStyles.displaySmall.copyWith(
                        color: AppColors.textOnPrimary,
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => _scrollTo('download', context),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(30),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.download, color: Colors.white, size: 22),
                      const SizedBox(width: 10),
                      Text(
                        'Download APK',
                        style: AppTextStyles.buttonLarge.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
