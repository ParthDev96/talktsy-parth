import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:talktsy/config/app_colors.dart';
import 'package:talktsy/config/app_types.dart';
import 'package:talktsy/screens/translation_language/translation_language_controller.dart';
import 'package:talktsy/widgets/search_input_widget.dart';
import 'package:talktsy/widgets/tab_header_widget.dart';
import 'package:talktsy/widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class TranslationLanguageScreen extends StatefulWidget {
  const TranslationLanguageScreen({super.key});

  @override
  State<StatefulWidget> createState() => _TranslationLanguageScreenState();
}

class _TranslationLanguageScreenState extends State<TranslationLanguageScreen> {
  TranslationLanguageController translationLanguageController =
      Get.put(TranslationLanguageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabHeaderWidget(
          titleText: L10n.of(context)?.translationLanguage ?? "",
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.check, color: AppColors.greenColor))
          ],
          onBackButtonPressed: () {
            Get.back();
          },
          mainContainerPadding: EdgeInsets.only(right: 10.w, left: 3.w)),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.whiteColor,
        child: Column(
          children: [
            SearchInputWidget(
                controller: translationLanguageController.searchText,
                verticalPadding: 5),
            Expanded(
              child: ListView.separated(
                itemCount: translationLanguageController.languages.length,
                separatorBuilder: (context, index) =>
                    Divider(color: AppColors.inputHintColor),
                // Custom separator with a grey color
                itemBuilder: (context, index) {
                  return LanguageListItem(
                    languageItem:
                        translationLanguageController.languages[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LanguageListItem extends StatelessWidget {
  final TypeLanguage languageItem;

  const LanguageListItem({super.key, required this.languageItem});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 20.w),
      child: Row(
        children: [
          Expanded(
            child: TextWidget(
              text: languageItem.language,
              textStyle:
                  TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
            ),
          ),
          Obx(() => Center(
                  child: InkWell(
                onTap: () {
                  languageItem.isSelected.value =
                      !languageItem.isSelected.value;
                },
                child: Container(
                  height: 18.h,
                  width: 18.h,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: languageItem.isSelected.value
                          ? AppColors.greenColor
                          : AppColors.greyColorF2F2F2),
                  child: languageItem.isSelected.value
                      ? Icon(
                          Icons.check,
                          size: 13.r,
                          color: AppColors.whiteColor,
                        )
                      : null,
                ),
              ))),
        ],
      ),
    );
  }
}
