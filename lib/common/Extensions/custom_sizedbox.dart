import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension CustomSizedBoxExt on num {
  SizedBox get cusSW => SizedBox(width: w);
  SizedBox get cusSH => SizedBox(height: h);
}
