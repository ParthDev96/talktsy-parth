import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:talktsy/config/app_types.dart';
import 'package:talktsy/config/static_data.dart';

class InviteFriendsController extends GetxController {
  TextEditingController searchText = TextEditingController();
  var users = <TypeUser>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  void fetchUsers() {
    var userList = [
      TypeUser(
        userId: 1,
        imageUrl: 'https://via.placeholder.com/150',
        name: 'Alice',
        subTitle: '+1 987-309-4717',
      ),
      TypeUser(
          userId: 2,
          imageUrl: 'https://via.placeholder.com/150',
          name: 'Bob',
          subTitle: '+1 987-309-4717'),
      TypeUser(
          userId: 3,
          imageUrl: 'https://via.placeholder.com/150',
          name: 'Charlie',
          subTitle: '+1 987-309-4717'),
      TypeUser(
        userId: 4,
        imageUrl: 'https://via.placeholder.com/150',
        name: 'David',
        subTitle: '+1 987-309-4717',
      ),
      TypeUser(
          userId: 5,
          imageUrl: 'https://via.placeholder.com/150',
          name: 'Eve',
          subTitle: '+1 987-309-4717'),
      TypeUser(
        userId: 6,
        imageUrl: 'https://via.placeholder.com/150',
        name: 'Frank',
        subTitle: '+1 987-309-4717',
      ),
    ];

    users.assignAll(userList);
  }

}
