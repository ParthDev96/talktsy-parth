import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:talktsy/config/app_colors.dart';
import 'package:talktsy/config/app_fonts.dart';

class PhoneInputWidget extends StatefulWidget {
  static const supportedLocales = [
    Locale('ar'),
    // not supported by material yet
    // Locale('ckb'),
    Locale('de'),
    Locale('el'),
    Locale('en'),
    Locale('es'),
    Locale('fa'),
    Locale('fr'),
    Locale('hi'),
    Locale('hu'),
    Locale('it'),
    // not supported by material yet
    // Locale('ku'),
    Locale('nb'),
    Locale('nl'),
    Locale('pt'),
    Locale('ru'),
    Locale('sv'),
    Locale('tr'),
    Locale('uz'),
    Locale('zh'),
    // ...
  ];

  final PhoneController controller;
  final FocusNode focusNode;
  final CountrySelectorNavigator selectorNavigator;
  final bool? mobileOnly;
  final bool showFlag;
  final Locale locale;
  final String hintText;
  final Color activeBorderColor;
  final Color inActiveBorderColor;
  final int borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsets? countryButtonContentPadding;

  const PhoneInputWidget({
    super.key,
    this.showFlag = true,
    this.borderRadius = 13,
    required this.controller,
    required this.focusNode,
    required this.selectorNavigator,
    this.mobileOnly = false,
    required this.locale,
    this.hintText = '',
    // this.inputBackgroundColor = AppColors.transparent,
    this.activeBorderColor = AppColors.blueTextColor,
    this.inActiveBorderColor = AppColors.greyTextColor,
    this.contentPadding,
    this.countryButtonContentPadding,
  });

  @override
  State<PhoneInputWidget> createState() => _PhoneInputWidgetState();
}

class _PhoneInputWidgetState extends State<PhoneInputWidget> {
  @override
  Widget build(BuildContext context) {
    final EdgeInsetsGeometry contentPadding =
        widget.contentPadding ?? EdgeInsets.all(15.h);
    final EdgeInsets countryButtonContentPadding =
        widget.countryButtonContentPadding ?? EdgeInsets.all(15.h);

    return AutofillGroup(
      child: Localizations.override(
        context: context,
        locale: widget.locale,
        child: Builder(
          builder: (context) {
            return PhoneFormField(
              controller: widget.controller,
              style: TextStyle(
                  fontSize: 10.h,
                  fontWeight: FontWeight.w600,
                  color: AppColors.blueTextColor,
                  fontFamily: AppFonts.hkGrotesk),
              countrySelectorNavigator: widget.selectorNavigator,
              decoration: InputDecoration(
                contentPadding: contentPadding,
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: widget.activeBorderColor, width: 1.0.h),
                  borderRadius: BorderRadius.circular(widget.borderRadius.h),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: widget.inActiveBorderColor, width: 1.0.h),
                  borderRadius: BorderRadius.circular(widget.borderRadius.h),
                ),
                hintText: widget.hintText,
                hintStyle: const TextStyle(color: AppColors.inputHintColor),
              ),
              enabled: true,
              countryButtonStyle: CountryButtonStyle(
                  padding: countryButtonContentPadding,
                  showFlag: widget.showFlag,
                  showIsoCode: false,
                  showDialCode: true,
                  showDropdownIcon: false,
                  textStyle: TextStyle(
                      color: AppColors.blueTextColor,
                      fontFamily: AppFonts.hkGrotesk,
                      fontWeight: FontWeight.w600,
                      fontSize: 10.h)),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              cursorColor: AppColors.blueTextColor,
              onSaved: (p) => print('saved $p'),
              onChanged: (p) => print('changed $p'),
            );
          },
        ),
      ),
    );
  }
}
