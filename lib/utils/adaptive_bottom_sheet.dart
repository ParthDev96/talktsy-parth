import 'package:flutter/material.dart';
import 'package:talktsy/config/app_constants.dart';

Future<T?> showAdaptiveBottomSheet<T>({
  required BuildContext context,
  required Widget Function(BuildContext) builder,
  bool isDismissible = true,
  bool isScrollControlled = true,
  double maxHeight = 512,
  bool useRootNavigator = true,
}) =>
    showModalBottomSheet(
      context: context,
      builder: builder,
      // this sadly is ugly on desktops but otherwise breaks `.of(context)` calls
      useRootNavigator: useRootNavigator,
      isDismissible: isDismissible,
      isScrollControlled: isScrollControlled,
      constraints: BoxConstraints(
        maxHeight: maxHeight,
        maxWidth: AppConstants.columnWidth * 1.25,
      ),
      clipBehavior: Clip.hardEdge,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppConstants.borderRadius),
          topRight: Radius.circular(AppConstants.borderRadius),
        ),
      ),
    );
