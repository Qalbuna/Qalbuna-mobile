import 'package:flutter/material.dart';
import 'package:qalbuna_app/app/shared/theme/app_colors.dart';

class ProgressConnector extends StatelessWidget {
  final bool isCompleted;

  const ProgressConnector({super.key, required this.isCompleted});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16,
      height: 3,
      margin: const EdgeInsets.symmetric(horizontal: 1),
      decoration: BoxDecoration(
        color: AppColors.v1Gray300,
        borderRadius: BorderRadius.circular(2.5),
      ),
    );
  }
}
