import 'package:get/get.dart';
import 'package:talktsy/routes/app_routes.dart';
import 'package:talktsy/widgets/matrix.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    // var tLoginData = await SharedPrefsHelper.getObject(
    //     AppSharedPreferenceKeys.loginUserData);
    // print('tLoginData => ${Matrix.of(Get.context!).client.isLogged()}');
    if (!Matrix.of(Get.context!).client.isLogged()) {
      Future.delayed(const Duration(milliseconds: 0), () {
        Get.offAllNamed(Routes.loginScreen);
      });
    } else {
      // await ApiServices.getProfileData();
      Future.delayed(const Duration(milliseconds: 0), () {
        Get.offAllNamed(Routes.bottomNavigationScreen);
      });
    }
  }
}
