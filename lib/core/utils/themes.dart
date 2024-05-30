// ignore_for_file: unused_import
import 'package:flutter/material.dart';


ThemeData theme(BuildContext context) {
  return ThemeData(
      colorScheme: Theme.of(context).colorScheme.copyWith(

          surfaceVariant: Colors.transparent,
          secondary: Colors.grey,
          primaryContainer: const Color(0xffEBF5E1)
      ),

      textTheme: Theme.of(context).textTheme.apply(
        bodyColor: Colors.black,
        fontFamily: 'Tajawal',
      ),



  );
}
