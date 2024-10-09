import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:talktsy/config/app_colors.dart';
import 'package:talktsy/config/app_images.dart';
import 'package:talktsy/routes/app_routes.dart';
import 'package:talktsy/screens/group/new_group_user_list/new_group_user_list_controller.dart';
import 'package:talktsy/widgets/list_item_widgets/user_item_widget.dart';
import 'package:talktsy/widgets/search_input_widget.dart';
import 'package:talktsy/widgets/tab_header_widget.dart';
import 'package:talktsy/widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class NewGroupUserListScreen extends StatefulWidget {
  const NewGroupUserListScreen({super.key});

  @override
  State<StatefulWidget> createState() => _NewGroupUserListScreenState();
}

class _NewGroupUserListScreenState extends State<NewGroupUserListScreen> {
  NewGroupUserListController newGroupUserListController =
      Get.put(NewGroupUserListController());

  @override
  Widget build(BuildContext context) {
    final safePadding = MediaQuery.of(context).padding;

    return Scaffold(
      appBar: TabHeaderWidget(
          titleText: L10n.of(context)?.newGroup ?? "",
          onBackButtonPressed: () {
            Get.back();
          },
          actions: [
            IconButton(
                onPressed: () {
                  Get.toNamed(Routes.notificationListScreen);
                },
                icon: Image.asset(
                  AppImages.icNotification,
                  color: AppColors.greenColor,
                  height: 18.w,
                  width: 18.w,
                ))
          ],
          mainContainerPadding: EdgeInsets.only(right: 10.w, left: 3.w)),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: AppColors.whiteColor,
        child: Column(
          children: [
            Obx(() => _selectedUsersWidget()),
            SearchInputWidget(
                controller: newGroupUserListController.searchText,
                verticalPadding: 5),
            Expanded(
                child: Obx(
              () => ListView.builder(
                itemCount: newGroupUserListController.users.length,
                padding: EdgeInsets.only(bottom: safePadding.bottom + 50.h),
                itemBuilder: (context, index) {
                  return UserItemWidget(
                      user: newGroupUserListController.users[index],
                      onPressCheck: (isSelected, user) {
                        if (isSelected) {
                          newGroupUserListController.addUserInList(user);
                        } else {
                          int itemIndex = newGroupUserListController
                              .selectedUsers
                              .indexWhere((item) => item.userId == user.userId);
                          newGroupUserListController
                              .removeFromUserList(itemIndex);
                        }
                      });
                },
              ),
            )),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        height: 40.w,
        width: 40.w,
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: AppColors.greenColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          child: Icon(Icons.arrow_forward,
              color: AppColors.whiteColor, size: 19.w),
        ),
      ),
    );
  }

  Widget _selectedUsersWidget() {
    if (newGroupUserListController.selectedUsers.isNotEmpty) {
      return SizedBox(
        height: 80.h,
        child: ListView.separated(
          separatorBuilder: (context, index) => Container(width: 11.w),
          scrollDirection: Axis.horizontal,
          itemCount: newGroupUserListController.selectedUsers.length,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          itemBuilder: (context, index) {
            return SizedBox(
              width: 60.w,
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(AppImages.tempGirl),
                        radius: 28.r,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      TextWidget(
                        text: newGroupUserListController
                            .selectedUsers[index].name,
                        textStyle: TextStyle(
                            fontSize: 11.sp,
                            color: AppColors.greyTextColor,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Positioned(
                      top: 3.w,
                      right: 3.w,
                      child: SizedBox(
                        height: 18.w,
                        width: 18.w,
                        child: IconButton(
                            // color: Colors.red,
                            padding: EdgeInsets.all(0),
                            style: ButtonStyle(backgroundColor:
                                WidgetStateProperty.resolveWith((states) {
                              return AppColors.greenColor;
                            })),
                            onPressed: () {
                              print(newGroupUserListController.users);
                              int itemIndex = newGroupUserListController.users
                                  .indexWhere((item) =>
                                      item.userId ==
                                      newGroupUserListController
                                          .selectedUsers[index].userId);
                              print(newGroupUserListController
                                  .selectedUsers[index].userId);
                              print(itemIndex);
                              newGroupUserListController
                                  .unselectFromUsers(itemIndex);
                              newGroupUserListController
                                  .removeFromUserList(index);
                            },
                            icon: Icon(
                              Icons.close,
                              color: AppColors.whiteColor,
                              size: 12.w,
                            )),
                      ))
                ],
              ),
            );
          },
        ),
      );
    }

    return SizedBox.shrink();
  }
}
