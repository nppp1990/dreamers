
import 'dart:math';

import 'chat_list_page.dart';
import 'models/list_item.dart';
import 'models/message.dart';

final class TestData {
  static const chatItemList = <ChatItemInfo>[
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
      content:
      'You: He thinks it’s overall ok. But it should be more colorful. test very long content. test very long content test very long content test very long content test very long content  ',
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


  static const String myAvatar = 'https://pic1.zhimg.com/v2-d24a84ea4ea3e152f5eb035b736caf97_r.jpg';
  static const String otherAvatar =
      'https://picx.zhimg.com/v2-86c411ee09650ce48ab40eee88a82a5a_r.jpg';

  static final List<ListItem> testList = [
    ListItem(
        message: Message(id: 1, isSender: true, type: MessageType.text, text: 'Hi!'),
        time: DateTime.now()),
    ListItem(
        message: Message(id: 2, isSender: false, type: MessageType.text, text: 'Hello!'),
        time: DateTime.now()),
    ListItem(
        message: Message(
            id: 3,
            isSender: true,
            type: MessageType.text,
            text: 'How are you?If the widget is likely to get rebuilt frequently due to the use of '
                'InheritedWidget]s, consider refactoring the stateless widget into multiple widgets, '
                'with the parts of the tree that change being pushed to the leaves. For example '
                'instead of building a tree with four widgets, the')),
    ListItem(message: Message(id: 4, isSender: true, type: MessageType.text, text: 'I am pompon')),
    ListItem(
        message: Message(
            id: 5,
            isSender: false,
            type: MessageType.image,
            text: 'https://picx.zhimg.com/v2-13b79479d87b35fc328c35fabb275aaa_r.jpg'),
        time: DateTime.now()),
    ListItem(
        message: Message(
            id: 55,
            isSender: true,
            type: MessageType.image,
            text: 'https://up.deskcity.org/pic/7d/ba/13/7dba136218f678eca6708d66fb751dc1.jpg')),
    ListItem(
        message: Message(id: 6, isSender: true, type: MessageType.text, text: 'Where are you?'),
        time: DateTime.now()),
    ListItem(type: ListItemType.tips, tips: 'You can send images, videos, and audio messages.'),
    ListItem(
        message: Message(id: 7, isSender: false, type: MessageType.text, text: 'I am at home!'),
        time: DateTime.now()),
    ListItem(
        message: Message(id: 8, isSender: true, type: MessageType.text, text: 'I am in the office'),
        time: DateTime.now()),
    ListItem(
        message: Message(id: 9, isSender: false, type: MessageType.text, text: 'I am in the park'),
        time: DateTime.now()),
    ListItem(
        message:
            Message(id: 10, isSender: true, type: MessageType.text, text: 'I am in the garden'),
        time: DateTime.now()),
    ListItem(
        message: Message(id: 11, isSender: false, type: MessageType.text, text: 'I am in the mall'),
        time: DateTime.now()),
    ListItem(
        message:
            Message(id: 12, isSender: true, type: MessageType.text, text: 'I am in the market'),
        time: DateTime.now()),
    ListItem(
        message:
            Message(id: 13, isSender: false, type: MessageType.text, text: 'I am in the school'),
        time: DateTime.now()),
    ListItem(
        message:
            Message(id: 14, isSender: true, type: MessageType.text, text: 'I am in the college'),
        time: DateTime.now()),
    ListItem(
        message: Message(
            id: 15, isSender: false, type: MessageType.text, text: 'I am in the university'),
        time: DateTime.now()),
    ListItem(
        message:
            Message(id: 16, isSender: true, type: MessageType.text, text: 'I am in the hospital'),
        time: DateTime.now()),
    ListItem(
        message:
            Message(id: 17, isSender: false, type: MessageType.text, text: 'I am in the clinic'),
        time: DateTime.now()),
    ListItem(
        message: Message(id: 18, isSender: true, type: MessageType.text, text: 'I am in the gym'),
        time: DateTime.now()),
    ListItem(
        message: Message(id: 19, isSender: false, type: MessageType.text, text: 'I am in the park'),
        time: DateTime.now()),
  ];

  static const List<String> testImages = [
    'https://pic1.zhimg.com/v2-d24a84ea4ea3e152f5eb035b736caf97_r.jpg',
    'https://picx.zhimg.com/v2-86c411ee09650ce48ab40eee88a82a5a_r.jpg',
    'https://img2.woyaogexing.com/2021/03/02/395e91b43ac74217935de343600ea51b%21400x400.jpeg',
    'https://img2.woyaogexing.com/2021/03/02/411c00abc54446d99eb4c933578d06bf%21400x400.jpeg',
    'https://picx.zhimg.com/v2-13b79479d87b35fc328c35fabb275aaa_r.jpg',
    'https://c-ssl.dtstatic.com/uploads/blog/202103/04/20210304093424_67c7e.thumb.1000_0.jpg',
    'https://img.aigexing.com/uploads/9/1253/3315803060/92902931067/61746198.jpg',
  ];

  static List<ListItem> generateList({int size = 5}) {
    return List.generate(size, (index) => generateRandomItem());
  }

  static List<Message> generateMessages({int size = 5}) {
    return List.generate(size, (index) => generateMessage());
  }

  static Message generateMessage() {
    Random random = Random();
    int id = random.nextInt(1000);
    if (id % 3 == 0) {
      String imageUrl = testImages[random.nextInt(testImages.length)];
      return Message(
        id: id,
        isSender: random.nextBool(),
        type: MessageType.image,
        text: imageUrl,
      );
    } else {
      return Message(
        id: id,
        isSender: random.nextBool(),
        type: MessageType.text,
        text: 'Random message ${Random().nextInt(1000)}',
      );
    }
  }

  static ListItem generateRandomItem() {
    Random random = Random();
    return ListItem(
      message: Message(
        id: random.nextInt(1000),
        isSender: random.nextBool(),
        type: MessageType.text,
        text: 'Random message ${Random().nextInt(1000)}',
      ),
      time: DateTime.now(),
    );
  }
}
