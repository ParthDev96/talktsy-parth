import 'package:get/get.dart';

class TypePerson {
  final int id;
  final String name;

  TypePerson({required this.id, required this.name});
}

class TypeUser {
  final int userId;
  final String imageUrl;
  final String name;
  final String subTitle;
  var isSelected = false.obs;

  TypeUser(
      {required this.userId,
      required this.imageUrl,
      required this.name,
      required this.subTitle,
      bool isSelected = false}) {
    this.isSelected.value = isSelected;
  }
}

class TypeLanguage {
  final String language;
  var isSelected = false.obs;

  TypeLanguage({required this.language, bool isSelected = false}) {
    this.isSelected.value = isSelected;
  }
}

class TypeUserStatus {
  final String statusName;
  final String status;

  TypeUserStatus(this.statusName, this.status);
}

class TypeNotification {
  bool isShowAcceptReject;

  TypeNotification({
    required this.isShowAcceptReject,
  });
}
