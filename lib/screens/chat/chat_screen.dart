import 'dart:io';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:talktsy/config/app_colors.dart';
import 'package:talktsy/config/app_fonts.dart';
import 'package:talktsy/config/app_images.dart';
import 'package:talktsy/helpers/image_picker_helper.dart';
import 'package:talktsy/screens/chat/chat_controller.dart';
import 'package:talktsy/widgets/icon_button_rounded.dart';
import 'package:talktsy/widgets/icon_button_shadow.dart';
import 'package:talktsy/widgets/text_widget.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter_gen/gen_l10n/l10n.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatController chatController = Get.put(ChatController());
  final ImagePickerHelper imagePickerHelper = ImagePickerHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _headerWidget(),
          Expanded(
            child: Obx(() {
              return chatController.messages.isEmpty
                  ? _noDataWidget()
                  : ListView.separated(
                      separatorBuilder: (context, index) =>
                          Container(height: 15.h),
                      reverse: true, // Show list from bottom
                      itemCount: chatController.messages.length,
                      itemBuilder: (context, index) {
                        var message = chatController.messages[index];
                        var isCurrentUser = message['isCurrentUser'];
                        return Align(
                            alignment: isCurrentUser
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: isCurrentUser
                                ? listViewItemCurrentUserWidget(index)
                                : listViewItemOpponentUserWidget(index));
                      },
                    );
            }),
          ),
          SizedBox(height: 8.h),
          renderSuggestionsView(),
          SizedBox(height: 8.h),
          Obx(() => Column(
                children: [
                  Obx(() {
                    return Offstage(
                      offstage: !chatController.isEmojiVisible.value,
                      child: SizedBox(
                        height: 250,
                        child: EmojiPicker(
                          onEmojiSelected: (category, emoji) {
                            chatController.onEmojiSelected(emoji);
                          },
                          config: Config(
                            height: 200.h,
                            // : const Color(0xFFF2F2F2),
                            checkPlatformCompatibility: true,
                            emojiViewConfig: EmojiViewConfig(
                              // Issue: https://github.com/flutter/flutter/issues/28894
                              emojiSizeMax: 28 *
                                  (foundation.defaultTargetPlatform ==
                                          TargetPlatform.iOS
                                      ? 1.20
                                      : 1.0),
                            ),
                            swapCategoryAndBottomBar: false,
                            skinToneConfig: const SkinToneConfig(),
                            categoryViewConfig: const CategoryViewConfig(),
                            bottomActionBarConfig:
                                const BottomActionBarConfig(),
                            searchViewConfig: const SearchViewConfig(),
                          ),
                        ),
                      ),
                    );
                  }),
                  _bottomViewWidget(),
                ],
              ))
        ],
      ),
    );
  }

  Widget listViewItemCurrentUserWidget(int index) {
    var message = chatController.messages[index];
    var isCurrentUser = message['isCurrentUser'];
    var containerPadding = EdgeInsets.all(5.h);
    if (message['type'] == 'text') {
      containerPadding = EdgeInsets.symmetric(horizontal: 15.h, vertical: 8.h);
    }
    return Container(
      margin: EdgeInsets.only(right: 15.w, left: 50.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextWidget(
            text: '14:00',
            textStyle: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 10.sp,
                color: AppColors.greyTextColor),
          ),
          Container(
            margin: EdgeInsets.only(top: 5.h),
            padding: containerPadding,
            decoration: BoxDecoration(
              color: AppColors.greyColorF2F2F2,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15.h),
                  topRight: Radius.circular(15.h),
                  topLeft: Radius.circular(15.h)),
            ),
            child: renderItems(message, isCurrentUser),
          ),
        ],
      ),
    );
  }

  Widget listViewItemOpponentUserWidget(int index) {
    var message = chatController.messages[index];
    var isCurrentUser = message['isCurrentUser'];
    var containerPadding = EdgeInsets.all(5.h);
    if (message['type'] == 'text') {
      containerPadding = EdgeInsets.symmetric(horizontal: 15.h, vertical: 8.h);
    }
    return Container(
      margin: EdgeInsets.only(right: 50.w, left: 15.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(AppImages.tempBoy),
            radius: 13.r,
          ),
          SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                text: '14:00',
                textStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 10.sp,
                    color: AppColors.greyTextColor),
              ),
              Container(
                margin: EdgeInsets.only(top: 5.h),
                padding: containerPadding,
                decoration: BoxDecoration(
                  color: AppColors.greenColor,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(15.h),
                      topRight: Radius.circular(15.h),
                      topLeft: Radius.circular(15.h)),
                ),
                child: renderItems(message, isCurrentUser),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget renderItems(message, isCurrentUser) {
    return message['type'] == 'text'
        ? TextWidget(
            text: message['message'],
            textStyle: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 13.sp,
                color: isCurrentUser
                    ? AppColors.blackColor
                    : AppColors.whiteColor),
          )
        : Container(
            width: 150.w,
            height: 150.w,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.all(Radius.circular(15.h)),
            ),
            child: Stack(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(15.h)),
                    child: message['message'] is File
                        ? Image.file(
                            message['message'],
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            AppImages.tempGirl,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          )),
                if (message['type'] == 'video')
                  Positioned(
                      child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.blackColor.withOpacity(0.3),
                      borderRadius: BorderRadius.all(Radius.circular(15.h)),
                    ),
                    child: Icon(Icons.play_circle_outline,
                        size: 50.w, color: AppColors.whiteColor),
                  ))
              ],
            ),
          );
  }

  Widget renderSuggestionsView() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.w),
            child: TextWidget(
              text: L10n.of(context)?.quickSuggestion ?? "",
              textStyle: TextStyle(
                  fontSize: 13.sp,
                  color: AppColors.greyColor828282,
                  fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: 30.h,
            child: ListView.separated(
              separatorBuilder: (context, index) => Container(width: 10.w),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: chatController.suggestionMessages.length,
              padding: EdgeInsets.symmetric(horizontal: 17.w),
              itemBuilder: (context, index) {
                var sMessage = chatController.suggestionMessages[index];
                return SizedBox(
                  height: 30.h,
                  child: InkWell(
                    onTap: () {
                      chatController.sendSuggestionMessage(sMessage['message']);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(15.h),
                        border: Border.all(
                          width: 1.h,
                          color: AppColors.greyColorF2F2F2,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 13.w),
                      child: Center(
                        child: TextWidget(
                          text: sMessage['message'],
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.greyColor828282,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _bottomViewWidget() {
    final safePadding = MediaQuery.of(context).padding;
    return Padding(
      padding: EdgeInsets.only(
          left: 5.w, right: 10.w, bottom: safePadding.bottom + 5.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(
            icon: Image.asset(AppImages.icChatLanguage,
                width: 18.w, height: 18.w),
            onPressed: () {
              Get.back();
            },
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  border:
                      Border.all(width: 1.h, color: AppColors.inputHintColor),
                  borderRadius: BorderRadius.all(Radius.circular(25.r))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        chatController.toggleEmojiKeyboard();
                      },
                      icon: Icon(
                        Icons.emoji_emotions,
                        size: 20.w,
                        color: AppColors.inputHintColor,
                      )),
                  Expanded(
                      child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: L10n.of(context)?.typeAMessage ?? "",
                      hintStyle:
                          const TextStyle(color: AppColors.inputHintColor),
                    ),
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 3,
                    autofocus: false,
                    controller: chatController.messageTextController,
                    cursorColor: AppColors.blueTextColor,
                    onTap: chatController.hideEmojiKeyboard,
                    style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.blueTextColor,
                        fontFamily: AppFonts.hkGrotesk),
                  )),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.mic_none,
                        size: 20.w,
                        color: AppColors.inputHintColor,
                      )),
                ],
              ),
            ),
          ),
          SizedBox(width: 10.w),
          IconButtonRounded(
            onPressed: () {
              if (chatController.messageText.value.isNotEmpty) {
                chatController.sendMessage(true);
              } else {
                imagePickerHelper.showImagePickerOptions(context,
                    (File imageFile) {
                  chatController.onSendImageMessage(File(imageFile.path));
                });
              }
            },
            containerHeight: 40,
            containerWidth: 40,
            icon: chatController.messageText.value.isNotEmpty
                ? Icons.send
                : Icons.photo_camera_outlined,
            iconSize: 20,
          )
        ],
      ),
    );
  }

  Widget _noDataWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(AppImages.tempBoy),
            radius: 45.r,
          ),
          SizedBox(height: 10.h),
          TextWidget(
            text: 'Prameshwar Kumar',
            textStyle: TextStyle(fontSize: 20.sp),
          ),
          SizedBox(height: 3.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 15.h,
                color: AppColors.inputHintColor,
              ),
              SizedBox(width: 3.h),
              TextWidget(
                text: 'Hyderabad, Telungana',
                textStyle: TextStyle(
                    fontSize: 13.sp,
                    color: AppColors.greyTextColor,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(height: 3.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppImages.icUserIcon,
                  width: 15.h, height: 15.w, color: AppColors.inputHintColor),
              SizedBox(width: 3.h),
              TextWidget(
                text: 'No matual Contact',
                textStyle: TextStyle(
                    fontSize: 13.sp,
                    color: AppColors.greyTextColor,
                    fontWeight: FontWeight.w600),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _headerWidget() {
    final safePadding = MediaQuery.of(context).padding;
    return Container(
      margin: EdgeInsets.only(top: safePadding.top),
      padding: EdgeInsets.only(left: 5.w, right: 10.w),
      height: 40.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, size: 20.w),
            onPressed: () {
              Get.back();
            },
          ),
          CircleAvatar(
            backgroundImage: AssetImage(AppImages.tempBoy),
            radius: 14.r,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: TextWidget(
              text: 'Prameshwar',
              textStyle: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13.sp,
              ),
            ),
          ),
          _videoCallButton(),
          SizedBox(width: 10.w),
          _audioCallButton(),
        ],
      ),
    );
  }

  Widget _videoCallButton() {
    return IconButtonShadow(
        containerHeight: 33,
        containerWidth: 33,
        iconSize: 22,
        icon: Icons.videocam_outlined,
        iconColor: AppColors.greenColor,
        onPressed: () {},
        backgroundColor: AppColors.greyColorF2F2F2,
        shadowColor: AppColors.transparent);
  }

  Widget _audioCallButton() {
    return IconButtonShadow(
        containerHeight: 33,
        containerWidth: 33,
        iconSize: 15,
        iconImage: AppImages.icTabCall,
        iconColor: AppColors.greenColor,
        onPressed: () {},
        backgroundColor: AppColors.greyColorF2F2F2,
        shadowColor: AppColors.transparent);
  }
}
