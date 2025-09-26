import 'package:flutter/material.dart';

import '../../../data/models/challenge_day_status.dart';
import 'challenge_day_card.dart';

class ChallengeDayList extends StatelessWidget {
  final List<ChallengeDay> challengeDays;
  final Function(ChallengeDay)? onDayTap;

  const ChallengeDayList({super.key, required this.challengeDays, this.onDayTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: challengeDays
          .map((day) => ChallengeDayCard(challengeDay: day, onTap: () => onDayTap?.call(day)))
          .toList(),
    );
  }
}