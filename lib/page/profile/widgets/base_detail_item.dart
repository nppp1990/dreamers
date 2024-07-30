import 'package:dreamer/constants/colors.dart';
import 'package:dreamer/data/dreamer_icons.dart';
import 'package:flutter/material.dart';

mixin BaseDetailItemMixin {
  bool get edit;

  bool get isRightArrow => true;

  String get title;

  Widget build(BuildContext context) {
    if (edit) {
      return _EditItemWithArrow(
        isRightArrow: isRightArrow,
        onTap: () {
          onTap(context);
        },
        child: DetailItem(title: title, child: buildChild(context)),
      );
    } else {
      return DetailItem(title: title, child: buildChild(context));
    }
  }

  Widget buildChild(BuildContext context);

  void onTap(BuildContext context);
}

/// profile detail item with title
class DetailItem extends StatelessWidget {
  final String title;
  final Widget child;

  const DetailItem({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'SF Pro Text',
            fontSize: 15,
            height: 18 / 15,
            fontWeight: FontWeight.w700,
            color: DreamerColors.primary,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        child,
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }
}

class _EditItemWithArrow extends StatelessWidget {
  final bool isRightArrow;
  final VoidCallback onTap;
  final Widget child;

  const _EditItemWithArrow({this.isRightArrow = true, required this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    Widget arrow;
    if (isRightArrow) {
      arrow = const Padding(
        padding: EdgeInsets.only(left: 8),
        child: Icon(
          size: 24,
          DreamerIcons.arrowRight,
          color: DreamerColors.grey600,
        ),
      );
    } else {
      arrow = const SizedBox(
        width: 24,
        height: 8,
        child: Icon(
          DreamerIcons.arrowDown,
          color: DreamerColors.grey600,
        ),
      );
    }
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: child),
          arrow,
        ],
      ),
    );
  }
}
