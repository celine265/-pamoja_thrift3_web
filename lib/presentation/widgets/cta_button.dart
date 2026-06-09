import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class CtaButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isPrimary;
  final bool isOutlined;
  final IconData? icon;

  const CtaButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isPrimary = true,
    this.isOutlined = false,
    this.icon,
  });

  @override
  State<CtaButton> createState() => _CtaButtonState();
}

class _CtaButtonState extends State<CtaButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: widget.isOutlined ? _buildOutlined() : _buildFilled(),
    );
  }

  Widget _buildOutlined() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      transform: _isHovered
          ? (Matrix4.identity()..setTranslationRaw(0, -2, 0))
          : Matrix4.identity(),
      child: OutlinedButton.icon(
        onPressed: widget.onPressed,
        icon: widget.icon != null
            ? Icon(widget.icon, size: 18)
            : const SizedBox.shrink(),
        label: Text(widget.label, style: AppTextStyles.buttonLarge.copyWith(
          color: _isHovered ? AppColors.accent : AppColors.accent,
        )),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.accent,
          side: BorderSide(
            color: _isHovered ? AppColors.accent.withAlpha(180) : AppColors.accent,
            width: 2,
          ),
          backgroundColor: _isHovered ? const Color(0xFFFFF3E8) : Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  Widget _buildFilled() {
    final bgColor = widget.isPrimary ? AppColors.primary : AppColors.accent;
    final hoverBg = widget.isPrimary
        ? AppColors.primaryLight
        : const Color(0xFFE65C00);
    final shadowColor = widget.isPrimary
        ? AppColors.primary.withAlpha(80)
        : AppColors.accent.withAlpha(80);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      transform: _isHovered
          ? (Matrix4.identity()..setTranslationRaw(0, -2, 0))
          : Matrix4.identity(),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: _isHovered
            ? [BoxShadow(color: shadowColor, blurRadius: 12, offset: const Offset(0, 4))]
            : [],
      ),
      child: ElevatedButton.icon(
        onPressed: widget.onPressed,
        icon: widget.icon != null
            ? Icon(widget.icon, size: 18)
            : const SizedBox.shrink(),
        label: Text(widget.label, style: AppTextStyles.buttonLarge.copyWith(color: Colors.white)),
        style: ElevatedButton.styleFrom(
          backgroundColor: _isHovered ? hoverBg : bgColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: _isHovered ? 4 : 2,
          shadowColor: shadowColor,
        ),
      ),
    );
  }
}