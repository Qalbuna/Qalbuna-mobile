import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qalbuna_app/app/modules/home/widgets/quran_insight_card.dart';
import 'package:qalbuna_app/app/routes/app_pages.dart';
import 'package:qalbuna_app/app/shared/theme/index.dart';
import 'package:qalbuna_app/app/shared/widgets/custom_botton.dart';
import '../controllers/home_controller.dart';
import '../widgets/greeting_header_widget.dart';
import '../widgets/mood_status_widget.dart';
import '../widgets/verse_recommendation_widget.dart';
import '../widgets/inspirational_story_widget.dart';
import '../widgets/dhikr_amalan_widget.dart';
import '../widgets/prophet_story_widget.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.loadTodayMood();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 12),
              const GreetingHeaderWidget(),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const MoodStatusWidget(),
                    const SizedBox(height: 24),
                    Text(
                      'Insight Kehidupan Qur\'ani',
                      style: AppTypography.h5Bold.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const QuranInsightCard(),
                    const SizedBox(height: 24),
                    Text(
                      'Pelukan Qur\'an Untukmu',
                      style: AppTypography.h5Bold.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const VerseRecommendationWidget(),
                    const SizedBox(height: 24),
                    const ProphetStoryWidget(),
                    const SizedBox(height: 24),
                    const InspirationalStoryWidget(),
                    const SizedBox(height: 24),
                    const DhikrAmalanWidget(),
                    const SizedBox(height: 24),
                    CustomBotton(
                      text: '↻ Perbarui perasaan',
                      onTap: () async {
                        await Get.offAllNamed(Routes.moodTracker);
                      },
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
