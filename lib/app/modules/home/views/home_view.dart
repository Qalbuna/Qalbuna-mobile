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
      backgroundColor: AppColors.v1CoolGray50,
      appBar: AppBar(
        backgroundColor: AppColors.v1Primary500,
        elevation: 0,
        automaticallyImplyLeading: false,
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
              // Header dengan greeting
              const GreetingHeaderWidget(),
              
              const SizedBox(height: 16),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Mood Status Card
                    Obx(() => MoodStatusWidget(
                      moodData: controller.currentMoodData.value,
                    )),
                    
                    const SizedBox(height: 24),
                    
                    // Section Title
                    Text(
                      'Pelukan khusus Untukmu',
                      style: AppTypography.h5Bold.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Verse Recommendation
                    const VerseRecommendationWidget(),
                    
                    const SizedBox(height: 24),
                    
                    // Inspirational Story Section
                    Text(
                      'Kisah Inspiratif',
                      style: AppTypography.h5Bold.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    const InspirationalStoryWidget(),
                    
                    const SizedBox(height: 24),
                    
                    // Dhikr/Amalan Section
                    Text(
                      'Amalan untuk ketenangan',
                      style: AppTypography.h5Bold.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    const DhikrAmalanWidget(),
                    
                    const SizedBox(height: 24),
                    
                    // Prophet Story Section
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