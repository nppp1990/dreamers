import 'package:dreamer/constants/colors.dart';
import 'package:dreamer/data/dreamer_icons.dart';
import 'package:flutter/material.dart';

class ProfileDetail extends StatelessWidget {
  final bool isOthers;

  const ProfileDetail({super.key, required this.isOthers});

  static const testAbout =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
      '\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
      '\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.';

  static const testLabelList = [
    'Positive',
    'Extrovert',
    'Optimistic',
    'Creative',
    'Confident',
    'Handsome',
  ];

  static const testInterestList = [
    '🌿 Nature',
    '🏝️ Travel',
    '✍️ Writing',
  ];

  // NickName: 'Dreamer' Age: '24'
  static const testBasicInfoPairList = [
    MapEntry('NickName', 'Jon Doe'),
    MapEntry('Age', 24),
    MapEntry('Language', 'English, Japanese, Korean'),
    MapEntry('Living', 'Seoul, Korea'),
    MapEntry('Education', 'Bachelor of Computer Science'),
    MapEntry('Occupation', 'Software Engineer'),
    MapEntry('Height', '170cm'),
    MapEntry('Body type', 'Slim'),
    MapEntry('Marital', 'Single'),
    MapEntry('Relationship goal', 'Serious'),
    MapEntry('test test test test test test very Long key', 'value1'),
    MapEntry('test2', 'test test test test test test very Long value'),
    MapEntry('test3', 'value3'),
    MapEntry('test4', 'value4'),
    MapEntry('test5', 'value5'),
    MapEntry('test6', 'value6'),
    MapEntry('test7', 'value7'),
  ];

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
                const _Item(
                    title: 'About',
                    child: Text(testAbout,
                        overflow: TextOverflow.visible,
                        maxLines: null,
                        softWrap: true,
                        style: TextStyle(
                          fontFamily: 'SF Pro Text',
                          fontSize: 13,
                          height: 15.5 / 13,
                          fontWeight: FontWeight.w400,
                          color: Color(DreamerColors.grey800),
                        ))),
                _Divider(),
                _Item(
                  title: 'Personality labels',
                  child: Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: testLabelList.map((e) => _LabelItem(label: e)).toList(),
                  ),
                ),
                _Divider(),
                _Item(
                  title: 'Interests',
                  child: Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: testInterestList.map((e) => _InterestItem(interest: e)).toList(),
                  ),
                ),
                _Divider(),
                const _Item(
                  title: 'Basic Information',
                  child: _BasicInfoItem(pairList: testBasicInfoPairList),
                ),
                _Divider(),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 24,
          left: 40,
          right: 40,
          child: Container(
            width: double.infinity,
            height: 52,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: const Color(DreamerColors.primary),
              borderRadius: BorderRadius.circular(100),
              // box-shadow: 0px 3px 5px 0px #00000040;
              boxShadow: const [
                BoxShadow(
                  color: Color(DreamerColors.primary),
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
                GestureDetector(
                  onTap: () {},
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      isOthers ? DreamerIcons.like : DreamerIcons.edit,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _LabelItem extends StatelessWidget {
  final String label;

  const _LabelItem({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(DreamerColors.secondary),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: 'SF Pro Text',
          fontSize: 12,
          height: 14 / 12,
          fontWeight: FontWeight.w500,
          color: Color(DreamerColors.primary),
        ),
      ),
    );
  }
}

class _InterestItem extends StatelessWidget {
  final String interest;

  const _InterestItem({required this.interest});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: const Color(DreamerColors.greyBorder),
          width: 1,
        ),
      ),
      child: Text(
        interest,
        style: const TextStyle(
          fontFamily: 'SF Pro Text',
          fontSize: 12,
          height: 14 / 12,
          fontWeight: FontWeight.w500,
          color: Color(DreamerColors.grey600),
        ),
      ),
    );
  }
}

class _BasicInfoItem extends StatelessWidget {
  final List<MapEntry<String, Object>> pairList;

  const _BasicInfoItem({required this.pairList});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: pairList
          .map((e) => Container(
                constraints: const BoxConstraints(minHeight: 24),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        e.key,
                        style: const TextStyle(
                          fontFamily: 'SF Pro Text',
                          fontSize: 13,
                          height: 15.5 / 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Text(
                        e.value.toString(),
                        style: const TextStyle(
                          fontFamily: 'SF Pro Text',
                          fontSize: 13,
                          height: 15.5 / 13,
                          fontWeight: FontWeight.w400,
                          color: Color(DreamerColors.grey800),
                        ),
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 1,
      color: const Color(DreamerColors.divider),
    );
  }
}

class _Item extends StatelessWidget {
  final String title;
  final Widget child;

  const _Item({super.key, required this.title, required this.child});

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
            color: Color(DreamerColors.primary),
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
