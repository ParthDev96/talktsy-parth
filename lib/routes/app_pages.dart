import 'package:talktsy/navigator/bottom_navigator/bottom_tab_navigator.dart';
import 'package:talktsy/screens/account_and_profile/account_and_profile_screen.dart';
import 'package:talktsy/screens/block_unblock_contacts/block_unblock_contacts_screen.dart';
import 'package:talktsy/screens/call_screens/incoming_call/incoming_call_screen.dart';
import 'package:talktsy/screens/call_screens/video_call/video_call_screen.dart';
import 'package:talktsy/screens/chat/chat_screen.dart';
import 'package:talktsy/screens/contacts/contacts_screen.dart';
import 'package:talktsy/screens/faq/faq_screen.dart';
import 'package:talktsy/screens/group/new_group_user_list/new_group_user_list_screen.dart';
import 'package:talktsy/screens/invite_friends/invite_friends_screen.dart';
import 'package:talktsy/screens/login/login_screen.dart';
import 'package:talktsy/screens/meetings/add_edit_meeting/add_edit_meeting_screen.dart';
import 'package:talktsy/screens/meetings/add_people/add_people_screen.dart';
import 'package:talktsy/screens/meetings/join_meeting/join_meeting_screen.dart';
import 'package:talktsy/screens/meetings/schedule_meeting/schedule_meeting_screen.dart';
import 'package:talktsy/screens/notification_list/notification_list_screen.dart';
import 'package:talktsy/screens/settings/settings_screen.dart';
import 'package:talktsy/screens/signup/signup_screen.dart';
import 'package:talktsy/screens/splash/splash_screen.dart';
import 'package:talktsy/screens/translation_language/translation_language_screen.dart';
import 'package:talktsy/screens/verification/verification_screen.dart';
import 'package:talktsy/screens/webview/webview_screen.dart';

import 'app_routes.dart';
import 'package:get/get.dart';

class AppPages {
  static const initial = Routes.splashScreen;
  static final routes = [
    GetPage(
        name: Routes.splashScreen,
        page: () => const SplashScreen(),
        transition: Transition.native),
    GetPage(
        name: Routes.loginScreen,
        page: () => const LoginScreen(),
        transition: Transition.native),
    GetPage(
        name: Routes.signupScreen,
        page: () => SignupScreen(),
        transition: Transition.native),
    GetPage(
        name: Routes.verificationScreen,
        page: () => const VerificationScreen(),
        transition: Transition.native),
    GetPage(
        name: Routes.bottomNavigationScreen,
        page: () => const BottomTabNavigator(),
        transition: Transition.native),
    GetPage(
        name: Routes.scheduleMeetingScreen,
        page: () => const ScheduleMeetingScreen(),
        transition: Transition.native),
    GetPage(
        name: Routes.addEditMeetingScreen,
        page: () => const AddEditMeetingScreen(),
        transition: Transition.native),
    GetPage(
        name: Routes.addPeopleScreen,
        page: () => const AddPeopleScreen(),
        transition: Transition.native),
    GetPage(
        name: Routes.joinMeetingScreen,
        page: () => const JoinMeetingScreen(),
        transition: Transition.native),
    GetPage(
        name: Routes.videoCallScreen,
        page: () => const VideoCallScreen(),
        transition: Transition.native),
    GetPage(
        name: Routes.incomingCallScreen,
        page: () => const IncomingCallScreen(),
        transition: Transition.native),
    GetPage(
        name: Routes.translationLanguageScreen,
        page: () => const TranslationLanguageScreen(),
        transition: Transition.native),
    GetPage(
        name: Routes.contactsScreen,
        page: () => const ContactsScreen(),
        transition: Transition.native),
    GetPage(
        name: Routes.newGroupUserListScreen,
        page: () => const NewGroupUserListScreen(),
        transition: Transition.native),
    GetPage(
        name: Routes.notificationListScreen,
        page: () => const NotificationListScreen(),
        transition: Transition.native),
    GetPage(
        name: Routes.inviteFriendsScreen,
        page: () => const InviteFriendsScreen(),
        transition: Transition.native),
    GetPage(
        name: Routes.settingsScreen,
        page: () => const SettingsScreen(),
        transition: Transition.native),
    GetPage(
        name: Routes.webViewScreen,
        page: () => const WebViewScreen(),
        transition: Transition.native),
    GetPage(
        name: Routes.blockUnblockContactsScreen,
        page: () => const BlockUnblockContactsScreen(),
        transition: Transition.native),
    GetPage(
        name: Routes.faqScreen,
        page: () => const FaqScreen(),
        transition: Transition.native),
    GetPage(
        name: Routes.accountAndProfileScreen,
        page: () => const AccountAndProfileScreen(),
        transition: Transition.native),
    GetPage(
        name: Routes.chatScreen,
        page: () => const ChatScreen(),
        transition: Transition.native),
  ];
}
