import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class ImagePickerHelper {
  final ImagePicker _picker = ImagePicker();

  void showImagePickerOptions(
      BuildContext context, Function(File) onImagePicked) {
    final safePadding = MediaQuery.of(context).padding;
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
              bottom: safePadding.bottom + 15.h,
              top: 20.h,
              left: 10.h,
              right: 10.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.camera, size: 22.w),
                title: Text(
                  L10n.of(Get.context!)?.takeAPhoto ?? "",
                  style:
                      TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
                ),
                onTap: () async {
                  bool granted = await _requestCameraPermission();
                  if (granted) {
                    Navigator.pop(context);
                    _pickImage(context, ImageSource.camera, onImagePicked);
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_album, size: 22.w),
                title: Text(
                  L10n.of(Get.context!)?.selectFromGallery ?? "",
                  style:
                      TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
                ),
                onTap: () async {
                  bool granted = await _requestPhotoLibraryPermission();
                  if (granted) {
                    Navigator.pop(context);
                    _pickImage(context, ImageSource.gallery, onImagePicked);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(BuildContext context, ImageSource source,
      Function(File) onImagePicked) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      final File? croppedFile = await _cropImage(pickedFile.path);
      if (croppedFile != null) {
        onImagePicked(croppedFile);
      }
    }
  }

  Future<File?> _cropImage(String imagePath) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imagePath,
    );
    return croppedFile != null ? File(croppedFile.path) : null;
  }

  Future<bool> _requestCameraPermission() async {
    // Implement your camera permission request logic here
    return true;
  }

  Future<bool> _requestPhotoLibraryPermission() async {
    // Implement your photo library permission request logic here
    return true;
  }
}
