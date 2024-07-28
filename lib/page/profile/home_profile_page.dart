import 'package:dreamer/constants/colors.dart';
import 'package:dreamer/data/dreamer_icons.dart';
import 'package:dreamer/page/profile/profile_detail.dart';
import 'package:flutter/material.dart';

class HomeProfilePage extends StatelessWidget {
  const HomeProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg_base1.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: statusBarHeight),
        child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
          print(
              '----constraints.maxHeight: ${constraints.maxHeight}---constraints.maxWidth: ${constraints.maxWidth}---');
          return const ProfileView();
        }),
      ),
    );
  }
}

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> with SingleTickerProviderStateMixin {
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: _ItemHeader(showSetting: false),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: _InfoHeader(),
        ),
        _TabHeader(tabController: _tabController),
        const SizedBox(height: 12),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: TabBarView(
              controller: _tabController,
              children: const [
                SingleChildScrollView(child: ProfileDetail()),
                SingleChildScrollView(
                  child: Column(children: [
                    SizedBox(height: 200),
                    Text('p1'),
                    SizedBox(height: 200),
                    Text('p2'),
                    SizedBox(height: 200),
                    Text('p3'),
                    SizedBox(height: 200),
                    Text('p4'),
                    SizedBox(height: 200),
                    Text('p5'),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ItemHeader extends StatelessWidget {
  final bool showSetting;

  const _ItemHeader({super.key, required this.showSetting});

  @override
  Widget build(BuildContext context) {
    if (showSetting) {
      return SizedBox(
        height: 36,
        width: double.infinity,
        child: Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            child: Image.asset('assets/images/icons/ic_setting.png', width: 24, height: 24),
            onTap: () {
              // todo setting
            },
          ),
        ),
      );
    } else {
      return SizedBox(
          height: 36,
          width: double.infinity,
          // 左右各一个icon
          child: Row(children: [
            GestureDetector(
                child: const Icon(
                  DreamerIcons.arrowLeft,
                  color: Color(DreamerColors.primary),
                  size: 24,
                ),
                onTap: () {
                  Navigator.pop(context);
                }),
            const Spacer(),
            GestureDetector(
                onTap: () {
                  // todo more
                },
                child: Image.asset(
                  'assets/images/icons/ic_menu_more.png',
                  width: 24,
                  height: 24,
                )),
          ]));
    }
  }
}

class _InfoHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('John Doe',
                style: TextStyle(
                  fontFamily: 'SF Pro Text',
                  color: Colors.black,
                  fontSize: 24,
                  height: 28 / 24,
                  fontWeight: FontWeight.w700,
                )),
            SizedBox(height: 4),
            Text('Hello! I’m John.',
                style: TextStyle(
                  fontFamily: 'SF Pro Text',
                  color: Color(DreamerColors.grey800),
                  fontSize: 12,
                  height: 14 / 12,
                  fontWeight: FontWeight.w400,
                )),
          ],
        ),
        const Spacer(),
        Container(
          width: 88,
          height: 88,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: const DecorationImage(
              image: AssetImage('assets/images/test1.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}

class _TabHeader extends StatelessWidget {
  final TabController tabController;

  const _TabHeader({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 23,
      child: TabBar(
        dividerColor: Colors.transparent,
        indicatorSize: TabBarIndicatorSize.label,
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(
            width: 2,
            color: Color(DreamerColors.primary),
          ),
          insets: EdgeInsets.symmetric(horizontal: 7),
        ),
        controller: tabController,
        labelStyle: const TextStyle(
          fontFamily: 'SF Pro Text',
          fontSize: 14,
          height: 16 / 14,
          color: Colors.black,
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: 'SF Pro Text',
          color: Colors.black,
          fontSize: 14,
          height: 16 / 14,
          fontWeight: FontWeight.w500,
        ),
        tabs: const [
          Tab(text: 'Profile'),
          Tab(text: 'Dreams'),
        ],
      ),
    );
  }

// @override
// Size get preferredSize => const Size.fromHeight(23);
}
