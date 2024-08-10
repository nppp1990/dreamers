import 'package:dreamer/common/router/router_utils.dart';
import 'package:dreamer/common/widget/bg_page.dart';
import 'package:dreamer/common/widget/tab_header.dart';
import 'package:dreamer/constants/colors.dart';
import 'package:dreamer/data/dreamer_icons.dart';
import 'package:dreamer/page/profile/dream_list.dart';
import 'package:dreamer/page/profile/profile_detail.dart';
import 'package:dreamer/page/profile/report_page.dart';
import 'package:dreamer/page/setting/settings.dart';
import 'package:dreamer/request/bean/user_profile.dart';
import 'package:dreamer/request/request_manager.dart';
import 'package:flutter/material.dart';

class HomeProfilePage extends StatelessWidget {
  const HomeProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('HomeProfilePage build');
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
        child: const ProfileView(),
      ),
    );
  }
}

class OtherProfilePage extends StatelessWidget {
  const OtherProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.viewPaddingOf(context).top;
    return PageBackground(
      assetImage: const AssetImage('assets/images/bg_base1.png'),
      child: Padding(
        padding: EdgeInsets.only(top: statusBarHeight),
        child: const ProfileView(profileId: 'testId',),
      ),
    );
  }
}

class ProfileView extends StatefulWidget {

  final String? profileId;

  const ProfileView({super.key, this.profileId});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    debugPrint('ProfileView initState');
    _loadData();
  }

  _loadData() async {
    final profileResult = await RequestManager().getProfile(widget.profileId);
    if (profileResult.data != null) {
      final profile = profileResult.data!;
      debugPrint('Profile: ${profile.toJson()}');
    } else {
      debugPrint('Profile load failed: ${profileResult.errMsg}');
    }
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _ItemHeader(showSetting: widget.profileId == null),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: _InfoHeader(),
        ),
        TabHeader(tabController: _tabController, tabs: const ['Profile', 'Dreams']),
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
              children: [
                ProfileDetail(isOthers: widget.profileId != null),
                const SingleChildScrollView(child: DreamList()),
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

  const _ItemHeader({required this.showSetting});

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
              Navigator.of(context).push(Right2LeftRouter(child: const SettingPage()));
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
                  color: DreamerColors.primary,
                  size: 24,
                ),
                onTap: () {
                  Navigator.pop(context);
                }),
            const Spacer(),
            GestureDetector(
                onTap: () {
                  _showReportDialog(context);
                },
                child: Image.asset(
                  'assets/images/icons/ic_menu_more.png',
                  width: 24,
                  height: 24,
                )),
          ]));
    }
  }

  Future<void> _showReportDialog(BuildContext context) async {
    final res = await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.only(top: 30, left: 16, right: 16, bottom: 40),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context, 0);
                },
                child: Container(
                  height: 48,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: DreamerColors.grey150,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  child: const Row(
                    children: [
                      SizedBox(width: 16),
                      Icon(DreamerIcons.block, color: DreamerColors.danger, size: 24),
                      SizedBox(
                        width: 16,
                      ),
                      Text('Block this account',
                          style: TextStyle(
                            color: DreamerColors.danger,
                            fontSize: 12,
                            height: 14 / 12,
                            fontWeight: FontWeight.w500,
                          )),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 1,
                color: DreamerColors.divider2,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context, 1);
                  Navigator.push(context, Right2LeftRouter(child: const ProfileReportPage()));
                },
                child: Container(
                  height: 48,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: DreamerColors.grey150,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: const Row(
                    children: [
                      SizedBox(width: 16),
                      Icon(DreamerIcons.report, color: DreamerColors.danger, size: 24),
                      SizedBox(
                        width: 16,
                      ),
                      Text('Report',
                          style: TextStyle(
                            color: DreamerColors.danger,
                            fontSize: 12,
                            height: 14 / 12,
                            fontWeight: FontWeight.w500,
                          )),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    elevation: WidgetStateProperty.all(0),
                    minimumSize: WidgetStateProperty.all(const Size(double.infinity, 36)),
                    backgroundColor: WidgetStateProperty.all(DreamerColors.grey150),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  child: const Text('Cancel',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ))),
            ],
          ),
        );
      },
    );
    if (res == 0) {
      // block
      print('block');
    } else if (res == 1) {
      // report
      print('report');
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
                  color: Colors.black,
                  fontSize: 24,
                  height: 28 / 24,
                  fontWeight: FontWeight.w700,
                )),
            SizedBox(height: 4),
            Text('Hello! I’m John.',
                style: TextStyle(
                  color: DreamerColors.grey800,
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
