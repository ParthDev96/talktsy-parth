import 'package:get/get.dart';

class SettingsController extends GetxController {
  var callingSwitch = false.obs;
  var messagingSwitch = false.obs;
  var notificationsSwitch = false.obs;

  void onCallingSwitchChange(bool value) {
    callingSwitch.value = value;
  }

  void onMessagingSwitchChange(bool value) {
    messagingSwitch.value = value;
  }

  void onNotificationsSwitchChange(bool value) {
    notificationsSwitch.value = value;
  }
}
