import 'package:dreamer/common/router/router_utils.dart';
import 'package:dreamer/constants/colors.dart';
import 'package:dreamer/data/dreamer_icons.dart';
import 'package:dreamer/page/profile/profile_edit_page.dart';
import 'package:dreamer/page/profile/widgets/item_about.dart';
import 'package:dreamer/page/profile/widgets/item_basic.dart';
import 'package:dreamer/page/profile/widgets/item_interests.dart';
import 'package:dreamer/page/profile/widgets/item_personality.dart';
import 'package:flutter/material.dart';

const testAbout =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
    '\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
    '\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.';

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

final testBasicInfoPairList = [
  BasicInfoBean(key: BasicInfoKey.nickName, value: 'Jon Doe', type: BasicType.singleEdit),
  BasicInfoBean(key: BasicInfoKey.age, value: 24, type: BasicType.textField),
  BasicInfoBean(key: BasicInfoKey.language, value: 'English, Japanese, Korean', type: BasicType.multiSelect),
  BasicInfoBean(key: BasicInfoKey.living, value: TwoSelectData(value1: 'USA', value2: 'Seattle'), type: BasicType.twoSelect),
  BasicInfoBean(key: BasicInfoKey.education, value: 'Bachelor of Computer Science', type: BasicType.singleSelect),
  BasicInfoBean(key: BasicInfoKey.occupation, value: 'Software Engineer', type: BasicType.singleEdit),
  BasicInfoBean(key: BasicInfoKey.height, value: '170cm', type: BasicType.singleSelect),
  BasicInfoBean(key: BasicInfoKey.bodyType, value: 'Slim', type: BasicType.singleSelect),
  BasicInfoBean(key: BasicInfoKey.marital, value: 'Single', type: BasicType.singleSelect),
  BasicInfoBean(key: BasicInfoKey.relationshipGoal, value: 'Serious', type: BasicType.singleSelect),
  BasicInfoBean(key: BasicInfoKey.test1, value: 'value1', type: BasicType.singleEdit),
  BasicInfoBean(key: BasicInfoKey.test2, value: 'test test test test test test very Long value', type: BasicType.singleEdit),
  BasicInfoBean(key: BasicInfoKey.test2, value: 'value3', type: BasicType.singleEdit),
  BasicInfoBean(key: BasicInfoKey.test2, value: 'value4', type: BasicType.singleEdit),
  BasicInfoBean(key: BasicInfoKey.test2, value: 'value5', type: BasicType.singleEdit),
  BasicInfoBean(key: BasicInfoKey.test2, value: 'value6', type: BasicType.singleEdit),
  BasicInfoBean(key: BasicInfoKey.test2, value: 'value7', type: BasicType.singleEdit),
];

class ProfileDetail extends StatelessWidget {
  final bool isOthers;

  const ProfileDetail({super.key, required this.isOthers});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AboutItem(value: testAbout),
                _Divider(),
                const PersonalityItem(value: testLabelList),
                _Divider(),
                const InterestsItem(value: testInterestList),
                _Divider(),
                BasicInfoItem(pairList: testBasicInfoPairList),
                _Divider(),
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
                Navigator.of(context).push(Right2LeftRouter(child: const ProfileEditPage()));
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
                        fontFamily: 'SF Pro Text',
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
class ProfileDetailEdit extends StatelessWidget {
  const ProfileDetailEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AboutItem(
            value: testAbout,
            isEdit: true,
            onChanged: (value) {
              debugPrint('about changed: $value');
            },
          ),
          _Divider(),
          const PersonalityItem(value: testLabelList, isEdit: true),
          _Divider(),
          const InterestsItem(value: testInterestList, isEdit: true),
          _Divider(),
          BasicInfoItem(pairList: testBasicInfoPairList, isEdit: true),
          _Divider(),
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
