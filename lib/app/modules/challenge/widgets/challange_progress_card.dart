import 'package:flutter/material.dart';
import 'package:qalbuna_app/app/shared/theme/app_colors.dart';
import '../../../data/models/step_state.dart';
import '../../../shared/theme/app_typography.dart';
import '../utils/challenge_progress_helper.dart';
import 'heart_step_widget.dart';
import 'progress_connector.dart';

class ChallengeProgressCard extends StatelessWidget {
  final int currentDay;
  final int totalDays;
  final List<int> completedDays;
  final List<int> passedDays;

  const ChallengeProgressCard({
    super.key,
    this.currentDay = 0,
    this.totalDays = 7,
    this.completedDays = const [],
    this.passedDays = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 24),
          _buildProgressIndicator(),
          const SizedBox(height: 16),
          _buildLabels(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Text(
          ChallengeProgressHelper.getHeaderTitle(completedDays),
          style: AppTypography.lSemiBold.copyWith(color: AppColors.black),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          'Mulai tantangan Qalbuna hari ini',
          style: AppTypography.sMedium.copyWith(color: AppColors.v1Neutral500),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildProgressIndicator() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildProgressSteps(),
      ),
    );
  }

  List<Widget> _buildProgressSteps() {
    List<Widget> steps = [];

    for (int i = 0; i < totalDays; i++) {
      final dayNumber = i + 1;
      final stepStated = ChallengeProgressHelper.getStepState(
        dayNumber,
        currentDay,
        completedDays,
        passedDays,
      );

      final completedNumber = stepStated == StepStated.completed
          ? ChallengeProgressHelper.getCompletedNumber(dayNumber, completedDays)
          : 0;

      steps.add(
        HeartStepWidget(state: stepStated, completedNumber: completedNumber),
      );

      if (i < totalDays - 1) {
        steps.add(
          ProgressConnector(isCompleted: stepStated == StepStated.completed),
        );
      }
    }

    return steps;
  }

  Widget _buildLabels() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Mulai',
          style: AppTypography.sRegular.copyWith(color: AppColors.v1Neutral600),
        ),
        Text(
          'Selesai',
          style: AppTypography.sRegular.copyWith(color: AppColors.v1Neutral600),
        ),
      ],
    );
  }
}
