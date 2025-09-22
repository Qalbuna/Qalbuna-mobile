import 'package:flutter/material.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_typography.dart';

class ChallengeProgressCard extends StatelessWidget {
  final int currentDay;
  final int totalDays;

  const ChallengeProgressCard({
    super.key,
    this.currentDay = 0,
    this.totalDays = 7,
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
            color: AppColors.v1Gray300,
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
          'Kamu belum memulai tantangan',
          style: AppTypography.lSemiBold.copyWith(color: AppColors.black),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Mulailah tantangan Qalbuna hari ini',
          style: AppTypography.sRegular.copyWith(color: AppColors.v1Gray600),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildProgressIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _buildProgressSteps(),
    );
  }

  List<Widget> _buildProgressSteps() {
    List<Widget> steps = [];
    
    for (int i = 0; i < totalDays; i++) {
      final dayNumber = i + 1;
      final stepState = _getStepState(dayNumber);
      
      steps.add(_buildHeartStep(dayNumber, stepState));
      
      if (i < totalDays - 1) {
        steps.add(_buildConnector(stepState == StepState.completed));
      }
    }
    
    return steps;
  }

  StepState _getStepState(int dayNumber) {
    if (dayNumber <= currentDay) return StepState.completed;
    if (dayNumber == currentDay + 1 && currentDay < totalDays) return StepState.active;
    return StepState.inactive;
  }

  Widget _buildHeartStep(int dayNumber, StepState state) {
    final colors = _getStepColors(state);
    
    return SizedBox(
      width: 44,
      height: 44,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.favorite,
            size: 44,
            color: colors.heartColor,
          ),
          Text(
            dayNumber.toString(),
            style: AppTypography.sRegular.copyWith(
              color: colors.textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConnector(bool isCompleted) {
    return Container(
      width: 16,
      height: 2,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: isCompleted ? AppColors.v1Primary500 : AppColors.v1Gray200,
        borderRadius: BorderRadius.circular(1),
      ),
    );
  }

  Widget _buildLabels() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Mulai',
          style: AppTypography.sRegular.copyWith(color: AppColors.v1Gray600),
        ),
        Text(
          'Selesai',
          style: AppTypography.sRegular.copyWith(color: AppColors.v1Gray600),
        ),
      ],
    );
  }

  StepColors _getStepColors(StepState state) {
    switch (state) {
      case StepState.completed:
        return StepColors(
          heartColor: AppColors.v1Primary500,
          textColor: Colors.white,
        );
      case StepState.active:
        return StepColors(
          heartColor: AppColors.v1Gray200,
          textColor: AppColors.v1Neutral500,
        );
      case StepState.inactive:
        return StepColors(
          heartColor: AppColors.v1Gray200,
          textColor: AppColors.v1Neutral500,
        );
    }
  }
}

enum StepState { completed, active, inactive }

class StepColors {
  final Color heartColor;
  final Color textColor;

  StepColors({
    required this.heartColor,
    required this.textColor,
  });
}