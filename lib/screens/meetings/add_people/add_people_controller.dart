import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:talktsy/config/app_types.dart';
import 'package:talktsy/config/static_data.dart';

class AddPeopleController extends GetxController {
  TextEditingController searchText = TextEditingController();
  var users = <TypeUser>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  void fetchUsers() {
    users.assignAll(staticUserList);
  }
}
