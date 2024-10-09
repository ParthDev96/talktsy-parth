import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talktsy/config/app_colors.dart';
import 'package:talktsy/config/app_fonts.dart';

class TextInputWidget extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final IconData? prefixIcon;
  final String? prefixIconImage;
  final IconData? suffixIcon;
  final double? prefixIconSize;
  final double? suffixIconSize;
  final double? prefixIconContainerSize;
  final double? suffixIconContainerSize;
  final double? mainContainerSize;
  final double? inputFontSize;
  final double? borderRadius;
  final Color? activeBorderColor;
  final Color? inActiveBorderColor;
  final Color? inputBackgroundColor;
  final bool isDense;
  final int minLines;
  final int maxLines;
  final EdgeInsetsGeometry? contentPadding;

  const TextInputWidget({
    super.key,
    this.onChanged,
    required this.controller,
    this.hintText = '',
    this.isDense = true,
    this.contentPadding,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixIconSize = 15,
    this.suffixIconSize = 15,
    this.prefixIconContainerSize = 45,
    this.suffixIconContainerSize = 45,
    this.mainContainerSize = 50,
    this.inputFontSize = 13,
    this.borderRadius = 13,
    this.inputBackgroundColor = AppColors.transparent,
    this.activeBorderColor = AppColors.blueTextColor,
    this.inActiveBorderColor = AppColors.greyTextColor,
    this.prefixIconImage,
    this.minLines = 1,
    this.maxLines = 1,
  });

  @override
  _TextInputWidgetState createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  bool _isObscure = true;

  @override
  void initState() {
    super.initState();
    _isObscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    final EdgeInsetsGeometry contentPadding = widget.contentPadding ??
        EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w);

    return SizedBox(
      height: widget.mainContainerSize?.h,
      child: TextField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: _isObscure,
        minLines: widget.minLines,
        maxLines: widget.maxLines,
        decoration: InputDecoration(
          isDense: widget.isDense,
          filled: true,
          fillColor: widget.inputBackgroundColor,
          contentPadding: contentPadding,
          prefixIcon:
              (widget.prefixIcon != null || widget.prefixIconImage != null)
                  ? SizedBox(
                      width: widget.prefixIconContainerSize?.h,
                      height: widget.prefixIconContainerSize?.h,
                      child: IconButton(
                        icon: widget.prefixIconImage != null
                            ? Image.asset(widget.prefixIconImage!,
                                width: widget.prefixIconSize?.h,
                                height: widget.prefixIconSize?.h,
                                color: AppColors.greyTextColor)
                            : Icon(
                                widget.prefixIcon,
                                size: widget.prefixIconSize?.h,
                              ),
                        color: AppColors.greyTextColor,
                        onPressed: () {},
                      ),
                    )
                  : null,
          suffixIcon: widget.suffixIcon != null
              ? SizedBox(
                  width: widget.suffixIconContainerSize?.h,
                  height: widget.suffixIconContainerSize?.h,
                  child: IconButton(
                    icon: Icon(
                      widget.suffixIcon,
                      size: widget.suffixIconSize?.h,
                    ),
                    color: AppColors.greyTextColor,
                    onPressed: () {
                      // Add any functionality you want when suffix icon is pressed
                    },
                  ),
                )
              : widget.obscureText
                  ? SizedBox(
                      width: widget.suffixIconContainerSize?.h,
                      height: widget.suffixIconContainerSize?.h,
                      child: IconButton(
                        icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off,
                          size: 12.h,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      ),
                    )
                  : null,
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: AppColors.inputHintColor),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: widget.activeBorderColor!, width: 1.0.h),
            borderRadius: BorderRadius.circular(widget.borderRadius!.h),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: widget.inActiveBorderColor!, width: 1.0.h),
            borderRadius: BorderRadius.circular(widget.borderRadius!.h),
          ),
        ),
        style: TextStyle(
            fontSize: widget.inputFontSize?.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.blueTextColor,
            fontFamily: AppFonts.hkGrotesk),
        cursorColor: AppColors.blueTextColor,
        onChanged: (value) {
          if (widget.onChanged != null) {
            widget.onChanged!(value);
          }
        },
      ),
    );
  }
}
