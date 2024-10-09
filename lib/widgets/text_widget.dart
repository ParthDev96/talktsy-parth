import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talktsy/config/app_colors.dart';
import 'package:talktsy/config/app_fonts.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final TextOverflow? overflow;
  final TextAlign? textAlign;

  const TextWidget({
    super.key,
    required this.text,
    this.textStyle,
    this.overflow,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle defaultStyle = DefaultTextStyle.of(context).style.copyWith(
        fontSize: 22.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.blueTextColor,
        fontFamily: AppFonts.hkGrotesk);

    return Text(
      text,
      overflow: overflow,
      textAlign: textAlign,
      style: defaultStyle.merge(textStyle),
    );
  }
}
