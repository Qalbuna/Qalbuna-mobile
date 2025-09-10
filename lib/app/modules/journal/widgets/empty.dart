import 'package:flutter/material.dart';
import 'package:qalbuna_app/app/shared/constant/uidata.dart';
import 'package:qalbuna_app/app/shared/theme/index.dart';

class Empty extends StatelessWidget {
  const Empty({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(empty, height: 250, width: 250),
            const SizedBox(height: 8.0),
            const Text('Belum ada jurnal', style: AppTypography.h3Bold),
            const SizedBox(height: 12),
            Text(
              'Anda belum memiliki jurnal',
              style: AppTypography.mRegular.copyWith(
                color: AppColors.v1Gray500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
