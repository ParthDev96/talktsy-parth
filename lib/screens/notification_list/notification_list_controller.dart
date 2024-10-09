import 'package:get/get.dart';
import 'package:talktsy/config/app_types.dart';

class NotificationListController extends GetxController {
  var notifications = <TypeNotification>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchNotifications();
  }

  void fetchNotifications() {
    notifications.addAll([
      TypeNotification(isShowAcceptReject: true),
      TypeNotification(isShowAcceptReject: false),
      TypeNotification(isShowAcceptReject: false),
      TypeNotification(isShowAcceptReject: false),
      TypeNotification(isShowAcceptReject: true),
      TypeNotification(isShowAcceptReject: false),
      TypeNotification(isShowAcceptReject: false),
      TypeNotification(isShowAcceptReject: false),
      TypeNotification(isShowAcceptReject: true),
    ]);
  }
}