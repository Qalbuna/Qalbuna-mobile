import 'package:flutter/widgets.dart';
import 'package:qalbuna_app/app/shared/theme/index.dart';

class ListOnboarding extends StatelessWidget {
  final String? image;
  final String? title;
  final String? description;
  const ListOnboarding({super.key, this.image, this.title, this.description});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: constraints.maxHeight * 0.5,
              child: Image.asset(image!, fit: BoxFit.contain),
            ),
            SizedBox(height: 32),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title!,
                  style: AppTypography.h4Bold,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 12),
                Text(
                  description!,
                  style: AppTypography.sRegular,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
