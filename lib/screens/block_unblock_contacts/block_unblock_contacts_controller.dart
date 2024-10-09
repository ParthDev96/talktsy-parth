import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:talktsy/config/app_types.dart';
import 'package:talktsy/config/static_data.dart';

class BlockUnblockContactsController extends GetxController {
  RxInt selectedSegment = 0.obs;
  final Map<int, Widget> segmentTabs = const <int, Widget>{
    0: Text("Item 1"),
    1: Text("Item 2")
  };
  var users = <TypeUser>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchUsers();
  }

  void fetchUsers() {
    users.assignAll(staticUserList);
  }

  void onSegmentChange(int index) {
    selectedSegment.value = index;
  }
}
