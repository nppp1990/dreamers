import 'package:dreamer/constants/colors.dart';
import 'package:flutter/material.dart';

class UpdateInfo {
  final String title;
  final String content;
  final int time;

  UpdateInfo({required this.title, required this.content, required this.time});
}

final testUpdateInfoList = [
  UpdateInfo(
    title: 'Announcement!',
    content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
        'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
        'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. '
        'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum ...',
    time: 123,
  ),
  UpdateInfo(
    title: 'fixes',
    content: '1. Fix\n2. Fix 2',
    time: 123,
  ),
  // UpdateInfo(
  //   title: 'Update3',
  //   content: 'Content3',
  //   time: 123,
  // ),
  // UpdateInfo(
  //   title: 'Update4',
  //   content: 'Content4',
  //   time: 123,
  // ),
  // UpdateInfo(
  //   title: 'Update5',
  //   content: 'Content5',
  //   time: 123,
  // ),
];

class UpdateInfoList extends StatelessWidget {
  const UpdateInfoList({super.key});

  @override
  Widget build(BuildContext context) {
    final data = testUpdateInfoList;
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
                  Image.asset(
                    'assets/images/icons/dreamer.png',
                    width: 36,
                    height: 36,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    item.title,
                    style: const TextStyle(
                        fontSize: 13, height: 15.6 / 13, fontWeight: FontWeight.w500, color: DreamerColors.grey800),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  Text(
                    item.content,
                    style: const TextStyle(
                        fontSize: 13, height: 15.6 / 13, fontWeight: FontWeight.w500, color: DreamerColors.grey800),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
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

  _buildTimeView(UpdateInfo item) {
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
