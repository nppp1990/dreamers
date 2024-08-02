import 'dart:math';

import 'package:dreamer/common/router/router_utils.dart';
import 'package:dreamer/common/widget/fix_page_child.dart';
import 'package:dreamer/constants/colors.dart';
import 'package:dreamer/data/dreamer_icons.dart';
import 'package:dreamer/page/activity/activity_page.dart';
import 'package:dreamer/page/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradient_borders/gradient_borders.dart';

class HomePage extends StatefulWidget {
  final int index;

  const HomePage({super.key, required this.index});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;

  static const List<Widget> _widgetOptions = <Widget>[
    FixPageViewChild(child: HomeListPage()),
    Center(child: Text('Index 1: Chat')),
    FixPageViewChild(child: HomeActivityPage()),
    FixPageViewChild(child: HomeProfilePage()),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.index);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.white,
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: _widgetOptions,
      ),
      bottomNavigationBar: _HomeBottomNavigationBar(
        index: widget.index,
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
      ),
    );
  }
}

class _HomeBottomNavigationBar extends StatefulWidget {
  final int index;
  final ValueChanged<int> onTap;

  const _HomeBottomNavigationBar({required this.onTap, required this.index});

  @override
  State<StatefulWidget> createState() => _HomeBottomNavigationBarState();
}

class _HomeBottomNavigationBarState extends State<_HomeBottomNavigationBar> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      // display all items
      selectedItemColor: DreamerColors.primary,
      unselectedItemColor: DreamerColors.grey300,
      iconSize: 28,
      selectedFontSize: 10,
      unselectedFontSize: 10,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(DreamerIcons.notification),
          label: 'Activity',
        ),
        BottomNavigationBarItem(
          icon: Icon(DreamerIcons.profile),
          label: 'Profile',
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    widget.onTap(index);
  }
}

class HomeListPage extends StatelessWidget {
  static const originBubbleHeight = 406.0;
  static const originBackgroundHeight = 726.0;

  const HomeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.viewPaddingOf(context).top;
    double screenWidth = MediaQuery.sizeOf(context).width;

    return LayoutBuilder(builder: (context, constraints) {
      double bubbleHeight = constraints.maxHeight * originBubbleHeight / originBackgroundHeight;
      double top = statusBarHeight;
      double bubbleWidth = screenWidth;

      return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg_base2.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: AvatarRandomListView(
          bubbleHeight: bubbleHeight,
          top: top,
          bubbleWidth: bubbleWidth,
        ),
      );
    });
  }
}

class AvatarRandomListView extends StatefulWidget {
  final double bubbleHeight;
  final double top;
  final double bubbleWidth;

  const AvatarRandomListView({super.key, required this.bubbleHeight, required this.top, required this.bubbleWidth});

  @override
  State<StatefulWidget> createState() => _AvatarRandomListViewState();
}

class _AvatarRandomListViewState extends State<AvatarRandomListView> with SingleTickerProviderStateMixin {
  static const List<String> testImages = [
    'assets/images/test1.png',
    'assets/images/test2.jpg',
    'assets/images/test3.jpeg',
    'assets/images/test4.jpeg',
    'assets/images/test5.jpg',
    'assets/images/test6.jpeg',
    'assets/images/test7.jpg',
    'assets/images/test8.jpeg',
  ];

  late List<Rect> positions;
  late AnimationController _controller;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _controller.addStatusListener((status) {
      // print('status: $status');
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        setState(() {
          // setState generate a new set of positions
          _controller.forward();
        });
      }
    });
    _controller.forward();
    _generatePositions();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _generatePositions() {
    double minTop = widget.top;
    double maxTop = widget.bubbleHeight;
    Random random = Random();

    List<Rect>? generateNonOverlappingImages(int minSize) {
      List<Rect> occupiedPositions = [];
      for (int i = 0; i < testImages.length; i++) {
        double size = random.nextDouble() * minSize + minSize; // Ensure minimum size
        bool isPositionValid = false;
        Rect? position;

        // Generate a random position that does not overlap with any existing positions
        int tryCount = 0;
        while (!isPositionValid) {
          double left = random.nextDouble() * (widget.bubbleWidth - size);
          double top = random.nextDouble() * (maxTop - minTop) + minTop;
          position = Rect.fromLTWH(left, top, size, size);

          isPositionValid = !occupiedPositions.any((occupiedRect) => occupiedRect.overlaps(position!));
          if (isPositionValid) {
            tryCount = 0;
            occupiedPositions.add(position);
          } else {
            tryCount++;
            if (tryCount > 100) {
              // Give up after 100 tries
              return null;
            }
          }
        }
      }
      return occupiedPositions;
    }

    int minSize = 55;
    positions = [];
    while (minSize > 0) {
      var tempPositions = generateNonOverlappingImages(minSize);
      if (tempPositions == null) {
        // Found a valid set of positions,
        minSize--;
        continue;
      }
      positions = tempPositions;
      break;
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('build');
    List<Widget> list = [
      Positioned(
        left: 0,
        top: widget.top,
        child: Image.asset(
          'assets/images/bg_bubble.png',
          width: widget.bubbleWidth,
          height: widget.bubbleHeight,
          fit: BoxFit.cover,
        ),
      ),
    ];
    for (int i = 0; i < testImages.length && i < positions.length; i++) {
      Rect rect = positions[i];
      final animation = Tween<Offset>(
        begin: Offset(rect.left, rect.top),
        end: Offset(rect.left - 40 + _random.nextDouble() * 80, rect.top - 30 + _random.nextDouble() * 60),
      ).animate(_controller);
      final scaleAnimation = Tween<double>(
        begin: 1.0,
        end: 0.8 + 0.4 * _random.nextDouble(),
      ).animate(_controller);

      Widget item = AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Positioned(
            left: animation.value.dx,
            top: animation.value.dy,
            child: Transform.scale(
              scale: scaleAnimation.value,
              child: child,
            ),
          );
        },
        child: _AvatarView(
          width: rect.width,
          image: testImages[i],
          onTap: () {
            // todo test
            Navigator.of(context).push(Right2LeftRouter(child: const OtherProfilePage()));
          },
        ),
      );
      list.add(item);
    }
    return Stack(
      children: list,
    );
  }
}

class _AvatarView extends StatelessWidget {
  final double width;
  final String image;
  final VoidCallback? onTap;

  const _AvatarView({required this.width, required this.image, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Container(
        width: width,
        height: width,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: GradientBoxBorder(
              width: width * 3 / 46,
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFF0C7FF),
                  Color(0xFFAE42D4),
                ],
              )),
        ),
        child: ClipOval(
          child: Image.asset(
            image,
            width: width,
            height: width,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
