import 'package:dreamer/constants/colors.dart';
import 'package:flutter/material.dart';

/// Tab header
/// default height is 23
class TabHeader extends StatelessWidget {
  final TabController tabController;
  final List<String> tabs;
  final double height;

  const TabHeader({super.key, required this.tabController, required this.tabs, this.height = 23});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TabBar(
        dividerColor: Colors.transparent,
        indicatorSize: TabBarIndicatorSize.label,
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(
            width: 2,
            color: DreamerColors.primary,
          ),
          insets: EdgeInsets.symmetric(horizontal: 7),
        ),
        controller: tabController,
        labelStyle: const TextStyle(
          fontSize: 14,
          height: 16.71 / 14,
          color: Colors.black,
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 14,
          height: 16.71 / 14,
          fontWeight: FontWeight.w500,
        ),
        tabs: [
          for (final tab in tabs) Tab(text: tab),
        ],
      ),
    );
  }
}
