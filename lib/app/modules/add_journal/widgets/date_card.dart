import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qalbuna_app/app/shared/theme/app_colors.dart';
import '../../../shared/theme/app_typography.dart';

class DateCard extends StatelessWidget {
  const DateCard({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final dayName = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'][now.weekday - 1];
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: AppColors.v1Gray300, blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Column(
        children: [
          Text('Hari ini', style: AppTypography.mSemiBold.copyWith(
              color: AppColors.v1Neutral500)),
          SizedBox(height: 8),
          Text('$dayName, ${DateFormat('d MMMM yyyy', 'id').format(now)}',
              style: AppTypography.lBold.copyWith(
                  color: AppColors.black)),
          SizedBox(height: 8),
          Text('${DateFormat('HH:mm').format(now)} WIB',
              style: AppTypography.sMedium.copyWith(
                  color: AppColors.v1Neutral500)),
        ],
      ),
    );
  }
}