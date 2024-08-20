import 'package:flutter/material.dart';

class BubbleGuideDialog extends StatelessWidget {
  final String message;
  final Offset offset;

  const BubbleGuideDialog({
    super.key,
    required this.message,
    required this.offset,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding: EdgeInsets.zero,
      duration: const Duration(milliseconds: 100),
      curve: Curves.decelerate,
      child: Stack(
        children: [
          Positioned(
            bottom: MediaQuery.sizeOf(context).height- offset.dy,
            left: offset.dx,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 240,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  message,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    height: 17.3 / 12,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

showBubbleGuideDialog(BuildContext context, Offset offset, String message) {
  return showDialog(
    context: context,
    useSafeArea: false,
    builder: (BuildContext context) {
      return BubbleGuideDialog(
        message: message,
        offset: offset,
      );
    },
  );
}
