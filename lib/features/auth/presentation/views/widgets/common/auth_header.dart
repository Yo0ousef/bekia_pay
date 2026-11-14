import 'package:bekia_pay/core/utils/extensions/context_extensions.dart';
import 'package:bekia_pay/core/utils/extensions/num_extensions.dart';
import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  final String title, imagePath, description;

  const AuthHeader({
    super.key,
    required this.title,
    required this.imagePath,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.centerLeft,
      children: [
        double.infinity.hGap,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: theme.textTheme.displayMedium),
            25.vGap,
            SizedBox(
              width: context.screenWidth / 1.5,
              child: Text(description, style: theme.textTheme.displaySmall),
            ),
          ],
        ),
        Positioned(right: 0, top: 0, child: Image.asset(imagePath, width: 100)),
      ],
    );
  }
}
