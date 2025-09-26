import 'package:flutter/material.dart';
import '../../../data/models/challenge_day_status.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_typography.dart';

class ChallengeDayStatusBadge extends StatelessWidget {
  final ChallengeDayStatus status;
  final DateTime? completedDate;

  const ChallengeDayStatusBadge({
    super.key,
    required this.status,
    this.completedDate,
  });

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case ChallengeDayStatus.completed:
        return _buildCompletedBadge();
      case ChallengeDayStatus.active:
        return _buildActiveButton();
      case ChallengeDayStatus.locked:
        return _buildLockedBadge();
      case ChallengeDayStatus.pass:
        return _buildPassBadge();
    }
  }

  Widget _buildCompletedBadge() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.v1Cyan100,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            'Selesai',
            style: AppTypography.sMedium.copyWith(color: AppColors.v1Cyan500),
          ),
        ),
      ],
    );
  }

  Widget _buildActiveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.v1Primary500,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text('Mulai Misi Hari Ini', style: AppTypography.sSemiBold),
      ),
    );
  }

  Widget _buildLockedBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.v1Neutral25,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        'Terkunci',
        style: AppTypography.sMedium.copyWith(color: AppColors.v1Neutral300),
      ),
    );
  }

  Widget _buildPassBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        'Dilewati',
        style: AppTypography.sMedium.copyWith(color: AppColors.v1Orange500),
      ),
    );
  }
}
