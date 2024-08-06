import 'package:dreamer/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
                _SearchView(),
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
  static const testData = <ChatItemInfo>[
    ChatItemInfo(
      name: 'Jone Doe',
      avatar: 'https://pic1.zhimg.com/v2-d24a84ea4ea3e152f5eb035b736caf97_r.jpg',
      content: 'Oh i don\'t like fish 🙈',
      unreadCount: 2,
    ),
    ChatItemInfo(
      name: 'Shreya',
      avatar: 'https://img.aigexing.com/uploads/9/1253/3315803060/92902931067/61746198.jpg',
      content: 'Can we go somewhere? ',
      unreadCount: 1,
    ),
    ChatItemInfo(
      name: 'name3',
      avatar: 'https://picx.zhimg.com/v2-86c411ee09650ce48ab40eee88a82a5a_r.jpg',
      content: 'test content',
      unreadCount: 2,
    ),
    ChatItemInfo(
      name: 'name4',
      avatar: 'https://img2.woyaogexing.com/2021/03/02/395e91b43ac74217935de343600ea51b%21400x400.jpeg',
      content: 'test content',
      unreadCount: 0,
    ),
    ChatItemInfo(
      name: 'name5',
      avatar: 'https://picx.zhimg.com/v2-13b79479d87b35fc328c35fabb275aaa_r.jpg',
      content: 'You: He thinks it’s overall ok. But it should be more colorful. test very long content. test very long content test very long content test very long content test very long content  ',
      unreadCount: 12,
    ),
    ChatItemInfo(
      name: 'name6',
      avatar: 'https://c-ssl.dtstatic.com/uploads/blog/202103/04/20210304093424_67c7e.thumb.1000_0.jpg',
      content: 'test content',
      unreadCount: 3,
    ),
    ChatItemInfo(
      name: 'name7',
      avatar: 'https://lmg.jj20.com/up/allimg/tx29/081511214242611372.jpg',
      content: 'test content',
      unreadCount: 12,
    ),
    ChatItemInfo(
      name: 'name8',
      avatar: 'https://img2.woyaogexing.com/2021/03/02/411c00abc54446d99eb4c933578d06bf%21400x400.jpeg',
      content: 'test content',
      unreadCount: 0,
    ),
    ChatItemInfo(
      name: 'name9',
      avatar: 'https://picx.zhimg.com/v2-13b79479d87b35fc328c35fabb275aaa_r.jpg',
      content: 'test content',
      unreadCount: 0,
    ),
    ChatItemInfo(
      name: 'name10',
      avatar: 'https://c-ssl.dtstatic.com/uploads/blog/202103/04/20210304093424_67c7e.thumb.1000_0.jpg',
      content: 'test content',
      unreadCount: 1,
    ),
    ChatItemInfo(
      name: 'name11',
      avatar: 'https://lmg.jj20.com/up/allimg/tx29/081511214242611372.jpg',
      content: 'test content',
      unreadCount: 111,
    ),
    ChatItemInfo(
      name: 'name12',
      avatar: 'https://img2.woyaogexing.com/2021/03/02/411c00abc54446d99eb4c933578d06bf%21400x400.jpeg',
      content: 'test content',
      unreadCount: 0,
    ),


  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
      itemBuilder: (context, index) {
        return _buildChatItem(testData[index]);
      },
      itemCount: testData.length,
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
              // 圆形
              decoration: BoxDecoration(
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
