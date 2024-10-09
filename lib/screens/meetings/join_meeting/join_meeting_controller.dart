import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class JoinMeetingController extends GetxController {
  TextEditingController meetingIdTextController = TextEditingController();
  RxBool audioSelected = true.obs;
  RxBool videoSelected = false.obs;
  RxBool isRemember = true.obs;

  RxString selectedValue = 'Boardme weekly meeting'.obs;
  List<String> dropdownItems = [
    'Boardme weekly meeting',
    'Option 2',
    'Option 3',
    'Option 4',
    'Option 5',
  ].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void setSelectedValue(String value) {
    selectedValue.value = value;
  }

  void onAudioTap(bool value) {
    audioSelected.value = value;
  }

  void onVideoTap(bool value) {
    videoSelected.value = value;
  }

  void onRememberTap(bool value) {
    isRemember.value = value;
  }
}
