import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qalbuna_app/app/shared/theme/index.dart';
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
      body: RefreshIndicator(
        onRefresh: () async {
          controller.loadTodayMood();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 32),
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
                      'Pelukan khusus Untukmu',
                      style: AppTypography.h5Bold.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const VerseRecommendationWidget(),
                    const SizedBox(height: 24),
                    Text(
                      'Kisah Inspiratif',
                      style: AppTypography.h5Bold.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const InspirationalStoryWidget(),
                    const SizedBox(height: 24),
                    Text(
                      'Amalan untuk ketenangan',
                      style: AppTypography.h5Bold.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const DhikrAmalanWidget(),
                    const SizedBox(height: 24),
                    Text(
                      'Kisah Rasul dan Sahabat',
                      style: AppTypography.h5Bold.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const ProphetStoryWidget(),
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