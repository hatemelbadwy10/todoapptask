import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/styles.dart';
class CustomDrodDownItem extends StatelessWidget {
  const CustomDrodDownItem({
    super.key,
    required this.color,
    required this.text,
    required this.iconData,
    required this.onTap,
  });

  final Color color;
  final String text;
  final IconData iconData;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            iconData,
            size: 16.r,
            color: color,
          ),
          SizedBox(width: 5.w),
          Text(
            text,
            style: Styles.textStyle18.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
