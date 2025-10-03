import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../shared/constant/uidata.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_typography.dart';
import '../controllers/account_controller.dart';

class AccountView extends GetView<AccountController> {
  const AccountView({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppColors.v1Primary500,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.network(profile, height: 55, width: 55),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Text(
                    controller.userName.value,
                    style: AppTypography.h5SemiBold.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Perjalanan Iman Level: Ingin Tahu',
                  style: AppTypography.sMedium.copyWith(color: AppColors.white),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: AppColors.v1Primary500,
        toolbarHeight: 80,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Container(
              height: 230,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(rute),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              height: 500,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(calender),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 320,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(statistik),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 240,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(ayatfav),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
