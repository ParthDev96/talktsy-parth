import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talktsy/config/app_colors.dart';
import 'package:talktsy/widgets/text_input_widget.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class SearchInputWidget extends StatefulWidget {
  final TextEditingController controller;
  final int verticalPadding;

  const SearchInputWidget(
      {super.key, required this.controller, this.verticalPadding = 12});

  @override
  State<SearchInputWidget> createState() => _SearchInputWidgetState();
}

class _SearchInputWidgetState extends State<SearchInputWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: 18.h, vertical: widget.verticalPadding.h),
      child: TextInputWidget(
        controller: widget.controller,
        onChanged: (value) {},
        hintText: L10n.of(context)?.search ?? "",
        prefixIcon: Icons.search_rounded,
        suffixIcon: Icons.mic_none,
        mainContainerSize: 30,
        suffixIconContainerSize: 30,
        prefixIconContainerSize: 30,
        suffixIconSize: 17,
        prefixIconSize: 17,
        isDense: false,
        contentPadding: EdgeInsets.symmetric(vertical: 0),
        inputBackgroundColor: AppColors.greyColorF2F2F2,
        activeBorderColor: AppColors.greyColorF2F2F2,
        inActiveBorderColor: AppColors.greyColorF2F2F2,
      ),
    );
  }
}
