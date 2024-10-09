import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talktsy/config/app_colors.dart';
import 'package:talktsy/config/app_fonts.dart';
import 'package:talktsy/widgets/text_widget.dart';

class TabHeaderWidget extends StatefulWidget implements PreferredSizeWidget {
  final String titleText;
  final String subTitleText;
  final String subTitleCountText;
  final double titleSpacing;
  final VoidCallback? onBackButtonPressed;
  final List<Widget> actions;
  final EdgeInsetsGeometry mainContainerPadding;

  const TabHeaderWidget(
      {super.key,
      required this.titleText,
      this.titleSpacing = 0,
      this.subTitleText = '',
      this.subTitleCountText = '',
      this.onBackButtonPressed,
      this.actions = const [],
      this.mainContainerPadding = const EdgeInsets.symmetric(horizontal: 18)});

  @override
  State<StatefulWidget> createState() => TabHeaderWidgetState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class TabHeaderWidgetState extends State<TabHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.mainContainerPadding,
      color: AppColors.whiteColor,
      child: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                  text: widget.titleText,
                  textStyle: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.blackColor,
                  )),
              if (widget.subTitleText != '')
                RichText(
                    text: TextSpan(
                        style: TextStyle(
                            color: AppColors.blueTextColor,
                            fontFamily: AppFonts.hkGrotesk),
                        children: <TextSpan>[
                      if (widget.subTitleCountText != '')
                        TextSpan(
                            text: '${widget.subTitleCountText} ',
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.greyTextColor,
                            )),
                      TextSpan(
                        text: widget.subTitleText,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.greyTextColor,
                        ),
                      ),
                    ])),
            ],
          ),
          leading: widget.onBackButtonPressed != null
              ? IconButton(
                  icon: Icon(Icons.arrow_back, size: 20.w),
                  onPressed: widget.onBackButtonPressed,
                )
              : null,
          automaticallyImplyLeading: false,
          titleSpacing: widget.titleSpacing,
          actions: widget.actions,
          backgroundColor: AppColors.whiteColor,
          surfaceTintColor: AppColors.whiteColor,
          centerTitle: false),
    );
  }
}

class TabHeaderWidgetStyle {
  static TextStyle headerTitle = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.blackColor,
  );
}
