import 'package:flutter/material.dart';
import 'package:qalbuna_app/app/shared/theme/index.dart';

import '../../../data/modules/need_item.dart';

class NeedSelectionWidget extends StatelessWidget {
  final List<String> selectedNeeds;
  final Function(String) onNeedToggled;
  
  const NeedSelectionWidget({
    super.key,
    required this.selectedNeeds,
    required this.onNeedToggled,
  });

  @override
  Widget build(BuildContext context) {
    final List<NeedItem> needs = [
      const NeedItem(icon: '🤲', label: 'Ketenangan', value: 'ketenangan'),
      const NeedItem(icon: '💪', label: 'Kekuatan', value: 'kekuatan'),
      const NeedItem(icon: '🎯', label: 'Arahan', value: 'arahan'),
      const NeedItem(icon: '🥰', label: 'Kasih Sayang', value: 'kasih_sayang'),
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
            'Ceritakan lebih dalam',
            style: AppTypography.h5Bold,
          ),
          SizedBox(height: 12),
          Text(
            'Apa yang sedang kamu butuhkan hari ini?',
            style: AppTypography.sMedium.copyWith(
              color: AppColors.v1Neutral500,
            ),
          ),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: needs.length,
            itemBuilder: (context, index) {
              final need = needs[index];
              final isSelected = selectedNeeds.contains(need.value);
              
              return GestureDetector(
                onTap: () => onNeedToggled(need.value),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.v1Primary50 : AppColors.v1Gray25,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? AppColors.v1Primary500 : AppColors.v1Gray200,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        need.icon,
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          need.label,
                          style: AppTypography.sMedium.copyWith(
                            color: isSelected ? AppColors.v1Primary500 : AppColors.black,
                          ),
                        ),
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