import 'package:dreamer/common/router/router_utils.dart';
import 'package:dreamer/common/utils/dialog_utils.dart';
import 'package:dreamer/constants/colors.dart';
import 'package:dreamer/page/chat/chat_page.dart';
import 'package:dreamer/page/quiz/quiz_page.dart';
import 'package:dreamer/request/bean/quiz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'test_data.dart';

class HomeChatListPage extends StatelessWidget {
  const HomeChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.viewPaddingOf(context).top;
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg_base1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
            padding: EdgeInsets.only(top: statusBarHeight),
            child: Column(
              children: [
                GestureDetector(
                    onTap: () {
                      // todo
                      // DialogUtils.showLoading(context);
                    },
                    child: _SearchView()),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: _ChatListView(),
                  ),
                ),
              ],
            )));
  }
}

final class ChatItemInfo {
  final String name;
  final String avatar;

  // todo show str by type
  final String content;
  final int unreadCount;

  const ChatItemInfo({required this.name, required this.avatar, required this.content, required this.unreadCount});
}

class _ChatListView extends StatelessWidget {
  List<ChatItemInfo> get data => TestData.chatItemList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
      itemBuilder: (context, index) {
        return InkWell(
            onTap: () {
              Navigator.of(context).push(Right2LeftRouter(child: const ChatPage()));
            },
            child: _buildChatItem(data[index]));
      },
      itemCount: data.length,
    );
  }

  Widget _buildChatItem(final ChatItemInfo item) {
    return SizedBox(
      height: 64 + 16,
      child: Row(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundImage: NetworkImage(item.avatar),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF4A4A4A),
                  ),
                ),
                const SizedBox(height: 2),
                SizedBox(
                  height: 30,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      item.content,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF9B9B9B),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          if (item.unreadCount > 0 && item.unreadCount < 10)
            Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                color: DreamerColors.primary,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  item.unreadCount.toString(),
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 14,
                    height: 1,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          else if (item.unreadCount >= 10)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              decoration: BoxDecoration(
                color: DreamerColors.primary,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                item.unreadCount.toString(),
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 14,
                  height: 1,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            )
        ],
      ),
    );
  }
}

class _SearchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 35,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            const Text(
              'Search chats',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 13,
                height: 15.2 / 13,
                fontWeight: FontWeight.w500,
                color: Color(0xFF898989),
              ),
            ),
            const Spacer(),
            SvgPicture.asset(
              'assets/images/icons/ic_search.svg',
              width: 24,
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}
