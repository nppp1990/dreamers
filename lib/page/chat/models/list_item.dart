import 'message.dart';

enum ListItemType {
  message,
  time,
  tips,
}

class ListItem {
  final ListItemType type;
  final Message? message;
  final String? tips;
  final DateTime? time;

  ListItem({
    this.type = ListItemType.message,
    this.message,
    this.tips,
    this.time,
  });
}
