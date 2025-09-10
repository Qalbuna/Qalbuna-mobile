import 'package:flutter/material.dart';
import 'package:qalbuna_app/app/shared/theme/app_colors.dart';
import '../../../shared/theme/app_typography.dart';

class JournalActionButton extends StatelessWidget {
  final String label;
  final String description;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? descriptionColor;
  final bool isOutlined;

  const JournalActionButton({
    super.key,
    required this.label,
    required this.description,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.descriptionColor,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    final defaultBgColor = isOutlined 
        ? Colors.transparent 
        : AppColors.v1Primary500;
    
    final defaultTextColor = isOutlined 
        ? AppColors.black
        : Colors.white;
    
    final defaultDescriptionColor = isOutlined 
        ? AppColors.v1CoolGray600 
        : Colors.white;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor ?? defaultBgColor,
        border: isOutlined
            ? Border.all(color: AppColors.v1Gray300, width: 1.5)
            : null,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: AppTypography.lSemiBold.copyWith(
                    color: textColor ?? defaultTextColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: AppTypography.sRegular.copyWith(
                    color: descriptionColor ?? defaultDescriptionColor
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}