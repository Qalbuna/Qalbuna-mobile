import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_typography.dart';
import '../controllers/add_journal_controller.dart';

class JournalTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const JournalTextField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.favorite, color: AppColors.v1Primary500, size: 24),
            const SizedBox(width: 12),
            Text(
              'Bagaimana harimu?',
              style: AppTypography.lSemiBold.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'Tuangkan perasaan dan pikiranmu di sini',
          style: AppTypography.sMedium.copyWith(color: AppColors.v1Neutral500),
        ),
        const SizedBox(height: 12),
        GetBuilder<AddJournalController>(
          builder: (addController) => Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.v1Gray300),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                TextField(
                  controller: addController.titleController,
                  onChanged: addController.onTitleChanged,
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintText: 'Judul',
                    hintStyle: AppTypography.lRegular.copyWith(color: AppColors.v1Gray300),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(16),
                  ),
                  style: AppTypography.h5SemiBold,
                ),
                Container(
                  height: 1,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  color: AppColors.v1Gray300,
                ),
                TextField(
                  controller: controller,
                  onChanged: onChanged,
                  maxLines: null,
                  minLines: 6,
                  keyboardType: TextInputType.multiline,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    hintText: 'Bagaimana harimu hari ini? :)',
                    hintStyle: AppTypography.mRegular.copyWith(color: AppColors.v1Gray300),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(16),
                  ),
                  style: AppTypography.mRegular,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GetBuilder<AddJournalController>(
                builder: (addController) => Text(
                  '${addController.characterCount.value} karakter',
                  style: AppTypography.sRegular.copyWith(
                    color: AppColors.v1Gray500,
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.photo_camera,
                    color: AppColors.v1Gray500,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}