import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talktsy/config/app_colors.dart';
import 'package:talktsy/widgets/text_widget.dart';

class SubmitButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final double containerHeight;

  const SubmitButtonWidget(
      {super.key,
      required this.onPressed,
      required this.text,
      this.backgroundColor = AppColors.greenColor,
      this.textStyle,
      this.containerHeight = 40});

  @override
  Widget build(BuildContext context) {
    TextStyle defaultTextStyle = DefaultTextStyle.of(context).style.copyWith(
          fontSize: 15.sp,
          color: AppColors.whiteColor,
        );

    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        height: containerHeight.h,
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.all(
              Radius.circular(10.r),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.greenColor.withOpacity(0.35),
                spreadRadius: 3,
                blurRadius: 10,
                offset: Offset(0, 3),
              )
            ]),
        child: Center(
          child: TextWidget(
            text: text,
            textStyle: defaultTextStyle.merge(textStyle),
          ),
        ),
      ),
    );
  }
}
