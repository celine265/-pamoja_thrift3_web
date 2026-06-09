import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class NavBar extends StatefulWidget {
  final ScrollController scrollController;
  final String activeSection;
  final void Function(String) onNavigate;

  const NavBar({
    super.key,
    required this.scrollController,
    required this.activeSection,
    required this.onNavigate,
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
                _MobileMenuButton(onNavigate: widget.onNavigate, activeSection: widget.activeSection)
              else
                _DesktopNav(
                  activeSection: widget.activeSection,
                  onNavigate: widget.onNavigate,
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
  final void Function(String) onNavigate;

  const _DesktopNav({
    required this.activeSection,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...AppConstants.navItems.map((item) {
          final isActive = activeSection == item['sectionId'];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: _NavLink(
              label: item['label']!,
              isActive: isActive,
              onTap: () => onNavigate(item['sectionId']!),
            ),
          );
        }),
        const SizedBox(width: 12),
        _DownloadButton(onTap: () => onNavigate('download')),
      ],
    );
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavLink({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final effectiveColor =
        _isHovered || widget.isActive ? AppColors.primary : AppColors.textPrimary;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: widget.isActive
                ? AppColors.primary.withAlpha(25)
                : (_isHovered ? AppColors.primary.withAlpha(10) : Colors.transparent),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            widget.label,
            style: AppTextStyles.navLink.copyWith(
              color: effectiveColor,
              fontWeight: widget.isActive ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      ),
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
            color: _isHovered ? AppColors.primaryLight : AppColors.primary,
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

// --- Mobile Overlay Menu ---

class _MobileMenuButton extends StatelessWidget {
  final void Function(String) onNavigate;
  final String activeSection;

  const _MobileMenuButton({required this.onNavigate, required this.activeSection});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.menu, color: AppColors.textPrimary),
      onPressed: () => _MobileOverlayMenu.show(context, onNavigate, activeSection),
    );
  }
}

class _MobileOverlayMenu extends StatefulWidget {
  final void Function(String) onNavigate;
  final String activeSection;

  const _MobileOverlayMenu({required this.onNavigate, required this.activeSection});

  static Future<void> show(BuildContext context, void Function(String) onNavigate, String activeSection) async {
    final sectionId = await Navigator.of(context).push<String>(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return _MobileOverlayMenu(onNavigate: onNavigate, activeSection: activeSection);
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut,
              )),
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
        reverseTransitionDuration: const Duration(milliseconds: 250),
        barrierDismissible: true,
        barrierColor: Colors.black.withAlpha(100),
      ),
    );
    if (sectionId != null) {
      onNavigate(sectionId);
    }
  }

  @override
  State<_MobileOverlayMenu> createState() => _MobileOverlayMenuState();
}

class _MobileOverlayMenuState extends State<_MobileOverlayMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar with logo + close
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 8, 0),
              child: Row(
                children: [
                  const Spacer(),
                  _Logo(),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close, color: AppColors.primary, size: 32),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            // Menu items — vertically centered
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ...AppConstants.navItems.map((item) => _MobileMenuItem(
                            label: item['label']!,
                            isActive: widget.activeSection == item['sectionId'],
                            onTap: () => Navigator.of(context).pop(item['sectionId']!),
                          )),
                    ],
                  ),
                ),
              ),
            ),
            // Download APK button at bottom
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop('download'),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.accent.withAlpha(60),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
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
            ),
          ],
        ),
      ),
    );
  }
}

class _MobileMenuItem extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _MobileMenuItem({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_MobileMenuItem> createState() => _MobileMenuItemState();
}

class _MobileMenuItemState extends State<_MobileMenuItem> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final textColor = widget.isActive ? AppColors.primary : AppColors.textPrimary;
    final fontWeight = widget.isActive ? FontWeight.w700 : FontWeight.w600;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: GestureDetector(
        onTap: widget.onTap,
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: _isPressed
                ? AppColors.primary.withAlpha(10)
                : (widget.isActive ? AppColors.primary.withAlpha(15) : Colors.transparent),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.isActive)
                Container(
                  width: 4,
                  height: 20,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              Text(
                widget.label,
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto().copyWith(
                  fontSize: 22,
                  fontWeight: fontWeight,
                  color: textColor,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}