import 'package:flutter/material.dart';
import '../../../data/models/journal_model.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_typography.dart';

class JournalCard extends StatelessWidget {
  final JournalModel journal;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const JournalCard({
    super.key,
    required this.journal,
    this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.v1Gray300,
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: AppColors.v1Primary500,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _formatDate(journal.createdAt ?? DateTime.now()),
                        style: AppTypography.mMedium.copyWith(
                          color: AppColors.v1Gray600,
                        ),
                      ),
                    ],
                  ),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'delete') {
                        onDelete?.call();
                      }
                    },
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem<String>(
                        value: 'delete',
                        child: Text(
                          'Hapus Jurnal',
                          style: AppTypography.mRegular.copyWith(
                            color: AppColors.black,
                          ),
                        ),
                      ),
                    ],
                    icon: Icon(
                      Icons.more_vert,
                      color: AppColors.black,
                      size: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 4,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                journal.title,
                style: AppTypography.lSemiBold.copyWith(color: AppColors.black),
              ),
              const SizedBox(height: 8),
              Text(
                journal.content,
                style: AppTypography.mRegular.copyWith(
                  color: AppColors.v1Gray600,
                  height: 1.5,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              // Mood tag
              if (journal.mood != null && journal.mood!.isNotEmpty) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                
                  decoration: BoxDecoration(
                    color: AppColors.v1Primary100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    journal.mood!,
                    style: AppTypography.sRegular.copyWith(
                      color: AppColors.v1Primary600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${date.day} ${months[date.month]} ${date.year}';
  }
}
