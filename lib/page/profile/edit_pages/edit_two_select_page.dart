import 'package:dreamer/common/widget/bg_page.dart';
import 'package:dreamer/page/profile/widgets/edit_header.dart';
import 'package:dreamer/page/profile/widgets/item_basic.dart';
import 'package:dreamer/page/signup/onboarding.dart';
import 'package:flutter/material.dart';

class EditTwoSelectItemPage extends StatefulWidget {
  final String title;
  final TwoSelectData value;

  const EditTwoSelectItemPage({super.key, required this.title, required this.value});

  @override
  State<StatefulWidget> createState() => _EditTwoSelectItemPageState();
}

class _EditTwoSelectItemPageState extends State<EditTwoSelectItemPage> {
  final Map<String, List<String>> maps = {
    'China': ['Beijing', 'Shanghai', 'Guangzhou', 'Shenzhen'],
    'Japan': ['Tokyo', 'Osaka', 'Kyoto', 'Hokkaido'],
    'Korea': ['Seoul', 'Busan', 'Incheon', 'Jeju'],
    'India': ['Mumbai', 'Delhi', 'Bangalore', 'Chennai'],
    'USA': ['New York', 'Los Angeles', 'Chicago', 'San Francisco', 'Seattle'],
    // 'Asia': ['China', 'Japan', 'Korea', 'India'],
    // 'Europe': ['Germany', 'France', 'Italy', 'Spain'],
    // 'America': ['USA', 'Canada', 'Mexico', 'Brazil'],
    // 'Africa': ['Egypt', 'Nigeria', 'South Africa', 'Kenya'],
    // 'Oceania': ['Australia', 'New Zealand', 'Fiji', 'Papua New Guinea'],
  };

  late String? _value1;
  late String? _value2;

  @override
  void initState() {
    super.initState();
    _value1 = widget.value.value1;
    // check value1 in maps
    if (!maps.containsKey(_value1)) {
      _value1 = null;
      _value2 = null;
    } else {
      _value2 = widget.value.value2;
      // check value2 in maps
      if (!maps[_value1]!.contains(_value2)) {
        _value2 = null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.viewPaddingOf(context).top;
    return PageBackground(
      assetImage: const AssetImage('assets/images/bg_base1.png'),
      child: Column(
        children: [
          SizedBox(height: statusBarHeight),
          EditHeader(
            title: widget.title,
            btnStr: 'Done',
            onDone: () {
              if (_value1 == null) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('country cannot be empty'),
                ));
                return;
              }
              if (_value2 == null) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('city cannot be empty'),
                ));
                return;
              }
              Navigator.of(context).pop(TwoSelectData(value1: _value1!, value2: _value2!));
            },
          ),
          const SizedBox(
            height: 16,
          ),
          // todo this hint is hard code，need to be changed to dynamic
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DataSelector<String>(
              value: _value1,
              hint: 'select country',
              onChanged: (value) {
                setState(() {
                  _value1 = value!;
                  _value2 = null;
                });
              },
              regionList: maps.keys.toList(),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DataSelector<String>(
              value: _value2,
              hint: 'select city',
              onChanged: (value) {
                setState(() {
                  _value2 = value;
                });
              },
              regionList: maps[_value1]!,
            ),
          ),
        ],
      ),
    );
  }
}
