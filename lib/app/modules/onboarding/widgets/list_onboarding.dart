import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:qalbuna_app/app/shared/theme/index.dart';

class ListOnboarding extends StatelessWidget {
  final String? image;
  final String? title;
  final String? description;
  const ListOnboarding({super.key, this.image, this.title, this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: Get.height * 0.5,
          child: Image.network(image!, scale: 0.01, fit: BoxFit.contain),
        ),
        Container(
          height: Get.height * 0.25,
          width: Get.width,
          padding: EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title!,
                style: AppTypography.h4Bold,
                selectionColor: AppColors.black,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                description!,
                style: AppTypography.sRegular,
                selectionColor: AppColors.black,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
