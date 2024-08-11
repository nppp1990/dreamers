import 'package:dreamer/common/router/router_utils.dart';
import 'package:dreamer/common/utils/dialog_utils.dart';
import 'package:dreamer/page/signup/onboarding.dart';
import 'package:dreamer/page/signup/onboarding5.dart';
import 'package:flutter/material.dart';

/// choose region
class Signup4 extends StatefulWidget {
  const Signup4({super.key});

  @override
  State<StatefulWidget> createState() => _Signup4PageState();
}

class _Signup4PageState extends State<Signup4> {
  final Map<String, List<String>> maps = {
    'China': ['Beijing', 'Shanghai', 'Guangzhou', 'Shenzhen'],
    'Japan': ['Tokyo', 'Osaka', 'Kyoto', 'Hokkaido'],
    'Korea': ['Seoul', 'Busan', 'Incheon', 'Jeju'],
    'India': ['Mumbai', 'Delhi', 'Bangalore', 'Chennai'],
    'USA': ['New York', 'Los Angeles', 'Chicago', 'San Francisco'],
    // 'Asia': ['China', 'Japan', 'Korea', 'India'],
    // 'Europe': ['Germany', 'France', 'Italy', 'Spain'],
    // 'America': ['USA', 'Canada', 'Mexico', 'Brazil'],
    // 'Africa': ['Egypt', 'Nigeria', 'South Africa', 'Kenya'],
    // 'Oceania': ['Australia', 'New Zealand', 'Fiji', 'Papua New Guinea'],
  };

  late String _country;
  late String? _city;

  @override
  void initState() {
    super.initState();
    _country = maps.keys.first;
    _city = null;
    // _city = null;
  }

  @override
  Widget build(BuildContext context) {
    return SignupBasePage(
        step: 4,
        title: titleList[3],
        subTitle: subTitleList[3],
        onNext: () {
          if (_city != null) {
            Navigator.of(context).push(Right2LeftRouter(child: const Signup5()));
          } else {
            DialogUtils.showToast(context, 'city cannot be empty');
          }
        },
        child: Column(
          children: [
            DataSelector<String>(
              value: _country,
              hint: 'select country',
              onChanged: (value) {
                setState(() {
                  _country = value!;
                  _city = null;
                });
              },
              regionList: maps.keys.toList(),
            ),
            const SizedBox(height: 16),
            DataSelector<String>(
              value: _city,
              hint: 'select city',
              onChanged: (value) {
                setState(() {
                  _city = value;
                });
              },
              regionList: maps[_country]!,
            ),
          ],
        ));
  }
}
