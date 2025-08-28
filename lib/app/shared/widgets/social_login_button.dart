import 'package:flutter/material.dart';
import 'package:qalbuna_app/app/shared/theme/app_colors.dart';
import 'package:qalbuna_app/app/shared/theme/app_typography.dart';

class SocialLoginButton extends StatelessWidget {
  final String text;
  final Widget icon;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;

  const SocialLoginButton({
    super.key,
    required this.text,
    required this.icon,
    this.onTap,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 52,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: borderColor ?? AppColors.v1Neutral200,
          width: 1,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              const SizedBox(width: 12),
              Text(
                text,
                style: AppTypography.mSemiBold.copyWith(
                  color: textColor ?? AppColors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
