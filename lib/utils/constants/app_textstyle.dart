import 'package:codebase_project_assignment/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyles {
  static TextStyle _customTextStyle({
    required double fontSize,
    required FontWeight fontWeight,
  }) {
    BuildContext? context = navigatorKey.currentState?.context;
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: context != null
          ? Theme.of(context).textTheme.displayLarge?.color
          : Colors.black,
    );
  }

  // w400 (Regular)

  static TextStyle font10w400TextStyle({Color? lightColor, Color? darkColor}) {
    return _customTextStyle(
      fontSize: 10.0.sp,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle font12w400TextStyle({Color? lightColor, Color? darkColor}) {
    return _customTextStyle(
      fontSize: 12.0.sp,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle font14w400TextStyle({Color? lightColor, Color? darkColor}) {
    return _customTextStyle(
      fontSize: 14.0.sp,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle font16w400TextStyle({Color? lightColor, Color? darkColor}) {
    return _customTextStyle(
      fontSize: 16.0.sp,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle font18w400TextStyle({Color? lightColor, Color? darkColor}) {
    return _customTextStyle(
      fontSize: 18.0.sp,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle font20w400TextStyle({Color? lightColor, Color? darkColor}) {
    return _customTextStyle(
      fontSize: 20.0.sp,
      fontWeight: FontWeight.w400,
    );
  }

  //w500 (Medium)

  static TextStyle font12w500TextStyle({Color? lightColor, Color? darkColor}) {
    return _customTextStyle(
      fontSize: 12.0.sp,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle font14w500TextStyle({Color? lightColor, Color? darkColor}) {
    return _customTextStyle(
      fontSize: 14.0.sp,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle font16w500TextStyle({Color? lightColor, Color? darkColor}) {
    return _customTextStyle(
      fontSize: 16.0.sp,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle font18w500TextStyle({Color? lightColor, Color? darkColor}) {
    return _customTextStyle(
      fontSize: 18.0.sp,
      fontWeight: FontWeight.w500,
    );
  }
}
