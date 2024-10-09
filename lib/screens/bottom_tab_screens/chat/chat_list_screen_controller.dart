import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:future_loading_dialog/future_loading_dialog.dart';
import 'package:get/get.dart';
import 'package:matrix/matrix.dart';
import 'package:talktsy/config/app_dialogs.dart';
import 'package:talktsy/services/api_config.dart';
import 'package:talktsy/services/api_service.dart';
import 'package:talktsy/widgets/avatar.dart';
import 'package:talktsy/widgets/matrix.dart';
import 'package:matrix/matrix.dart' as sdk;
import 'package:matrix/matrix.dart';
import 'package:talktsy/widgets/send_file_dialog.dart';
import 'dart:async';
import 'package:flutter_gen/gen_l10n/l10n.dart';

enum ActiveFilter {
  allChats,
  messages,
  groups,
  unread,
  spaces,
}

enum InviteActions {
  accept,
  decline,
  block,
}

enum ChatContextAction {
  open,
  goToSpace,
  favorite,
  markUnread,
  mute,
  leave,
  addToSpace,
}

class ChatListScreenController extends GetxController {
  TextEditingController searchText = TextEditingController();
  bool mounted = true;

  var chatListDummyData = <dynamic>[].obs;

  var activeFilter = ActiveFilter.allChats.obs;

  final matrixClient = Matrix.of(Get.context!).client;

  // ActiveFilter activeFilter = AppConfig.separateChatTypes
  //     ? ActiveFilter.messages
  //     : ActiveFilter.allChats;

  var context = Get.context!;

  List<Room> get filteredRooms => matrixClient.rooms
      .where(getRoomFilterByActiveFilter(activeFilter.value))
      .toList();

  final isDialOpen = ValueNotifier(false);

  final _activeSpaceId = RxnString();

  String? get activeSpaceId => _activeSpaceId.value;

  final _activeChat = RxnString();

  String? get activeChat => _activeChat.value;

  @override
  void onInit() {
    super.onInit();
    // callSyncData();
  }

  @override
  void onClose() {
    mounted = false; // Mark the controller as no longer active
    super.onClose();
  }

  void onChatTap(Room room) async {
    print('1 ${room.membership == Membership.invite}');
    print('2 ${room.membership == Membership.ban}');
    print('3 ${room.membership == Membership.leave}');
    if (room.membership == Membership.invite) {
      final inviterId =
          room.getState(EventTypes.RoomMember, room.client.userID!)?.senderId;
      final inviteAction = await showModalActionSheet<InviteActions>(
        context: context,
        message: room.isDirectChat
            ? L10n.of(Get.context!)?.invitePrivateChat ?? ""
            : L10n.of(Get.context!)?.inviteGroupChat ?? "",
        title: room.getLocalizedDisplayname(),
        actions: [
          SheetAction(
            key: InviteActions.accept,
            label: L10n.of(Get.context!)?.accept ?? "",
            icon: Icons.check_outlined,
            isDefaultAction: true,
          ),
          SheetAction(
            key: InviteActions.decline,
            label: L10n.of(Get.context!)?.decline ?? "",
            icon: Icons.close_outlined,
            isDestructiveAction: true,
          ),
          SheetAction(
            key: InviteActions.block,
            label: L10n.of(Get.context!)?.block ?? "",
            icon: Icons.block_outlined,
            isDestructiveAction: true,
          ),
        ],
      );
      if (inviteAction == null) return;
      if (inviteAction == InviteActions.block) {
        // context.go('/rooms/settings/security/ignorelist', extra: inviterId);
        return;
      }
      if (inviteAction == InviteActions.decline) {
        await showFutureLoadingDialog(
          context: context,
          future: room.leave,
        );
        return;
      }
      final joinResult = await showFutureLoadingDialog(
        context: context,
        future: () async {
          final waitForRoom = room.client.waitForRoomInSync(
            room.id,
            join: true,
          );
          await room.join();
          await waitForRoom;
        },
      );
      if (joinResult.error != null) return;
    }

    if (room.membership == Membership.ban) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text(L10n.of(Get.context!)?.youHaveBeenBannedFromThisChat ?? ""),
        ),
      );
      return;
    }

    if (room.membership == Membership.leave) {
      // context.go('/rooms/archive/${room.id}');
      return;
    }

    if (room.isSpace) {
      setActiveSpace(room.id);
      return;
    }
    // Share content into this room
    final shareContent = Matrix.of(context).shareContent;
    print('4 ${shareContent != null}');
    if (shareContent != null) {
      final shareFile = shareContent.tryGet<MatrixFile>('file');
      if (shareContent.tryGet<String>('msgtype') == 'chat.fluffy.shared_file' &&
          shareFile != null) {
        await showDialog(
          context: context,
          useRootNavigator: false,
          builder: (c) => SendFileDialog(
            files: [shareFile],
            room: room,
          ),
        );
        Matrix.of(context).shareContent = null;
      } else {
        final consent = await showOkCancelAlertDialog(
          context: context,
          title: L10n.of(Get.context!)?.forward ?? "",
          message: 'forwardMessageTo'.trParams({
            'roomName': room.getLocalizedDisplayname(),
          }),
          okLabel: L10n.of(Get.context!)?.forward ?? "",
          cancelLabel: L10n.of(Get.context!)?.cancel ?? "",
        );
        if (consent == OkCancelResult.cancel) {
          Matrix.of(context).shareContent = null;
          return;
        }
        if (consent == OkCancelResult.ok) {
          room.sendEvent(shareContent);
          Matrix.of(context).shareContent = null;
        }
      }
    }

    // context.go('/rooms/${room.id}');
  }

  bool Function(Room) getRoomFilterByActiveFilter(ActiveFilter activeFilter) {
    switch (activeFilter) {
      case ActiveFilter.allChats:
        return (room) => true;
      case ActiveFilter.messages:
        return (room) => !room.isSpace && room.isDirectChat;
      case ActiveFilter.groups:
        return (room) => !room.isSpace && !room.isDirectChat;
      case ActiveFilter.unread:
        return (room) => room.isUnreadOrInvited;
      case ActiveFilter.spaces:
        return (room) => room.isSpace;
    }
  }

  // Set active space and load the room data
  Future<void> setActiveSpace(String spaceId) async {
    await Matrix.of(Get.context!).client.getRoomById(spaceId)!.postLoad();
    // No need for setState, just update the reactive variable
    _activeSpaceId.value = spaceId;
  }

  // Clear active space
  void clearActiveSpace() {
    _activeSpaceId.value = null; // Directly updating the reactive value
  }

  void chatContextAction(
    Room room,
    BuildContext posContext, [
    Room? space,
  ]) async {
    if (room.membership == Membership.invite) {
      return onChatTap(room);
    }

    final overlay =
        Overlay.of(posContext).context.findRenderObject() as RenderBox;

    final button = posContext.findRenderObject() as RenderBox;

    final position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(const Offset(0, -65), ancestor: overlay),
        button.localToGlobal(
          button.size.bottomRight(Offset.zero) + const Offset(-50, 0),
          ancestor: overlay,
        ),
      ),
      Offset.zero & overlay.size,
    );

    final displayname = room.getLocalizedDisplayname();

    final spacesWithPowerLevels = room.client.rooms
        .where(
          (space) =>
              space.isSpace &&
              space.canChangeStateEvent(EventTypes.SpaceChild) &&
              !space.spaceChildren.any((c) => c.roomId == room.id),
        )
        .toList();

    final action = await showMenu<ChatContextAction>(
      context: posContext,
      position: position,
      items: [
        PopupMenuItem(
          value: ChatContextAction.open,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Avatar(
                mxContent: room.avatar,
                size: Avatar.defaultSize / 2,
                name: displayname,
              ),
              const SizedBox(width: 12),
              Text(
                displayname,
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onSurface),
              ),
            ],
          ),
        ),
        const PopupMenuDivider(),
        if (space != null)
          PopupMenuItem(
            value: ChatContextAction.goToSpace,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Avatar(
                  mxContent: space.avatar,
                  size: Avatar.defaultSize / 2,
                  name: space.getLocalizedDisplayname(),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'goToSpace'
                        .trParams({'space': space.getLocalizedDisplayname()}),
                  ),
                ),
              ],
            ),
          ),
        PopupMenuItem(
          value: ChatContextAction.mute,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                room.pushRuleState == PushRuleState.notify
                    ? Icons.notifications_off_outlined
                    : Icons.notifications_off,
              ),
              const SizedBox(width: 12),
              Text(
                room.pushRuleState == PushRuleState.notify
                    ? L10n.of(Get.context!)?.muteChat ?? ""
                    : L10n.of(Get.context!)?.unmuteChat ?? "",
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: ChatContextAction.markUnread,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                room.markedUnread
                    ? Icons.mark_as_unread
                    : Icons.mark_as_unread_outlined,
              ),
              const SizedBox(width: 12),
              Text(
                room.markedUnread
                    ? L10n.of(Get.context!)?.markAsRead ?? ""
                    : L10n.of(Get.context!)?.markAsUnread ?? "",
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: ChatContextAction.favorite,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(room.isFavourite ? Icons.push_pin : Icons.push_pin_outlined),
              const SizedBox(width: 12),
              Text(
                room.isFavourite
                    ? L10n.of(Get.context!)?.unpin ?? ""
                    : L10n.of(Get.context!)?.pin ?? "",
              ),
            ],
          ),
        ),
        if (spacesWithPowerLevels.isNotEmpty)
          PopupMenuItem(
            value: ChatContextAction.addToSpace,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.group_work_outlined),
                const SizedBox(width: 12),
                Text(L10n.of(Get.context!)?.addToSpace ?? ""),
              ],
            ),
          ),
        PopupMenuItem(
          value: ChatContextAction.leave,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.delete_outlined),
              const SizedBox(width: 12),
              Text(L10n.of(Get.context!)?.leave ?? ""),
            ],
          ),
        ),
      ],
    );

    if (action == null) return;
    if (!mounted) return;

    switch (action) {
      case ChatContextAction.open:
        onChatTap(room);
        return;
      case ChatContextAction.goToSpace:
        setActiveSpace(space!.id);
        return;
      case ChatContextAction.favorite:
        await showFutureLoadingDialog(
          context: context,
          future: () => room.setFavourite(!room.isFavourite),
        );
        return;
      case ChatContextAction.markUnread:
        await showFutureLoadingDialog(
          context: context,
          future: () => room.markUnread(!room.markedUnread),
        );
        return;
      case ChatContextAction.mute:
        await showFutureLoadingDialog(
          context: context,
          future: () => room.setPushRuleState(
            room.pushRuleState == PushRuleState.notify
                ? PushRuleState.mentionsOnly
                : PushRuleState.notify,
          ),
        );
        return;
      case ChatContextAction.leave:
        final confirmed = await showOkCancelAlertDialog(
          useRootNavigator: false,
          context: context,
          title: L10n.of(Get.context!)?.areYouSure ?? "",
          okLabel: L10n.of(Get.context!)?.leave ?? "",
          cancelLabel: L10n.of(Get.context!)?.no ?? "",
          message: L10n.of(Get.context!)?.archiveRoomDescription ?? "",
          isDestructiveAction: true,
        );
        if (confirmed == OkCancelResult.cancel) return;
        if (!mounted) return;

        await showFutureLoadingDialog(context: context, future: room.leave);

        return;
      case ChatContextAction.addToSpace:
        final space = await showConfirmationDialog(
          context: context,
          title: L10n.of(Get.context!)?.space ?? "",
          actions: spacesWithPowerLevels
              .map(
                (space) => AlertDialogAction(
                  key: space,
                  label: space.getLocalizedDisplayname(),
                ),
              )
              .toList(),
        );
        if (space == null) return;
        await showFutureLoadingDialog(
          context: context,
          future: () => space.setSpaceChild(room.id),
        );
    }
  }

  void callSyncData() async {
    var data = await ApiManager().callGetApi(
        endPoint:
            '${ApiConfig.syncEndpoint}?filter=0&since=s1901_3007047_170_1455_2489_12_4660_862_0_2&full_state=true&set_presence=online&timeout=30000',
        isLoading: false);
    print('sync data => $data');
    if (data['error'] != '' && data['error'] != null) {
      AppDialogs.showSnackBar(
          title: L10n.of(Get.context!)?.error ?? "",
          message: data["error"].toString().tr);
    } else {
      chatListDummyData.value = data;
    }
  }
}
