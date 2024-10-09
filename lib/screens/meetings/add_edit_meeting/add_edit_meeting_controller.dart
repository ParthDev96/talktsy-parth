import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddEditMeetingController extends GetxController {
  TextEditingController addTitleTextController = TextEditingController();
  TextEditingController addDescTextController = TextEditingController();
  var allDaySwitchValue = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void onAllDaySwitchChange(bool value) {
    allDaySwitchValue.value = value;
  }
}
