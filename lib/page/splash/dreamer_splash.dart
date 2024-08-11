import 'dart:convert';

import 'package:dreamer/common/router/router_utils.dart';
import 'package:dreamer/common/widget/bg_page.dart';
import 'package:dreamer/data/provider/signup_data.dart';
import 'package:dreamer/main.dart';
import 'package:dreamer/page/home/home_list_page.dart';
import 'package:dreamer/page/login/login.dart';
import 'package:dreamer/page/signup/onboarding.dart';
import 'package:dreamer/page/splash/dreamer_icon_text.dart';
import 'package:dreamer/request/request_manager.dart';
import 'package:dreamer/service/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DreamerSplash extends StatefulWidget {
  const DreamerSplash({super.key});

  @override
  State<StatefulWidget> createState() => _DreamerSplashState();
}

class _DreamerSplashState extends State<DreamerSplash> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
    );
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent, // bottom bar color
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _init();
    });
  }

  _init() async {
    precacheImage(const AssetImage('assets/images/bg_base1.png'), context);
    precacheImage(const AssetImage('assets/images/bg_base2.png'), context);
    int time1 = DateTime.now().millisecondsSinceEpoch;
    await loadRegion();
    int time2 = DateTime.now().millisecondsSinceEpoch;
    await UserManager().getLoginInfo();
    int time3 = DateTime.now().millisecondsSinceEpoch;
    debugPrint('load region duration: ${time2 - time1}, get login info duration: ${time3 - time2}');
    if (UserManager().isLogin()) {
      var isProfileCompleted = await UserManager().getProfileComplete();
      int time4 = DateTime.now().millisecondsSinceEpoch;
      debugPrint('get profile complete duration: ${time4 - time3}');
      if (!isProfileCompleted) {
        // final profileResult = await RequestManager().getProfile(null);
        // if (profileResult.data != null && profileResult.data!.isNotEmpty) {
        //   UserManager().saveProfileComplete(true);
        // }
      }
      if (!context.mounted) {
        return;
      }
      if (isProfileCompleted) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomePage(index: 0)));
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const OnboardingPage()));
      }
    } else {
      Navigator.of(context).pushReplacement(FadeRouter(child: const LoginPage()));
    }
  }

  Future<void> loadRegion() async {
    final res = await rootBundle.loadString('assets/countries_en.json');
    final countries = (json.decode(res) as List<dynamic>).map((e) => Country.fromJson(e)).toList();
    countryList = countries;
  }

  @override
  Widget build(BuildContext context) {
    return const PageBackground(
        assetImage: AssetImage('assets/images/bg_splash.png'),
        child: Center(
          child: DreamerIconText(),
        ));
  }
}
