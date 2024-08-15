import 'dart:io';

enum MessageType {
  text,
  image,
  localImage,
}

extension MessageTypeExtension on MessageType {
  String get name {
    switch (this) {
      case MessageType.text:
        return 'text';
      case MessageType.image:
        return 'image';
      case MessageType.localImage:
        return 'localImage';
    }
  }
}

class Message {
  int? id;
  bool isSender;
  final MessageType type;
  final String? text;

  Message({
    this.id,
    required this.isSender,
    this.type = MessageType.text,
    this.text,
  });
}
