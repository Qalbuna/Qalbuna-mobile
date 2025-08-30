import 'package:flutter/material.dart';
import 'package:qalbuna_app/app/shared/theme/index.dart';

import '../../../data/modules/mood_item.dart';

class MoodSelectionWidget extends StatelessWidget {
  final String selectedMood;
  final Function(String) onMoodSelected;

  const MoodSelectionWidget({
    super.key,
    required this.selectedMood,
    required this.onMoodSelected,
  });

  @override
  Widget build(BuildContext context) {
    final List<MoodItem> moods = [
      const MoodItem(emoji: '😢', label: 'Sedih', value: 'sedih'),
      const MoodItem(emoji: '😟', label: 'Cemas', value: 'cemas'),
      const MoodItem(emoji: '😔', label: 'Bersalah', value: 'bersalah'),
      const MoodItem(emoji: '😡', label: 'Marah', value: 'marah'),
      const MoodItem(emoji: '😊', label: 'Bahagia', value: 'bahagia'),
      const MoodItem(emoji: '😰', label: 'Takut', value: 'takut'),
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.v1Gray200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 6),
          Text(
            'Bagaimana Perasaanmu hari ini?',
            style: AppTypography.h5Bold,
          ),
          const SizedBox(height: 12),
          Text(
            'Pilih yang paling mewakili hatimu sekarang 💜',
            style: AppTypography.sMedium.copyWith(
              color: AppColors.v1Neutral500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.8,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: moods.length,
            itemBuilder: (context, index) {
              final mood = moods[index];
              final isSelected = selectedMood == mood.value;

              return GestureDetector(
                onTap: () => onMoodSelected(mood.value),
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.v1Primary50
                        : AppColors.v1Gray25,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.v1Primary500
                          : AppColors.v1Gray200,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(mood.emoji, style: TextStyle(fontSize: 40)),
                      const SizedBox(height: 8),
                      Text(
                        mood.label,
                        style: AppTypography.sMedium.copyWith(
                          color: isSelected
                              ? AppColors.v1Primary500
                              : AppColors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
