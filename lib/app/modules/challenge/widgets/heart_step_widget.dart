import 'package:flutter/material.dart';
import 'package:qalbuna_app/app/data/models/step_state.dart';
import '../../../shared/constant/uidata.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_typography.dart';

class HeartStepWidget extends StatelessWidget {
  final StepStated state;
  final int completedNumber;

  const HeartStepWidget({
    super.key,
    required this.state,
    this.completedNumber = 0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 44,
      height: 44,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.network(
            _getHeartAsset(),
            width: 44,
            height: 44,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) =>
                Icon(Icons.favorite, size: 44, color: AppColors.v1Neutral400),
          ),
          if (_shouldShowNumber())
            Text(
              completedNumber.toString(),
              style: AppTypography.sBold.copyWith(color: AppColors.white),
            ),
        ],
      ),
    );
  }

  String _getHeartAsset() {
    switch (state) {
      case StepStated.completed:
        return completed;
      case StepStated.active:
        return active;
      case StepStated.inactive:
        return inactive;
      case StepStated.pass:
        return pass;
    }
  }


  bool _shouldShowNumber() {
    return state == StepStated.completed && completedNumber > 0;
  }
}
