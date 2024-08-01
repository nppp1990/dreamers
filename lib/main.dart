import 'package:dreamer/common/utils/phone_check.dart';
import 'package:dreamer/data/provider/signup_data.dart';
import 'package:dreamer/page/splash/dreamer_splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SignupData>(create: (context) => SignupData(phonePrefix: PhoneUtils.prefixList[0])),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            fontFamily: 'SF Pro Text',
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const DreamerSplash()),
    );
  }
}
