import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qalbuna_app/app/shared/theme/app_colors.dart';
import 'package:qalbuna_app/app/shared/theme/app_typography.dart';

class CustomBotton extends StatelessWidget {
  final String? text;
  final VoidCallback? onTap;
  final bool isEnabled;
  const CustomBotton({super.key, this.text, this.onTap, this.isEnabled = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: Get.width,
          height: 52,
          decoration: BoxDecoration(
            color: isEnabled ? AppColors.v1Primary500 : AppColors.v1Neutral100,
            borderRadius: BorderRadius.circular(8),
            boxShadow: isEnabled ? [
              BoxShadow(
                color: Color(0xFFE1E2FC).withValues(alpha: 0.8),
                offset: Offset(0, 20),
                blurRadius: 40,
                spreadRadius: 0,
              ),
            ] : null,
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            splashColor: isEnabled ? Color(0xFFF8F8F8) : Colors.transparent,
            onTap: isEnabled ? onTap : null,
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text!,
                    style: AppTypography.mSemiBold.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
