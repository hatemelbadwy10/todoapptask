import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/styles.dart';
class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisSize:MainAxisSize.min,
      children: [
        Container(
          width: 30.w,
          height: 40.h,
          decoration:   const BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              Icons.check,
              size: 20.r,
              color: Colors.white,
            ),
          ),

        ),
        SizedBox(width: 10.w,),
        Text('Todo App',
          style: Styles.textStyle20,
        ),
      ],
    );
  }
}
