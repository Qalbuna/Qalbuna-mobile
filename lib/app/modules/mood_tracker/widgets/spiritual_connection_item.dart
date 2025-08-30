import 'package:flutter/material.dart';
import 'package:qalbuna_app/app/shared/theme/index.dart';

import '../../../data/modules/connection_item.dart';

class SpiritualConnectionWidget extends StatelessWidget {
  final String selectedConnection;
  final Function(String) onConnectionSelected;
  
  const SpiritualConnectionWidget({
    super.key,
    required this.selectedConnection,
    required this.onConnectionSelected,
  });

  @override
  Widget build(BuildContext context) {
    final List<ConnectionItem> connections = [
      const ConnectionItem(
        icon: '⭐',
        label: 'Merasa dekat dan terhubung',
        value: 'dekat',
      ),
      const ConnectionItem(
        icon: '🌙',
        label: 'Ingin lebih mendekat',
        value: 'ingin_mendekat',
      ),
      const ConnectionItem(
        icon: '⛈️',
        label: 'Merasa jauh dan terputus',
        value: 'jauh',
      ),
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
            'Bagaimana perasaanmu dengan\nAllah hari ini?',
            style: AppTypography.h5Bold,
            textAlign: TextAlign.center
          ),
          const SizedBox(height: 20),
          ...connections.map((connection) {
            final isSelected = selectedConnection == connection.value;
            
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: GestureDetector(
                onTap: () => onConnectionSelected(connection.value),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
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
                        connection.icon,
                        style: TextStyle(fontSize: 24),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          connection.label,
                          style: AppTypography.sMedium.copyWith(
                            color: isSelected ? AppColors.v1Primary500 : AppColors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}