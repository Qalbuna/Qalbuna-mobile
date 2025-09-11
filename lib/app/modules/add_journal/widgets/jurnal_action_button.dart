import 'package:flutter/material.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_typography.dart';

class JournalActionButton extends StatelessWidget {
  final String label;
  final String description;
  final VoidCallback? onPressed;
  final bool isOutlined;
  final bool isLoading;

  const JournalActionButton({
    super.key,
    required this.label,
    required this.description,
    required this.onPressed,
    this.isOutlined = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = onPressed != null && !isLoading;

    return SizedBox(
      width: double.infinity,
      height: 72,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isOutlined
              ? Colors.transparent
              : (isEnabled ? AppColors.v1Primary500 : AppColors.v1Gray300),
          foregroundColor: isOutlined
              ? (isEnabled ? AppColors.v1Primary500 : AppColors.v1Gray400)
              : Colors.white,
          side: isOutlined
              ? BorderSide(
                  color: isEnabled ? AppColors.v1Gray300 : AppColors.v1Gray300,
                  width: 1,
                )
              : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: isOutlined ? 0 : (isEnabled ? 2 : 0),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
        child: (isLoading && isOutlined)
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    isOutlined ? AppColors.v1Primary500 : Colors.white,
                  ),
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: AppTypography.lSemiBold.copyWith(
                      color: isOutlined
                          ? (isEnabled ? AppColors.black : AppColors.v1Gray400)
                          : (isEnabled ? Colors.white : AppColors.v1Gray500),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: AppTypography.sRegular.copyWith(
                      color: isOutlined
                          ? (isEnabled
                                ? AppColors.v1Gray500
                                : AppColors.v1Gray400)
                          : (isEnabled ? Colors.white : AppColors.v1Gray500),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
      ),
    );
  }
}
