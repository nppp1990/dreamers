import 'package:dreamer/page/chat/chat_config.dart';
import 'package:dreamer/page/chat/test_data.dart';
import 'package:flutter/material.dart';

import 'chat_controller.dart';
import 'chat_listview.dart';
import 'edit_tool.dart';
import 'models/message.dart';

class ChatView extends StatefulWidget {
  // static const double avatarSize = 40;
  // static const double avatarMargin = 5;
  // static const double listViewPadding = 20;

  final ChatConfig chatConfig;

  const ChatView({super.key, required this.chatConfig});

  @override
  State<StatefulWidget> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  late ChatController _chatController;

  @override
  void initState() {
    super.initState();
    _chatController = ChatController(scrollController: ScrollController(), chatConfig: widget.chatConfig);
    _chatController.init(TestData.testList);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenWidth = MediaQuery.sizeOf(context).width;
      final horizontalImageWidth = screenWidth / 2 - config.listviewPadding - config.avatarSize - config.avatarMargin;
      _chatController.initImageSize(horizontalImageWidth, horizontalImageWidth * 0.7);
    });
  }

  ChatConfig get config => widget.chatConfig;

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.viewInsetsOf(context);
    final viewPadding = MediaQuery.viewPaddingOf(context);
    final bottomPadding = viewInsets.bottom == 0 ? viewPadding.bottom : 0.0;
    return Stack(children: [
      SingleChildScrollView(
        controller: _chatController.scrollController,
        reverse: true,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(left: config.listviewPadding, right: config.listviewPadding),
              child: GestureDetector(
                onTap: () {
                  _onListTap();
                },
                child: ChatListView(
                  senderAvatar: TestData.myAvatar,
                  receiverAvatar: TestData.otherAvatar,
                  data: TestData.testList,
                  chatController: _chatController,
                ),
              ),
            ),
            SizedBox(height: config.editToolConfig.height + bottomPadding),
          ],
        ),
      ),
      Align(
          alignment: Alignment.bottomCenter,
          child: EditToolView(
            controller: _chatController,
            onSend: (value, isImage) {
              _chatController.addMessage(
                  Message(text: value, isSender: true, type: isImage ? MessageType.localImage : MessageType.text));
            },
          )),
    ]);
  }

  _onListTap() {
    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }
}
