import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talktsy/config/app_colors.dart';
import 'package:talktsy/widgets/text_widget.dart';

class BorderButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final TextStyle? textStyle;

  const BorderButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle defaultTextStyle = DefaultTextStyle.of(context).style.copyWith(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.greyTextColor
        );

    return SizedBox(
      height: 48.h,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
            side: BorderSide(color: AppColors.greyTextColor, width: 1.0.h),
            // Border color and width
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13.h), // Border radius
            ),
            padding: EdgeInsets.zero),
        child: Row(children: [
          SizedBox(
              width: 45.h,
              child: Icon(
                size: 15.h,
                Icons.language,
                color: AppColors.greyTextColor,
              )),
          Expanded(
              child: TextWidget(
                  text: text, textStyle: defaultTextStyle.merge(textStyle))),
          SizedBox(
              width: 45.h,
              child: Icon(
                  size: 15.h,
                  Icons.keyboard_arrow_down,
                  color: AppColors.blueTextColor)),
        ]),
      ),
    );
  }
}

class CustomButtonStyles {
  static const TextStyle textStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
  );
}
