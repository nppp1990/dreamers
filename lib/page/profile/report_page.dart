import 'package:dreamer/common/widget/bg_page.dart';
import 'package:dreamer/common/widget/page_header.dart';
import 'package:dreamer/constants/colors.dart';
import 'package:flutter/material.dart';

class ProfileReportPage extends StatelessWidget {
  const ProfileReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageBackground(
      assetImage: const AssetImage('assets/images/bg_base1.png'),
      child: Column(
        children: [
          const NormalHeader(title: 'Report'),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Reason',
                    style: TextStyle(
                      fontSize: 12,
                      height: 14.4 / 12,
                      fontWeight: FontWeight.w400,
                      color: DreamerColors.grey800,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  constraints: const BoxConstraints(maxHeight: 240, minHeight: 140),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: DreamerColors.secondary, width: 1),
                  ),
                  child: const TextField(
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      // hintText: 'Enter reason',
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 35,
                  width: 103,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(0),
                      backgroundColor: DreamerColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
