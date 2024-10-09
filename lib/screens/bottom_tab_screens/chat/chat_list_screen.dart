import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:matrix/matrix.dart';
import 'package:talktsy/config/app_colors.dart';
import 'package:talktsy/config/app_fonts.dart';
import 'package:talktsy/config/app_images.dart';
import 'package:talktsy/config/enums.dart';
import 'package:talktsy/routes/app_routes.dart';
import 'package:talktsy/screens/bottom_tab_screens/chat/chat_list_item.dart';
import 'package:talktsy/screens/bottom_tab_screens/chat/chat_list_screen_controller.dart';
import 'package:get/get.dart';
import 'package:talktsy/screens/bottom_tab_screens/chat/dummy_chat_list_item.dart';
import 'package:talktsy/screens/bottom_tab_screens/chat/space_view.dart';
import 'package:talktsy/widgets/icon_button_rounded.dart';
import 'package:talktsy/widgets/matrix.dart';
import 'package:talktsy/widgets/search_input_widget.dart';
import 'package:talktsy/widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatListScreen> {
  ChatListScreenController chatListController =
      Get.put(ChatListScreenController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final client = Matrix.of(context).client;
    const dummyChatCount = 4;
    final rooms = chatListController.filteredRooms;

    // final client = Matrix.of(context).client;
    final activeSpace = chatListController.activeSpaceId;
    if (activeSpace != null) {
      return SpaceView(
        spaceId: activeSpace,
        onBack: chatListController.clearActiveSpace,
        onChatTab: (room) => chatListController.onChatTap(room),
        onChatContext: (room, context) =>
            chatListController.chatContextAction(room, context),
        activeChat: chatListController.activeChat,
        toParentSpace: chatListController.setActiveSpace,
      );
    }
    final spaces = client.rooms.where((r) => r.isSpace);
    final spaceDelegateCandidates = <String, Room>{};
    for (final space in spaces) {
      for (final spaceChild in space.spaceChildren) {
        final roomId = spaceChild.roomId;
        if (roomId == null) continue;
        spaceDelegateCandidates[roomId] = space;
      }
    }
    final filter = '';

    print('client.prevBatch: ${client.prevBatch}');
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          color: AppColors.whiteColor,
          child: Column(
            children: [
              SizedBox(
                height: 41.h,
                child: Padding(
                  padding: EdgeInsets.only(left: 20.sp, right: 10.sp),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                                text: L10n.of(context)?.chat ?? "",
                                textStyle: ChatScreenStyles.headerTitle),
                            Text.rich(
                              textAlign: TextAlign.center,
                              TextSpan(
                                text: 'You have '.tr,
                                style: ChatScreenStyles.countText,
                                children: [
                                  TextSpan(
                                    text: '20',
                                    style: ChatScreenStyles.countTextBold,
                                  ),
                                  TextSpan(
                                    text: ' unread chats.'.tr,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      videoCallButtonWidget(),
                      SizedBox(
                        width: 7.w,
                      ),
                      bookContentButtonWidget(),
                      notificationButtonWidget(),
                    ],
                  ),
                ),
              ),
              SearchInputWidget(controller: chatListController.searchText),
              Expanded(
                child: CustomScrollView(
                  // controller: controller.scrollController,
                  slivers: [
                    if (client.prevBatch == null)
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, i) => DummyChatListItem(
                            opacity: (dummyChatCount - i) / dummyChatCount,
                            animate: true,
                          ),
                          childCount: dummyChatCount,
                        ),
                      ),
                    if (client.prevBatch != null)
                      SliverList.builder(
                        itemCount: rooms.length,
                        itemBuilder: (BuildContext context, int i) {
                          final room = rooms[i];
                          final space = spaceDelegateCandidates[room.id];
                          return ChatListItem(
                            room,
                            space: space,
                            key: Key('chat_list_item_${room.id}'),
                            filter: filter,
                            onTap: () => chatListController.onChatTap(room),
                            onLongPress: (context) => chatListController
                                .chatContextAction(room, context, space),
                            activeChat:
                                chatListController.activeChat == room.id,
                          );
                        },
                      ),
                  ],
                ),
              ),
              // Expanded(child: chatListWidget()),
            ],
          )),
      floatingActionButton: SpeedDial(
        // animatedIcon: AnimatedIcons.add_event,
        icon: Icons.add,
        activeIcon: Icons.close,
        iconTheme: IconThemeData(color: AppColors.whiteColor, size: 22.w),
        backgroundColor: AppColors.greenColor,
        childPadding: EdgeInsets.zero,
        childMargin: EdgeInsets.zero,
        overlayOpacity: 0.8,
        buttonSize: Size(40.w, 40.w),
        openCloseDial: chatListController.isDialOpen,
        children: [
          SpeedDialChild(
            labelWidget: CustomSpeedDialChild(
              icon: Image.asset(AppImages.icTabChat,
                  height: 16.h, width: 16.h, color: AppColors.greyColor4F4F4F),
              text: L10n.of(context)?.newChat ?? "",
              onTap: () => onFloatingItemTap(ChatFloatingActionType.newChat),
            ),
            onTap: () => onFloatingItemTap(ChatFloatingActionType.newChat),
          ),
          SpeedDialChild(
            labelWidget: CustomSpeedDialChild(
              icon: Image.asset(AppImages.icPersonGroup,
                  height: 16.h, width: 16.h, color: AppColors.greyColor4F4F4F),
              text: L10n.of(context)?.newGroupChat ?? "",
              onTap: () =>
                  onFloatingItemTap(ChatFloatingActionType.newGroupChat),
            ),
            onTap: () => onFloatingItemTap(ChatFloatingActionType.newGroupChat),
          ),
          SpeedDialChild(
            labelWidget: CustomSpeedDialChild(
              icon: Icon(Icons.video_call_outlined,
                  color: AppColors.greyColor4F4F4F, size: 16.h),
              text: L10n.of(context)?.joinAMeeting ?? "",
              onTap: () =>
                  onFloatingItemTap(ChatFloatingActionType.joinAMeeting),
            ),
            onTap: () => onFloatingItemTap(ChatFloatingActionType.joinAMeeting),
          ),
          SpeedDialChild(
            labelWidget: CustomSpeedDialChild(
              icon: Icon(Icons.access_time,
                  color: AppColors.greyColor4F4F4F, size: 16.h),
              text: L10n.of(context)?.scheduleMeeting ?? "",
              onTap: () =>
                  onFloatingItemTap(ChatFloatingActionType.scheduleMeeting),
            ),
            onTap: () =>
                onFloatingItemTap(ChatFloatingActionType.scheduleMeeting),
          ),
        ],
      ),
    );
  }

  void onFloatingItemTap(ChatFloatingActionType type) {
    if (chatListController.isDialOpen.value) {
      chatListController.isDialOpen.value = false;
    }
    switch (type) {
      case ChatFloatingActionType.newChat:
        break;
      case ChatFloatingActionType.newGroupChat:
        Get.toNamed(Routes.newGroupUserListScreen);
        break;
      case ChatFloatingActionType.joinAMeeting:
        Get.toNamed(Routes.joinMeetingScreen);
        break;
      case ChatFloatingActionType.scheduleMeeting:
        Get.toNamed(Routes.scheduleMeetingScreen);
        break;
      default:
        break;
    }
  }

  Widget chatListWidget() {
    final client = Matrix.of(context).client;
    const dummyChatCount = 4;
    print('client.prevBatch: ${client.prevBatch}');
    if (client.prevBatch == null) {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, i) => DummyChatListItem(
            opacity: (dummyChatCount - i) / dummyChatCount,
            animate: true,
          ),
          childCount: dummyChatCount,
        ),
      );
    } else if (client.prevBatch != null) {
      // return SliverList.builder(
      //   itemCount: rooms.length,
      //   itemBuilder: (BuildContext context, int i) {
      //     final room = rooms[i];
      //     final space = spaceDelegateCandidates[room.id];
      //     return ChatListItem(
      //       room,
      //       space: space,
      //       key: Key('chat_list_item_${room.id}'),
      //       filter: filter,
      //       onTap: () => controller.onChatTap(room),
      //       onLongPress: (context) =>
      //           controller.chatContextAction(room, context, space),
      //       activeChat: controller.activeChat == room.id,
      //     );
      //   },
      // )
    }

    return ChatListBuilder(
      listData: chatListController.chatListDummyData.value,
    );
  }

  Widget videoCallButtonWidget() {
    return IconButtonRounded(
        onPressed: () {},
        icon: Icons.videocam_outlined,
        backgroundColor: AppColors.greyColorF2F2F2,
        iconColor: AppColors.greenColor,
        containerHeight: 35,
        containerWidth: 35,
        borderRadius: 18,
        iconSize: 17);
  }

  Widget bookContentButtonWidget() {
    return IconButtonRounded(
        onPressed: () {},
        iconImage: AppImages.icBookContent,
        backgroundColor: AppColors.greyColorF2F2F2,
        iconColor: AppColors.greenColor,
        containerHeight: 35,
        containerWidth: 35,
        borderRadius: 18,
        iconSize: 16);
  }

  Widget notificationButtonWidget() {
    return IconButtonRounded(
        onPressed: () {
          Get.toNamed(Routes.notificationListScreen);
        },
        icon: Icons.notifications_outlined,
        backgroundColor: AppColors.transparent,
        iconColor: AppColors.greenColor,
        containerHeight: 35,
        containerWidth: 35,
        borderRadius: 18,
        iconSize: 17);
  }
}

class ChatScreenStyles {
  static TextStyle headerTitle = TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.w700,
      color: AppColors.blackColor,
      fontFamily: AppFonts.hkGrotesk);
  static TextStyle countText = TextStyle(
      fontSize: 10.sp,
      fontWeight: FontWeight.w400,
      color: AppColors.greyTextColor,
      fontFamily: AppFonts.hkGrotesk);
  static TextStyle countTextBold = TextStyle(
      fontSize: 10.sp,
      fontWeight: FontWeight.bold,
      color: AppColors.greyTextColor,
      fontFamily: AppFonts.hkGrotesk);

  // chat list tile
  static TextStyle listTitleText = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.blackColor,
  );
  static TextStyle listSubTitleText = TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.greyTextColor,
  );
  static TextStyle listTimeText = TextStyle(
    fontSize: 9.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.greyTextColor,
  );
  static TextStyle badgeText = TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.whiteColor,
  );
}

class ChatListBuilder extends StatefulWidget {
  const ChatListBuilder({
    super.key,
    required this.listData,
  });

  final List<dynamic> listData;

  @override
  State<ChatListBuilder> createState() => _ChatListBuilderState();
}

class _ChatListBuilderState extends State<ChatListBuilder> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.listData.length,
        itemBuilder: (_, int index) {
          return listTileWidget(index);
        });
  }

  Widget listTileWidget(int index) {
    return ListTile(
      onTap: () {
        Get.toNamed(Routes.chatScreen);
      },
      onLongPress: () {},
      leading: leadingWidget(),
      dense: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
      minVerticalPadding: 15.h,
      visualDensity: const VisualDensity(vertical: 4),
      title: TextWidget(
          text: 'Tatiana Lipshutz', textStyle: ChatScreenStyles.listTitleText),
      subtitle: TextWidget(
          text: 'hi, hello buddy...',
          textStyle: ChatScreenStyles.listSubTitleText),
      trailing: trailingWidget(),
    );
  }

  Widget leadingWidget() {
    return Container(
      width: 45.w,
      height: 45.w,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          color: AppColors.greyColorF2F2F2,
          borderRadius: BorderRadius.all(Radius.circular(25.w))),
      child: Image.asset(AppImages.tempGirl, width: 45.w, height: 45.w),
    );
  }

  Widget trailingWidget() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextWidget(text: '14:58', textStyle: ChatScreenStyles.listTimeText),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            decoration: BoxDecoration(
              color: AppColors.greenColor,
              borderRadius: BorderRadius.all(Radius.circular(10.w)),
            ),
            constraints: BoxConstraints(
              maxHeight: 14.w,
            ),
            child: TextWidget(text: '3', textStyle: ChatScreenStyles.badgeText),
          ),
        ],
      ),
    );
  }
}

class CustomSpeedDialChild extends StatelessWidget {
  final Widget icon;
  final String text;
  final VoidCallback onTap;

  const CustomSpeedDialChild({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.dm, vertical: 6.dm),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.greyTextColor.withOpacity(0.3),
              blurRadius: 4.r,
              offset: Offset(0, 2.h),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            SizedBox(width: 8.w),
            TextWidget(
              text: text,
              textStyle: TextStyle(
                  color: AppColors.greyColor4F4F4F,
                  fontWeight: FontWeight.w600,
                  fontSize: 12.sp),
            ),
          ],
        ),
      ),
    );
  }
}
