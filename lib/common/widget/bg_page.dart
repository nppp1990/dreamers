import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PageBackground extends StatefulWidget {
  final Widget child;
  final AssetImage assetImage;

  const PageBackground({super.key, required this.assetImage, required this.child});

  @override
  State<StatefulWidget> createState() => _PageBackgroundState();
}

class _PageBackgroundState extends State<PageBackground> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: widget.assetImage,
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: widget.child,
      ),
    );
  }
}
