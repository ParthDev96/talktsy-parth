import 'package:get/get.dart';

class BottomTabNavigatorController extends GetxController {
  RxInt bottomNavIndex = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future<void> tabChangeIndex(int index) async {
    // log("index===" + index.toString());

    if (index == 0) {
      bottomNavIndex.value = index;
      // await getDepositApiCalls();
      update();
    } else if (index == 1) {
      bottomNavIndex.value = index;
      // await getUserApiCalls("true");
      update();
    } else {
      bottomNavIndex.value = index;
      // await getUserApiCalls("false");
      update();
    }
  }
}
