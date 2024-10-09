import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:matrix/matrix.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talktsy/config/app_colors.dart';
import 'package:talktsy/locales/languages.dart';
import 'package:talktsy/routes/app_pages.dart';
import 'package:talktsy/routes/app_routes.dart';
import 'package:talktsy/utils/app_lock.dart';
import 'package:talktsy/widgets/matrix.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class TalktsyStartApp extends StatelessWidget {
  // final String countryCode;
  // final String languageCode;
  final Widget? testWidget;
  final List<Client> clients;
  final String? pincode;
  final SharedPreferences store;

  const TalktsyStartApp(
      {super.key,
      // required this.countryCode,
      // required this.languageCode,
      required this.clients,
      this.pincode,
      required this.store,
      this.testWidget});

  /// getInitialLink may rereturn the value multiple times if this view is
  /// opened multiple times for example if the user logs out after they logged
  /// in with qr code or magic link.
  static bool gotInitialLink = false;

  // Router must be outside of build method so that hot reload does not reset
  // the current path.
  // static final GoRouter router = GoRouter(routes: AppRoutes.routes);
  // static final List<GetPage> router = AppRoutes.routes;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: (BuildContext context, Widget? child) {
      return GetMaterialApp(
        theme: ThemeData(
            scaffoldBackgroundColor: AppColors.whiteColor,
            canvasColor: AppColors.whiteColor),
        debugShowCheckedModeBanner: false,
        translations: Languages(),
        locale: Locale('en', 'US'),
        fallbackLocale: Locale('en', 'US'),
        localizationsDelegates: L10n.localizationsDelegates,
        supportedLocales: L10n.supportedLocales,
        initialRoute: Routes.splashScreen,
        getPages: AppPages.routes,
        builder: (context, child) => AppLockWidget(
          pincode: pincode,
          clients: clients,
          // Need a navigator above the Matrix widget for
          // displaying dialogs
          child: Navigator(
            onGenerateRoute: (_) => MaterialPageRoute(
              builder: (_) => Matrix(
                clients: clients,
                store: store,
                child: testWidget ?? child,
              ),
            ),
          ),
        ),
      );
    });
  }
}
