import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:qalbuna_app/app/shared/theme/index.dart';
import '../../../data/models/prophet_story.dart';
import '../../../shared/widgets/shimmer_placeholder.dart';
import '../controllers/home_controller.dart';
import 'card_decoration.dart';

class ProphetStoryWidget extends GetView<HomeController> {
  const ProphetStoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: CardDecoration.primary(),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          if (controller.isVideoLoading.value ||
              controller.currentProphetStory.value == null) {
            return _buildLoading();
          }

          return _buildContent(controller.currentProphetStory.value!);
        }),
      ),
    );
  }

  Widget _buildLoading() {
    return Column(
      children: [
        _buildHeader(),
        const SizedBox(height: 16),
        const ShimmerPlaceholder(),
      ],
    );
  }

  Widget _buildContent(ProphetStory story) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        const SizedBox(height: 16),
        _buildVideoPlayer(story),
        const SizedBox(height: 12),
        _buildStoryInfo(story),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Icon(Icons.video_collection, color: AppColors.v1Primary500, size: 18),
        const SizedBox(width: 8),
        Text(
          'Pelukan Kisah untuk Perasaanmu',
          style: AppTypography.sSemiBold.copyWith(
            color: AppColors.v1Primary500,
          ),
        ),
      ],
    );
  }

  Widget _buildVideoPlayer(ProphetStory story) {
    if (controller.youtubeController == null ||
        controller.currentVideoId.value != story.youtubeId) {
      controller.initializeVideoPlayer(story.youtubeId);
    }

    if (controller.youtubeController == null) {
      return _buildVideoError();
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: YoutubePlayer(
        controller: controller.youtubeController!,
        showVideoProgressIndicator: true,
        progressIndicatorColor: AppColors.v1Primary500,
        progressColors: ProgressBarColors(
          playedColor: AppColors.v1Primary500,
          handleColor: AppColors.v1Primary600,
        ),
        aspectRatio: 16 / 9,
        onReady: () {
          controller.onVideoReady(story.id);
        },
        onEnded: (metaData) {
          controller.onVideoEnded();
        },
      ),
    );
  }

  Widget _buildVideoError() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: AppColors.v1Gray100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: AppColors.v1Gray400),
            const SizedBox(height: 12),
            Text(
              'Video tidak dapat dimuat',
              style: AppTypography.sMedium.copyWith(
                color: AppColors.v1Neutral600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStoryInfo(ProphetStory story) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          story.title,
          style: AppTypography.mSemiBold.copyWith(
            color: AppColors.black,
          ),
        ),
      ],
    );
  }
}

