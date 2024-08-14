import 'package:dreamer/common/router/router_utils.dart';
import 'package:dreamer/common/utils/dialog_utils.dart';
import 'package:dreamer/data/provider/signup_data.dart';
import 'package:dreamer/main.dart';
import 'package:dreamer/page/signup/onboarding.dart';
import 'package:dreamer/page/signup/onboarding5.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// choose region
class Signup4 extends StatefulWidget {
  const Signup4({super.key});

  @override
  State<StatefulWidget> createState() => _Signup4PageState();
}

class _Signup4PageState extends State<Signup4> {
  late String? _country;
  late String? _state;
  late List<String> _countryList;

  @override
  void initState() {
    super.initState();
    // _country = regionMap.keys.first;
    _country = null;
    _state = null;
    _countryList = regionMap.keys.toList();
  }

  _next(BuildContext context) {
    if (_country == null) {
      DialogUtils.showToast(context, 'country cannot be empty');
      return;
    }
    Provider.of<SignupData>(context, listen: false).setRegion(_country!, _state);
    Navigator.of(context).push(Right2LeftRouter(child: const Signup5()));
  }

  @override
  Widget build(BuildContext context) {
    return SignupBasePage(
        step: 4,
        title: titleList[3],
        subTitle: subTitleList[3],
        onNext: () => _next(context),
        child: Column(
          children: [
            DataSelector<String>(
              value: _country,
              hint: 'select country',
              onChanged: (value) {
                setState(() {
                  _country = value!;
                  _state = null;
                });
              },
              regionList: _countryList,
            ),
            const SizedBox(height: 16),
            DataSelector<String>(
              value: _state,
              hint: _country == null
                  ? 'select country first'
                  : (regionMap[_country!] == null ? 'no state data' : 'select state'),
              onChanged: (value) {
                setState(() {
                  _state = value;
                });
              },
              regionList: _country == null ? null : regionMap[_country!],
            ),
          ],
        ));
  }
}
