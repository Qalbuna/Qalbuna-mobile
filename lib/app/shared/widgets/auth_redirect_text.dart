import 'package:flutter/material.dart';
import 'package:qalbuna_app/app/shared/theme/app_colors.dart';
import 'package:qalbuna_app/app/shared/theme/app_typography.dart';

class AuthRedirectText extends StatelessWidget {
  final String questionText;
  final String actionText;
  final VoidCallback? onActionTap;

  const AuthRedirectText({
    super.key,
    required this.questionText,
    required this.actionText,
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          questionText,
          style: AppTypography.sRegular.copyWith(color: AppColors.black),
        ),
        const SizedBox(width: 4),
        GestureDetector(
          onTap: onActionTap,
          child: Text(
            actionText,
            style: AppTypography.sBold.copyWith(color: AppColors.v1Primary500),
          ),
        ),
      ],
    );
  }
}
