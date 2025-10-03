import 'package:flutter/material.dart';
import '../../../shared/constant/uidata.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_typography.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifikasi',
          style: AppTypography.h5SemiBold.copyWith(color: Colors.black),
        ),
        backgroundColor: AppColors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        toolbarHeight: 80,
      ),
      body: Container(
        height: 360,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: NetworkImage(notiftext),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
