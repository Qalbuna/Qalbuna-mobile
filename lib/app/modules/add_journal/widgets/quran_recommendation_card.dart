import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/challenge_day_status.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_typography.dart';
import '../../challenge/controllers/challenge_controller.dart';
import '../controllers/add_journal_controller.dart';

class QuranRecommendationCard extends GetView<AddJournalController> {
  final Map<String, dynamic>? recommendation;

  const QuranRecommendationCard({super.key, this.recommendation});

  @override
  Widget build(BuildContext context) {
    final defaultRecommendation = {
      'surahName': 'QS. Al-Anbiya\': 87',
      'arabicText':
          'وَذَا النُّوْنِ اِذْ ذَّهَبَ مُغَاضِبًا فَظَنَّ اَنْ لَّنْ نَّقْدِرَ عَلَيْهِ فَنَادٰى فِى الظُّلُمٰتِ اَنْ لَّآ اِلٰهَ اِلَّآ اَنْتَ سُبْحٰنَكَ اِنِّيْ كُنْتُ مِنَ الظّٰلِمِيْنَۚ',
      'translation':
          '"(Ingatlah pula) Zun Nun (Yunus) ketika dia pergi dalam keadaan marah, lalu dia menyangka bahwa Kami tidak akan menyulitkannya. Maka, dia berdoa dalam kegelapan yang berlapis-lapis, \'Tidak ada tuhan selain Engkau. Mahasuci Engkau. Sesungguhnya aku termasuk orang-orang zalim.\'"',
      'reflection':
          'Nabi Yunus berdoa di dalam tiga kegelapan: malam, laut, dan perut ikan. Ketika kamu merasa terjebak dalam kesulitan yang tampak mustahil, ingatlah bahwa doa dengan ketulusan dan mengakui kelemahan diri kepada Allah adalah jalan menuju pertolongan-Nya. Allah mengabulkan doa Nabi Yunus dan menyelamatkannya, dan Dia berjanji melakukan hal yang sama untuk setiap mukmin yang berdoa dengan tulus.',
    };

    final data = recommendation ?? defaultRecommendation;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            offset: const Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.v1Success25,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Icon(
                  Icons.menu_book,
                  color: AppColors.v1Success500,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rekomendasi Ayat Al-Qur\'an',
                      style: AppTypography.lSemiBold.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'untuk menenangkan hati',
                      style: AppTypography.sRegular.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.v1Success25.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.v1Success300, width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  data['surahName'] ?? 'fallback_value',
                  style: AppTypography.lSemiBold.copyWith(
                    color: AppColors.v1Success800,
                  ),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    data['arabicText'] ?? 'fallback_value',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.v1Success800,
                      height: 1.8,
                    ),
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(8),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    data['translation'] ?? 'fallback_value',
                    style: AppTypography.sMedium.copyWith(
                      color: AppColors.black,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.v1Success50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hikmah & Refleksi:',
                        style: AppTypography.mSemiBold.copyWith(
                          color: Colors.green.shade900,
                        ),
                      ),
                      const SizedBox(height: 18),
                      Text(
                        data['reflection'] ?? 'fallback_value',
                        style: AppTypography.sMedium.copyWith(
                          color: Colors.green.shade900,
                          height: 1.4,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.play_circle, size: 20),
                  label: Text(
                    'Dengar Audio',
                    style: AppTypography.sSemiBold.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.v1Primary500,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                onPressed: () async {
                  await controller.saveJournal();
                  final challengeController = Get.find<ChallengeController>();
                  final activeDay = challengeController.challengeDays
                      .firstWhere(
                        (day) => day.status == ChallengeDayStatus.active,
                      );

                  if (activeDay.dayNumber != 5) {
                    challengeController.completeChallenge(activeDay.dayNumber);
                  }
                },
                icon: Icon(
                  Icons.bookmark,
                  size: 20,
                  color: AppColors.v1Primary500,
                ),
                label: Text(
                  'Simpan',
                  style: AppTypography.sSemiBold.copyWith(
                    color: AppColors.v1Primary500,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.v1Primary500, width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
