import 'package:final_year_project/utils/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

InputDecoration inputDecorationForTextField({
  required IconData? prefixIcon,
  Widget? suffixIcon,
  required String hintText,
}) {
  return InputDecoration(
      border: InputBorder.none,
      prefixIcon: Icon(
        prefixIcon,
        size: kIsWeb ? 17 : 17.sp,
      ),
      suffixIcon: suffixIcon,
      hintText: hintText,
      hintStyle: TextStyle(
        fontSize: kIsWeb ? 14 : 14.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.lightGreyColor,
      ));
}

ShapeDecoration containerShapeDecorationForTextField() {
  return ShapeDecoration(
    color: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.r),
    ),
    shadows: [
      BoxShadow(
        color: const Color(0x0F000000),
        blurRadius: 12.r,
        offset: const Offset(0, 6),
      )
    ],
  );
}
