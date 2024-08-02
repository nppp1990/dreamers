import 'package:dreamer/constants/colors.dart';
import 'package:flutter/material.dart';

enum NotificationType {
  recommendation,
  liked,
  likeEachOther,
}

class NotificationData {
  final NotificationType type;
  final int time;

  /// just for [NotificationType.liked] and [NotificationType.likeEachOther]
  final String? otherUser;
  final List<String> avatarList;

  /// just for [NotificationType.recommendation]
  final int? recommendedNumber;

  NotificationData({
    required this.type,
    required this.time,
    this.otherUser,
    required this.avatarList,
    this.recommendedNumber,
  });
}

final List<NotificationData> testNotificationData = [
  NotificationData(
    type: NotificationType.recommendation,
    time: 123,
    avatarList: ['https://lmg.jj20.com/up/allimg/tx29/081511214242611372.jpg'],
    recommendedNumber: 4,
  ),
  NotificationData(
    type: NotificationType.liked,
    time: 123,
    avatarList: ['https://wx3.sinaimg.cn/mw690/007gDraegy1hqefo9yif6j30io0io76g.jpg'],
    otherUser: 'Alice',
  ),
  NotificationData(
    type: NotificationType.likeEachOther,
    time: 123,
    avatarList: [
      'https://lmg.jj20.com/up/allimg/tx29/081511214242611372.jpg',
      'https://wx3.sinaimg.cn/mw690/007gDraegy1hqefo9yif6j30io0io76g.jpg',
    ],
    otherUser: 'John',
  ),
  NotificationData(
    type: NotificationType.recommendation,
    time: 123,
    avatarList: [
      'https://lmg.jj20.com/up/allimg/tx29/081511214242611372.jpg',
    ],
    recommendedNumber: 9,
  ),
  NotificationData(
    type: NotificationType.liked,
    time: 123,
    avatarList: ['https://ww4.sinaimg.cn/mw690/007QvzfIly1hq0nh7naojj30u00s848b.jpg'],
    otherUser: 'Bob',
  ),
  NotificationData(
    type: NotificationType.likeEachOther,
    time: 123,
    avatarList: [
      'https://lmg.jj20.com/up/allimg/tx29/081511214242611372.jpg',
      'https://pic1.zhimg.com/v2-d24a84ea4ea3e152f5eb035b736caf97_r.jpg',
    ],
    otherUser: 'Lucy',
  ),
];

class NotificationList extends StatelessWidget {
  const NotificationList({super.key});

  @override
  Widget build(BuildContext context) {
    final data = testNotificationData;
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: data.length,
      itemBuilder: (context, index) {
        final item = data[index];
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAvatarView(item.avatarList),
                  const SizedBox(height: 8),
                  _buildContentView(item),
                  const SizedBox(height: 8),
                  _buildTimeView(item),
                ],
              ),
            ),
            const Divider(
              height: 1,
              thickness: 1,
              color: DreamerColors.divider3,
            ),
          ],
        );
      },
    );
  }

  _buildAvatarView(final List<String> avatarList) {
    if (avatarList.length == 1) {
      return Padding(
        padding: const EdgeInsets.all(2.0),
        child: CircleAvatar(
          radius: 16,
          backgroundImage: NetworkImage(avatarList[0]),
        ),
      );
    } else {
      return SizedBox(
        height: 36,
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
              left: 2,
              top: 2,
              child: CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(avatarList[0]),
              ),
            ),
            Positioned(
              left: 32,
              top: 2,
              child: CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(avatarList[1]),
              ),
            ),
          ],
        ),
      );
    }
  }

  _buildContentView(NotificationData item) {
    // todo content need to be implemented
    String content;
    switch (item.type) {
      case NotificationType.recommendation:
        bool isToday = (DateTime.now().millisecondsSinceEpoch - item.time) < 24 * 60 * 60 * 1000;
        content = '${item.recommendedNumber!} people are recommended for you ${isToday ? 'today' : ''}!';
        break;
      case NotificationType.liked:
        content = '${item.otherUser!} liked you!';
        break;
      case NotificationType.likeEachOther:
        content = 'You and ${item.otherUser!} liked and matched each other!';
        break;
    }
    return Text(
      content,
      style: const TextStyle(
        fontSize: 13,
        height: 15.6 / 13,
        fontWeight: FontWeight.w500,
        color: DreamerColors.grey800,
      ),
    );
  }

  _buildTimeView(NotificationData item) {
    // todo implement this by the format of time
    String timeStr;
    int random = 1 + (DateTime.now().millisecondsSinceEpoch % 4);
    if (random == 1) {
      timeStr = '5h';
    } else if (random == 2) {
      timeStr = 'February 10';
    } else if (random == 3) {
      timeStr = 'February 10';
    } else {
      timeStr = 'February 10';
    }
    return Text(
      timeStr,
      style: const TextStyle(
        fontSize: 12,
        height: 14.4 / 12,
        fontWeight: FontWeight.w500,
        color: DreamerColors.grey600,
      ),
    );
  }
}
