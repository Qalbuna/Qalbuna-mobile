import 'package:flutter/material.dart';
import 'package:qalbuna_app/app/shared/theme/index.dart';
import '../../../data/models/challenge_day_status.dart';
import 'challange_day_status_badge.dart';
import 'challenge_day_icon.dart';

class ChallengeDayCard extends StatelessWidget {
  final ChallengeDay challengeDay;
  final VoidCallback? onTap;

  const ChallengeDayCard({super.key, required this.challengeDay, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: challengeDay.status != ChallengeDayStatus.locked ? onTap : null,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _getCardBorderColor(), width: 1.5),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ChallengeDayIcon(
                status: challengeDay.status,
                dayNumber: challengeDay.dayNumber,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Hari ${challengeDay.dayNumber}',
                          style: AppTypography.lMedium.copyWith(
                            color: _getTitleColor(),
                          ),
                        ),
                        if (challengeDay.status !=
                            ChallengeDayStatus.active) ...[
                          const SizedBox(width: 16),
                          ChallengeDayStatusBadge(
                            status: challengeDay.status,
                            completedDate: challengeDay.completedDate,
                            challengeDay: challengeDay,
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      challengeDay.description,
                      style: AppTypography.sRegular.copyWith(
                        color: _getDescriptionColor(),
                        height: 1.4,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    if (challengeDay.status == ChallengeDayStatus.active) ...[
                      const SizedBox(height: 8),
                      ChallengeDayStatusBadge(
                        status: challengeDay.status,
                        completedDate: challengeDay.completedDate,
                        challengeDay: challengeDay,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getCardBorderColor() {
    switch (challengeDay.status) {
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

  Color _getTitleColor() {
    switch (challengeDay.status) {
      case ChallengeDayStatus.completed:
      case ChallengeDayStatus.active:
        return Colors.black87;
      case ChallengeDayStatus.locked:
        return AppColors.v1Gray300;
      case ChallengeDayStatus.pass:
        return AppColors.v1Gray300;
    }
  }

  Color _getDescriptionColor() {
    switch (challengeDay.status) {
      case ChallengeDayStatus.completed:
      case ChallengeDayStatus.active:
        return Colors.black54;
      case ChallengeDayStatus.locked:
        return AppColors.v1Gray300;
      case ChallengeDayStatus.pass:
        return AppColors.v1Gray300;
    }
  }
}
