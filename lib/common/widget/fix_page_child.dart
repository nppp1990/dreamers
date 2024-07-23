import 'package:flutter/material.dart';

class FixPageViewChild extends StatefulWidget {
  final Widget child;

  const FixPageViewChild({super.key, required this.child});

  @override
  State<StatefulWidget> createState() => _PageViewChildState();
}

class _PageViewChildState extends State<FixPageViewChild> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true; // Indicate that the widget should be kept alive

  @override
  Widget build(BuildContext context) {
    super.build(context); // Call super.build(context) when using AutomaticKeepAliveClientMixin
    return widget.child;
  }
}
