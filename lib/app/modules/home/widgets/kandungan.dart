import 'package:flutter/material.dart';
import '../../../shared/constant/uidata.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_typography.dart';

class Kandungan extends StatelessWidget {
  const Kandungan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kandungan QS. Ar-Ra\'d: 28',
          style: AppTypography.h5SemiBold.copyWith(color: Colors.black),
        ),
        backgroundColor: AppColors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        toolbarHeight: 70,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: 790,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(kandungan),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
