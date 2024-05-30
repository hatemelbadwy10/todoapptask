import 'package:flutter/material.dart';

import '../../../../../core/utils/assets.dart';
class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({super.key, required this.widget});
final Widget widget;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
        image: DecorationImage(
        image: AssetImage(AssetsData.backGround),
    fit: BoxFit.fill
    )
    ),
    child: widget

    );
  }
}
