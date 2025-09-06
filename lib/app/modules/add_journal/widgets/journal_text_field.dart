import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      children: [
        TextField(
          controller: controller,
          onChanged: onChanged,
          maxLines: null, // Auto-expand berdasarkan content
          minLines: 6,   // Minimum 6 baris
          keyboardType: TextInputType.multiline,
          textAlignVertical: TextAlignVertical.top,
          decoration: InputDecoration(
            hintText: 'Alhamdulillah, hari ini aku bersyukur karena...',
            hintStyle: AppTypography.sMedium.copyWith(color: Colors.grey[400]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.blue[300]!),
            ),
            contentPadding: const EdgeInsets.all(16),
          ),
          style: AppTypography.sMedium,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GetBuilder<AddJournalController>(
                builder: (addController) => Text(
                  '${addController.characterCount.value}/500 karakter',
                  style: AppTypography.sRegular.copyWith(color: Colors.grey[600]),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.photo_camera, color: Colors.grey[400], size: 20),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.sentiment_satisfied, color: Colors.grey[400], size: 20),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}