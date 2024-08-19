import 'package:dreamer/common/router/router_utils.dart';
import 'package:dreamer/constants/colors.dart';
import 'package:dreamer/data/dreamer_icons.dart';
import 'package:dreamer/page/profile/profile_edit_page.dart';
import 'package:dreamer/page/profile/widgets/item_about.dart';
import 'package:dreamer/page/profile/widgets/item_basic.dart';
import 'package:dreamer/page/profile/widgets/item_interests.dart';
import 'package:dreamer/page/profile/widgets/item_personality.dart';
import 'package:dreamer/request/bean/user_profile.dart';
import 'package:dreamer/request/request_manager.dart';
import 'package:flutter/material.dart';

const testLabelList = [
  'Positive',
  'Extrovert',
  'Optimistic',
  'Creative',
  'Confident',
  'Handsome',
];

const testInterestList = [
  '🌿 Nature',
  '🏝️ Travel',
  '✍️ Writing',
];

class ProfileDetail extends StatefulWidget {
  final bool isOthers;
  final ProfileInfo profileInfo;

  const ProfileDetail({super.key, required this.isOthers, required this.profileInfo});

  @override
  State<StatefulWidget> createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> {
  bool get isOthers => widget.isOthers;

  ProfileInfo get profileInfo => _profileInfo;

  late ProfileInfo _profileInfo;
  // late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _profileInfo = widget.profileInfo;
    // _scrollController = ScrollController()
    //   ..addListener(() {
    //     print(
    //         'scroll offset: ${_scrollController.offset}---${_scrollController.position.maxScrollExtent}---${_scrollController.position.minScrollExtent}');
    //   });
  }

  @override
  void dispose() {
    // _scrollController.dispose();
    super.dispose();
  }

  _goToEditPage() async {
    final res = await Navigator.of(context).push(Right2LeftRouter(
        child: ProfileEditPage(
      oldProfileInfo: profileInfo,
      newProfileInfo: profileInfo.copy(),
    )));
    if (res is ProfileInfo) {
      setState(() {
        _profileInfo = res;
        print('ProfileInfo updated: ${_profileInfo.about}');
      });
      RequestManager().updateProfile(res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          // controller: _scrollController,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AboutItem(value: profileInfo.about),
                _Divider(),
                const PersonalityItem(value: testLabelList),
                _Divider(),
                const InterestsItem(value: testInterestList),
                _Divider(),
                BasicInfoItem(profileInfo: profileInfo),
                _Divider(),
                LayoutBuilder(builder: (context, builder) {
                  print('builder: ${builder.maxHeight}----${builder.minHeight}');
                  return const SizedBox(
                    height: 0,
                  );
                }),
                // 动态改变此处的height
                // const SizedBox(height: 24 + 52,)
              ],
            ),
          ),
        ),
        // like or edit float button
        Positioned(
          bottom: 24,
          left: 40,
          right: 40,
          child: GestureDetector(
            onTap: () {
              if (isOthers) {
                // like
              } else {
                _goToEditPage();
              }
            },
            child: Container(
              width: double.infinity,
              height: 52,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: DreamerColors.primary,
                borderRadius: BorderRadius.circular(100),
                // box-shadow: 0px 3px 5px 0px #00000040;
                boxShadow: const [
                  BoxShadow(
                    color: DreamerColors.primary,
                    offset: Offset(0, 3),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Center(
                    child: Text(
                      isOthers ? 'Like' : 'Edit',
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      isOthers ? DreamerIcons.like : DreamerIcons.edit,
                      color: Colors.white,
                      size: 24,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// different from [ProfileDetail], this page is for editing profile
/// this widget has no [SingleChildScrollView] and [Stack]
class ProfileDetailEdit extends StatefulWidget {
  final ProfileInfo profileInfo;

  const ProfileDetailEdit({super.key, required this.profileInfo});

  @override
  State<StatefulWidget> createState() => _ProfileDetailEditState();
}

class _ProfileDetailEditState extends State<ProfileDetailEdit> {
  @override
  void initState() {
    super.initState();
  }

  ProfileInfo get _profileInfo => widget.profileInfo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AboutItem(
            value: _profileInfo.about,
            isEdit: true,
            onChanged: (value) {
              _profileInfo.about = value;
            },
          ),
          _Divider(),
          const PersonalityItem(value: testLabelList, isEdit: true),
          _Divider(),
          const InterestsItem(value: testInterestList, isEdit: true),
          _Divider(),
          BasicInfoItem(
            profileInfo: _profileInfo,
            isEdit: true,
            onChanged: (BasicInfoBean bean) {
              switch (bean.key) {
                case BasicInfoKey.nickName:
                  _profileInfo.nickname = bean.value as String;
                  break;
                case BasicInfoKey.age:
                  // age no change here
                  break;
                case BasicInfoKey.language:
                  _profileInfo.languageList = (bean.value as MultiSelectData).values;
                  break;
                case BasicInfoKey.living:
                  TwoSelectData regionData = bean.value as TwoSelectData;
                  _profileInfo.livingCountry = regionData.value1;
                  _profileInfo.livingState = regionData.value2;
                  break;
                case BasicInfoKey.education:
                  _profileInfo.education = bean.value as String;
                  break;
                case BasicInfoKey.occupation:
                  _profileInfo.occupation = bean.value as String;
                  break;
                case BasicInfoKey.height:
                  _profileInfo.height = bean.value as String;
                  break;
                case BasicInfoKey.bodyType:
                  _profileInfo.bodyType = bean.value as String;
                  break;
                case BasicInfoKey.marital:
                  _profileInfo.maritalStatus = bean.value as String;
                  break;
                case BasicInfoKey.relationshipGoal:
                  _profileInfo.relationshipGoal = bean.value as String;
                  break;
              }
            },
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 1,
      color: DreamerColors.divider,
    );
  }
}
