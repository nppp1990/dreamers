import 'package:dreamer/common/widget/wave_dots.dart';
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
  late ValueNotifier<bool> _isNextPageLoading;

  @override
  void initState() {
    super.initState();
    _isNextPageLoading = ValueNotifier<bool>(false);
    _chatController = ChatController(scrollController: ScrollController(), chatConfig: widget.chatConfig);
    _chatController.init(TestData.testList);
    _chatController.scrollController.addListener(_scrollChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenWidth = MediaQuery.sizeOf(context).width;
      final horizontalImageWidth = screenWidth / 2 - config.listviewPadding - config.avatarSize - config.avatarMargin;
      _chatController.initImageSize(horizontalImageWidth, horizontalImageWidth * 0.7);
    });
  }

  ChatConfig get config => widget.chatConfig;

  void _scrollChanged() {
    print('scrollChanged:${_chatController.scrollController.position.pixels}');
    if (_chatController.scrollController.position.pixels ==
        _chatController.scrollController.position.maxScrollExtent) {
      if (!_isNextPageLoading.value) {
        _loadMoreData();
      }
    }
  }

  _loadMoreData() async {
    _isNextPageLoading.value = true;
    await Future.delayed(const Duration(seconds: 4));
    if (_chatController.isDisposed) {
      return;
    }
    _isNextPageLoading.value = false;
    _chatController.addMessages(TestData.generateMessages());
  }

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
            ValueListenableBuilder(
                valueListenable: _isNextPageLoading,
                builder: (_, isNextPageLoading, child) {
                  if (isNextPageLoading) {
                    return const WaveDots(size: 30, color: Colors.black);
                  } else {
                    return const SizedBox.shrink();
                  }
                }),
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
              _onSend(value, isImage);
            },
          )),
    ]);
  }

  _onSend(String value, bool isImage) {
    _chatController.addMessage(Message(text: value, isSender: true, type: isImage ? MessageType.localImage : MessageType.text));
  }

  _onListTap() {
    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }
}
