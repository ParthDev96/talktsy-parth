import 'package:get/get.dart';

class VideoCallController extends GetxController {
  RxBool audioSelected = true.obs;
  RxBool videoSelected = false.obs;
  RxBool screenShareSelected = false.obs;
  RxBool chatSelected = true.obs;
  double iconButtonHeight = 40.0;
  double iconButtonWidth = 40.0;

  void onAudioTap(bool value) {
    audioSelected.value = value;
  }

  void onScreenShareTap(bool value) {
    screenShareSelected.value = value;
  }

  void onVideoTap(bool value) {
    videoSelected.value = value;
  }
}
