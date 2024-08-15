import 'dart:async';

import 'package:dreamer/page/chat/chat_config.dart';
import 'package:flutter/material.dart';

import 'models/list_item.dart';
import 'models/message.dart';

class ChatController {
  final ChatConfig chatConfig;
  final ScrollController scrollController;
  final List<ListItem> data = [];

  late double horizontalImageWidth;
  late double verticalImageWidth;

  StreamController<List<ListItem>> messageStreamController = StreamController();

  ChatController({required this.scrollController, required this.chatConfig});

  dispose() {
    scrollController.dispose();
  }

  void initImageSize(double horizontalImageWidth, double verticalImageWidth) {
    this.horizontalImageWidth = horizontalImageWidth;
    this.verticalImageWidth = verticalImageWidth;
  }

  /// Function to init message list in chat view
  void init(List<ListItem> items) {
    data.addAll(items);
    if (!messageStreamController.isClosed) {
      messageStreamController.sink.add(items);
    }
    if (data.isNotEmpty) {
      scrollToLastMessage();
    }
  }

  void addMessage(Message message) {
    data.add(ListItem(
      type: ListItemType.message,
      message: message,
      time: DateTime.now(),
    ));
    if (!messageStreamController.isClosed) {
      messageStreamController.sink.add(data);
    }
    scrollToLastMessage();
  }

  /// Function to scroll to last messages in chat view
  void scrollToLastMessage() => Timer(
        const Duration(milliseconds: 300),
        () {
          if (!scrollController.hasClients) return;
          scrollController.animateTo(
            scrollController.position.minScrollExtent,
            curve: Curves.easeIn,
            duration: const Duration(milliseconds: 300),
          );
        },
      );
}
