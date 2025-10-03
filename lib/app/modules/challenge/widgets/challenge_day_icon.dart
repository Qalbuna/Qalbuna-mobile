import 'package:flutter/material.dart';
import 'package:qalbuna_app/app/shared/theme/app_typography.dart';
import '../../../data/models/challenge_day_status.dart';
import '../../../shared/theme/app_colors.dart';

class ChallengeDayIcon extends StatelessWidget {
  final ChallengeDayStatus status;
  final int dayNumber;

  const ChallengeDayIcon({
    super.key,
    required this.status,
    required this.dayNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        color: _getIconBackgroundColor(),
        shape: BoxShape.circle,
      ),
      child: Center(child: _buildIconContent()),
    );
  }

  Widget _buildIconContent() {
    switch (status) {
      case ChallengeDayStatus.completed:
      case ChallengeDayStatus.active:
        return const Icon(Icons.check, color: Colors.white, size: 24);
      case ChallengeDayStatus.locked:
        return Text(
          dayNumber.toString(),
          style: AppTypography.mSemiBold.copyWith(
            color: AppColors.v1Neutral500,
          ),
        );
      case ChallengeDayStatus.pass:
        return const Icon(Icons.close_rounded, color: AppColors.v1Neutral500, size: 24);
    }
  }

  Color _getIconBackgroundColor() {
    switch (status) {
      case ChallengeDayStatus.completed:
        return AppColors.v1Cyan500;
      case ChallengeDayStatus.active:
        return AppColors.v1Primary500;
      case ChallengeDayStatus.locked:
        return AppColors.v1Neutral25;
      case ChallengeDayStatus.pass:
        return AppColors.v1Neutral25;
    }
  }
}
