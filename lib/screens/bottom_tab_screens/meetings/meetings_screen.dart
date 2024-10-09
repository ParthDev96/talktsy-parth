import 'package:flutter/material.dart';
import 'package:talktsy/config/app_colors.dart';
import 'package:get/get.dart';
import 'package:talktsy/screens/bottom_tab_screens/meetings/meetings_screen_controller.dart';

class MeetingsScreen extends StatefulWidget {
  const MeetingsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MeetingsScreenState();
}

class _MeetingsScreenState extends State<MeetingsScreen> {
  MeetingsScreenController meetingsScreenController =
      Get.put(MeetingsScreenController());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.whiteColor,
        child: Center(
          child: Text('Meetings screen'),
        ),
      ),
    );
  }
}
