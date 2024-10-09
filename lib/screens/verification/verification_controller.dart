import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:talktsy/config/app_colors.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class VerificationController extends GetxController {
  final GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();

  TextEditingController otpTextEditingController = TextEditingController();
  var otp = '';
  var data = Get.arguments;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    otpTextEditingController = TextEditingController();
  }

  String? validateOtp(String value) {
    if (value!.isEmpty) {
      Get.snackbar(L10n.of(Get.context!)?.error ?? "",
          L10n.of(Get.context!)?.errorOtp ?? "",
          backgroundColor: AppColors.blueTextColor,
          colorText: AppColors.whiteColor);

      // if(languageCode!.value=='en')
      // {
      //   return 'Please Enter  Otp';
      // }
      // else{
      //   return 'Per favore inserisci OTP';
      // }
    } else if (value.length < 4) {
      // if(languageCode!.value=='en')
      // {
      //   return 'Please Enter valid Otp';
      // }
      // else{
      //   return 'Inserisci un OTP valida';
      // }
    }

    return null;
  }
}
