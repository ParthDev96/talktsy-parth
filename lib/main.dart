import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:matrix/matrix.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:talktsy/config/app_constants.dart';
import 'package:talktsy/config/setting_keys.dart';
import 'package:talktsy/utils/client_manager.dart';
import 'package:talktsy/utils/platform_infos.dart';
import 'package:talktsy/widgets/matrix/error_widget.dart';
import 'package:talktsy/widgets/talktsy_start_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  databaseFactoryOrNull = null;

  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  final store = await SharedPreferences.getInstance();
  final clients = await ClientManager.getClients(store: store);

  if (PlatformInfos.isAndroid &&
      AppLifecycleState.detached == WidgetsBinding.instance.lifecycleState) {
    // Do not send online presences when app is in background fetch mode.
    for (final client in clients) {
      client.backgroundSync = false;
      client.syncPresence = PresenceType.offline;
    }

    // In the background fetch mode we do not want to waste ressources with
    // starting the Flutter engine but process incoming push notifications.

    // BackgroundPush.clientOnly(clients.first);

    // To start the flutter engine afterwards we add an custom observer.
    WidgetsBinding.instance.addObserver(AppStarter(clients, store));
    Logs().i(
      '${AppConstants.applicationName} started in background-fetch mode. No GUI will be created unless the app is no longer detached.',
    );
    return;
  }

  // Started in foreground mode.
  Logs().i(
    '${AppConstants.applicationName} started in foreground mode. Rendering GUI...',
  );
  await startGui(clients, store);
  // runApp(MyApp(countryCode: countryCode, languageCode: languageCode));
}

/// Fetch the pincode for the applock and start the flutter engine.
Future<void> startGui(List<Client> clients, SharedPreferences store) async {
  // Fetch the pin for the applock if existing for mobile applications.
  String? pin;
  if (PlatformInfos.isMobile) {
    try {
      pin =
          await const FlutterSecureStorage().read(key: SettingKeys.appLockKey);
    } catch (e, s) {
      Logs().d('Unable to read PIN from Secure storage', e, s);
    }
  }

  // Preload first client
  final firstClient = clients.firstOrNull;
  await firstClient?.roomsLoading;
  await firstClient?.accountDataLoading;

  ErrorWidget.builder = (details) => TalktsyErrorWidget(details);
  runApp(TalktsyStartApp(clients: clients, pincode: pin, store: store));
}

class AppStarter with WidgetsBindingObserver {
  final List<Client> clients;
  final SharedPreferences store;
  bool guiStarted = false;

  AppStarter(this.clients, this.store);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (guiStarted) return;
    if (state == AppLifecycleState.detached) return;

    Logs().i(
      '${AppConstants.applicationName} switches from the detached background-fetch mode to ${state.name} mode. Rendering GUI...',
    );
    // Switching to foreground mode needs to reenable send online sync presence.
    for (final client in clients) {
      client.backgroundSync = true;
      client.syncPresence = PresenceType.online;
    }
    startGui(clients, store);
    // We must make sure that the GUI is only started once.
    guiStarted = true;
  }
}
