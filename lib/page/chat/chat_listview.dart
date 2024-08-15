import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'chat_config.dart';
import 'chat_controller.dart';
import 'models/list_item.dart';
import 'models/message.dart';

class ChatListView extends StatelessWidget {
  final String senderAvatar;
  final String receiverAvatar;
  final List<ListItem> data;
  final ChatController chatController;

  const ChatListView(
      {super.key,
      required this.data,
      required this.chatController,
      required this.senderAvatar,
      required this.receiverAvatar});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: chatController.messageStreamController.stream,
      builder: (BuildContext context, AsyncSnapshot<List<ListItem>> snapshot) {
        if (snapshot.hasData) {
          return _buildListView(snapshot.data!);
        } else {
          return const SizedBox();
        }
      },
    );
  }

  _buildListView(List<ListItem> data) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: data.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return ListItemView(
          chatController: chatController,
          item: data[index],
          myAvatar: senderAvatar,
          otherAvatar: receiverAvatar,
        );
      },
    );
  }
}

class ListItemView extends StatelessWidget {
  final ChatController chatController;
  final ListItem item;
  final String myAvatar;
  final String otherAvatar;

  const ListItemView({
    super.key,
    required this.chatController,
    required this.item,
    required this.myAvatar,
    required this.otherAvatar,
  });

  get avatarSize => chatController.chatConfig.avatarSize;

  get avatarMargin => chatController.chatConfig.avatarMargin;

  get senderBackgroundColor => chatController.chatConfig.senderBackgroundColor;

  get receiverBackgroundColor => chatController.chatConfig.receiverBackgroundColor;

  @override
  Widget build(BuildContext context) {
    switch (item.type) {
      case ListItemType.message:
        Widget contentView;
        final Message message = item.message!;
        switch (message.type) {
          case MessageType.text:
            contentView = TextMessageView(
              chatController: chatController,
              isSender: message.isSender,
              text: message.text!,
              backgroundColor: message.isSender ? senderBackgroundColor : receiverBackgroundColor,
            );
          case MessageType.image:
            contentView = ImageMessageView(
              chatController: chatController,
              path: message.text!,
              isSender: message.isSender,
              isLocal: false,
            );
          case MessageType.localImage:
            contentView = ImageMessageView(
              chatController: chatController,
              path: message.text!,
              isSender: message.isSender,
              isLocal: true,
            );
        }
        return _buildItem(contentView, !message.isSender);
      case ListItemType.time:
        return Text('Time: ${item.time}');
      case ListItemType.tips:
        return Text('Tips: ${item.tips}');
    }
  }

  Widget _buildItem(Widget contentView, bool isLeft) {
    return Padding(
      padding: EdgeInsets.only(bottom: chatController.chatConfig.messageGap),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        if (isLeft) ...[
          _buildAvatar(otherAvatar),
          SizedBox(width: avatarMargin),
          Expanded(child: contentView),
          SizedBox(width: avatarMargin + avatarSize),
        ] else ...[
          SizedBox(width: avatarMargin + avatarSize),
          Expanded(child: contentView),
          SizedBox(width: avatarMargin),
          _buildAvatar(myAvatar),
        ],
      ]),
    );
  }

  Widget _buildAvatar(String avatar) {
    return CircleAvatar(
      radius: avatarSize / 2,
      backgroundImage: NetworkImage(avatar),
    );
  }
}

class ImageMessageView extends StatelessWidget {
  final ChatController chatController;
  final String path;
  final bool isLocal;
  final bool isSender;

  const ImageMessageView(
      {super.key, required this.chatController, required this.path, required this.isSender, this.isLocal = true});

  @override
  Widget build(BuildContext context) {
    Image image;
    if (isLocal) {
      image = Image.file(File(path));
    } else {
      image = Image.network(path);
    }
    final Completer<double> completer = Completer();
    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo info, bool _) {
        final double aspectRatio = info.image.width.toDouble() / info.image.height.toDouble();
        completer.complete(aspectRatio);
      }),
    );
    return FutureBuilder<double>(
        future: completer.future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            bool isHorizontal = snapshot.data! > 1;
            final width = isHorizontal ? chatController.horizontalImageWidth : chatController.verticalImageWidth;
            final height = isHorizontal ? width / 2 : width * 2;
            return Align(
              alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
              // 图片的宽度高度是固定的
              child: Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(chatController.chatConfig.messageRadius),
                  image: DecorationImage(
                    image: image.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          } else {
            // todo
            return const SizedBox();
          }
        });
  }
}

class TextMessageView extends StatelessWidget {
  final ChatController chatController;
  final bool isSender;
  final String text;
  final Color backgroundColor;

  const TextMessageView({
    super.key,
    required this.chatController,
    this.isSender = true,
    required this.text,
    required this.backgroundColor,
  });

  ChatConfig get _config => chatController.chatConfig;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: chatController.chatConfig.messagePadding,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(_config.messageRadius),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: _config.messageFontSize,
            height: _config.messageFontHeight,
            color: isSender ? _config.senderMessageTextColor : _config.receiverMessageTextColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
