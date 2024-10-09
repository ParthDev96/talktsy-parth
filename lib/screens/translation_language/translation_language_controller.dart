import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:talktsy/config/app_types.dart';

class TranslationLanguageController extends GetxController {
  TextEditingController searchText = TextEditingController();
  var languages = <TypeLanguage>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }
  void fetchUsers() {
    var userList = [
      TypeLanguage(language: 'English', isSelected: true),
      TypeLanguage(language: 'हिन्दी', isSelected: false),
      TypeLanguage(language: 'मराठी', isSelected: false),
    ];

    languages.assignAll(userList);
  }
}
