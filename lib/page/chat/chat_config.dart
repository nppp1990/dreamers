import 'package:dreamer/constants/colors.dart';
import 'package:flutter/material.dart';

final class ChatConfig {
  final EditToolConfig editToolConfig;

  final double messageGap;
  final double messageFontSize;
  final double messageFontHeight;
  final Color senderMessageTextColor;
  final Color receiverMessageTextColor;

  final double listviewPadding;
  final double avatarSize;
  final double avatarMargin;
  final double messageRadius;
  final EdgeInsetsGeometry messagePadding;
  final Color senderBackgroundColor;
  final Color receiverBackgroundColor;

  const ChatConfig({
    this.editToolConfig = const EditToolConfig(),
    this.messageGap = 8,
    this.messageFontSize = 13,
    this.messageFontHeight = 15 / 13,
    this.senderMessageTextColor = Colors.white,
    this.receiverMessageTextColor = Colors.black,
    this.listviewPadding = 16,
    this.avatarSize = 31,
    this.avatarMargin = 4,
    this.messageRadius = 16,
    this.messagePadding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    this.senderBackgroundColor = DreamerColors.primary,
    this.receiverBackgroundColor = Colors.white,
  });
}

final class EditToolConfig {
  final double height;
  final double editHorizontalPadding;
  final double iconSize;

  const EditToolConfig({
    this.height = 51,
    this.editHorizontalPadding = 16,
    this.iconSize = 24,
  });
}
