import 'package:dreamer/common/router/router_utils.dart';
import 'package:dreamer/common/widget/bg_page.dart';
import 'package:dreamer/page/home/home_list_page.dart';
import 'package:dreamer/page/login/login.dart';
import 'package:dreamer/page/splash/dreamer_icon_text.dart';
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
    // todo: 这里准备做一些初始化工作，目前暂时暂停2s
    // 2s后展示首页
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        if (UserManager().isLogin()) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomePage(index: 3)));
        } else {
          Navigator.of(context).pushReplacement(FadeRouter(child: const LoginPage()));
        }
      }
    });
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
