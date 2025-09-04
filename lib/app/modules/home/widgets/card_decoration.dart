import 'package:flutter/material.dart';
import 'package:qalbuna_app/app/shared/theme/index.dart';

class CardDecoration {
  static BoxDecoration primary() {
    return BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: AppColors.v1Primary100),
      boxShadow: [
        BoxShadow(
          color: AppColors.v1Primary25,
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }
}

