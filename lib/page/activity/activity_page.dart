import 'package:dreamer/common/widget/tab_header.dart';
import 'package:dreamer/page/activity/notification_list.dart';
import 'package:dreamer/page/activity/update_list.dart';
import 'package:flutter/material.dart';

class HomeActivityPage extends StatelessWidget {
  const HomeActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.viewPaddingOf(context).top;
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg_base1.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: statusBarHeight),
        child: const ActivityView(),
      ),
    );
  }
}

class ActivityView extends StatefulWidget {
  const ActivityView({super.key});

  @override
  State<ActivityView> createState() => _ActivityViewState();
}

class _ActivityViewState extends State<ActivityView> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 36,
              child: Center(
                child: Text(
                  'Activity',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _TabPersistentDelegate(
                height: 23 + 12,
                child: Container(
                  color: const Color(0xFFC3C5D2),
                  padding: const EdgeInsets.only(bottom: 12),
                  child: TabHeader(
                    tabController: _tabController,
                    tabs: const ['Notifications', 'What\'s new'],
                    height: 23,
                  ),
                )),
          ),
        ];
      },
      body: TabBarView(
        controller: _tabController,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: const NotificationList(),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: const UpdateInfoList(),
          ),
        ],
      ),
    );
  }
}

class _TabPersistentDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;

  _TabPersistentDelegate({required this.child, required this.height});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
