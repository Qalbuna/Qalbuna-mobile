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
        SizedBox(height: 100,),
        SizedBox(
          child: Image.network(image!, scale: 0.01, fit: BoxFit.contain),
        ),
        SizedBox(
          height: Get.height * 0.2,
          width: Get.width,
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
