import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qalbuna_app/app/shared/theme/app_colors.dart';
import 'package:qalbuna_app/app/shared/theme/app_typography.dart';

class CustomBotton extends StatelessWidget {
  final String? text;
  final VoidCallback? onTap;
  const CustomBotton({super.key, this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: Get.width,
          height: 49,
          decoration: BoxDecoration(
            color: AppColors.v1Primary500,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Color(0xFFE1E2FC).withValues(alpha: 0.8),
                offset: Offset(0, 20),
                blurRadius: 40,
                spreadRadius: 0,
              ),
            ],
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            splashColor: Color(0xFFF8F8F8),
            onTap: onTap,
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
