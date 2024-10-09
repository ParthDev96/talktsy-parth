import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  var messages = <Map<String, dynamic>>[].obs;
  var suggestionMessages = <Map<String, dynamic>>[].obs;
  TextEditingController messageTextController = TextEditingController();
  var messageText = ''.obs;
  var isEmojiVisible = false.obs;
  RxBool editImage = false.obs;
  File? pickImageFiles;

  @override
  void onInit() {
    super.onInit();
    messageTextController.addListener(() {
      messageText.value = messageTextController.text;
    });
    // fetchMessages();
    fetchSuggestionMessages();
  }

  void toggleEmojiKeyboard() {
    isEmojiVisible.value = !isEmojiVisible.value;
    if (isEmojiVisible.value) {
      FocusManager.instance.primaryFocus?.unfocus();
    } else {
      FocusManager.instance.primaryFocus?.requestFocus();
    }
  }

  void hideEmojiKeyboard() {
    isEmojiVisible.value = false;
  }

  void onEmojiSelected(Emoji emoji) {
    messageTextController.text += emoji.emoji;
    messageText.value = messageTextController.text;
  }

  void fetchMessages() {
    bool isCurrentUser = true;
    String text = '4546 4654 321 3265';
    messages.insert(
        0, {'message': text, 'type': 'text', 'isCurrentUser': isCurrentUser});
    messages
        .insert(0, {'message': text, 'type': 'text', 'isCurrentUser': false});
    messages.insert(0, {
      'message': '$text😜 😍😜 😍',
      'type': 'text',
      'isCurrentUser': isCurrentUser
    });
    messages.insert(0, {
      'message': '$text😜 😍😜 😍',
      'type': 'image',
      'isCurrentUser': isCurrentUser
    });
    messages
        .insert(0, {'message': 'text', 'type': 'text', 'isCurrentUser': false});
    messages.insert(
        0, {'message': 'text', 'type': 'video', 'isCurrentUser': false});
    messages.insert(
        0, {'message': text, 'type': 'text', 'isCurrentUser': isCurrentUser});
    messages.insert(
        0, {'message': '😜 😍😜 😍', 'type': 'text', 'isCurrentUser': false});
  }

  void fetchSuggestionMessages() {
    suggestionMessages.insert(0, {
      'message': 'Hi, there',
    });
    suggestionMessages.insert(0, {
      'message': 'How are you?',
    });
    suggestionMessages.insert(0, {
      'message': 'Hey 😁',
    });
    suggestionMessages.insert(0, {
      'message': 'Hello',
    });
    suggestionMessages.insert(0, {
      'message': 'Hi, there',
    });
    suggestionMessages.insert(0, {
      'message': 'I am good',
    });
    suggestionMessages.insert(0, {
      'message': 'Thanks',
    });
    suggestionMessages.insert(0, {
      'message': 'Good',
    });
    suggestionMessages.insert(0, {
      'message': 'Hey 😁',
    });
  }

  void sendMessage(bool isCurrentUser) {
    if (messageTextController.text.isNotEmpty) {
      messages.insert(0, {
        'message': messageTextController.text,
        'type': 'text',
        'isCurrentUser': isCurrentUser
      });
      messageTextController.clear();
      hideEmojiKeyboard();
    }
  }

  void sendSuggestionMessage(String text) {
    messages
        .insert(0, {'message': text, 'type': 'text', 'isCurrentUser': true});
    messageTextController.clear();
    hideEmojiKeyboard();
  }

  void onSendImageMessage(File file) {
    messages
        .insert(0, {'message': file, 'type': 'image', 'isCurrentUser': true});
  }
}
