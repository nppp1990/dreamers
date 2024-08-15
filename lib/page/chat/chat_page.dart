import 'package:dreamer/data/dreamer_icons.dart';
import 'package:dreamer/page/chat/chat_config.dart';
import 'package:dreamer/page/chat/chat_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<StatefulWidget> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg_base1.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            _ChatHeader(),
            const Expanded(child: ChatView(chatConfig: ChatConfig())),
          ],
        ),
      ),
    );
  }
}

class _ChatHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.viewPaddingOf(context).top;
    return Padding(
      padding: EdgeInsets.only(left: 8, right: 8, top: statusBarHeight),
      child: SizedBox(
        height: 36,
        width: double.infinity,
        child: Row(
          children: [
            GestureDetector(
                child: const Icon(
                  DreamerIcons.arrowLeft,
                  color: Colors.black,
                  size: 24,
                ),
                onTap: () {
                  Navigator.pop(context);
                }),
            const Text(
              'Jone Doe',
              style: TextStyle(
                fontSize: 16,
                height: 20 / 16,
                fontWeight: FontWeight.w700,
                color: Colors.black,
                fontFamily: 'Roboto',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
