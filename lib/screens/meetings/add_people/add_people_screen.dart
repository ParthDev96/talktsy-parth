import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:talktsy/config/app_colors.dart';
import 'package:talktsy/screens/meetings/add_people/add_people_controller.dart';
import 'package:talktsy/widgets/custom_button.dart';
import 'package:talktsy/widgets/list_item_widgets/user_item_widget.dart';
import 'package:talktsy/widgets/search_input_widget.dart';
import 'package:talktsy/widgets/tab_header_widget.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class AddPeopleScreen extends StatefulWidget {
  const AddPeopleScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AddPeopleScreenState();
}

class _AddPeopleScreenState extends State<AddPeopleScreen> {
  AddPeopleController addPeopleController = Get.put(AddPeopleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabHeaderWidget(
          titleText: L10n.of(context)?.addPeople ?? "",
          actions: [
            CustomButton(
                onPressed: () {},
                text: L10n.of(context)?.save ?? "",
                containerHeight: 25,
                borderRadius: 4,
                backgroundColor: AppColors.greenColor,
                textStyle:
                    TextStyle(color: AppColors.whiteColor, fontSize: 15.sp))
          ],
          onBackButtonPressed: () {
            Get.back();
          },
          mainContainerPadding: EdgeInsets.only(right: 10.w, left: 3.w)),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: AppColors.whiteColor,
        child: Column(
          children: [
            SearchInputWidget(
                controller: addPeopleController.searchText, verticalPadding: 5),
            Expanded(
              child: ListView.builder(
                itemCount: addPeopleController.users.length,
                itemBuilder: (context, index) {
                  return UserItemWidget(
                    user: addPeopleController.users[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
