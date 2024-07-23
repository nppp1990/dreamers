import 'dart:math';

import 'package:dreamer/common/widget/fix_page_child.dart';
import 'package:dreamer/constants/colors.dart';
import 'package:dreamer/data/dreamer_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradient_borders/gradient_borders.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;

  static const List<Widget> _widgetOptions = <Widget>[
    FixPageViewChild(child: HomeListPage()),
    Center(child: Text('Index 1: Chat')),
    Center(child: Text('Index 2: Activity')),
    Center(child: Text('Index 3: Profile')),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
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
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
      ),
    );
  }
}

class _HomeBottomNavigationBar extends StatefulWidget {
  final ValueChanged<int> onTap;

  const _HomeBottomNavigationBar({required this.onTap});

  @override
  State<StatefulWidget> createState() => _HomeBottomNavigationBarState();
}

class _HomeBottomNavigationBarState extends State<_HomeBottomNavigationBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed, // display all items
      selectedItemColor: const Color(DreamerColors.primary),
      unselectedItemColor: const Color(DreamerColors.grey300),
      iconSize: 28,
      selectedFontSize: 10,
      unselectedFontSize: 10,
      items:  const <BottomNavigationBarItem>[
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
  const HomeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg_base2.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: AvatarRandomListView(height: constraints.maxHeight),
        );
      });
      // },
    //   child: Container(
    //     decoration: const BoxDecoration(
    //       image: DecorationImage(
    //         image: AssetImage('assets/images/bg_base2.png'),
    //         fit: BoxFit.cover,
    //       ),
    //     ),
    //     child: const AvatarRandomListView(),
    //   ),
    // );
  }
}

class AvatarRandomListView extends StatelessWidget {

  final double height;

  static const originBubbleHeight = 406.0;
  static const originBackgroundHeight = 726.0;

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

  const AvatarRandomListView({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    Random random = Random();

    double statusBarHeight = MediaQuery.of(context).padding.top;
    // in figma: 406 is the height of bubble,726 is the height of background image
    // figma bubble height is 406, so we need to scale it to the screen height
    double bubbleHeight = height * originBubbleHeight / originBackgroundHeight;
    double minTop = statusBarHeight;
    double maxTop = bubbleHeight;

    List<Rect>? generateNonOverlappingImages(int minSize) {
      List<Rect> occupiedPositions = [];
      for (int i = 0; i < testImages.length; i++) {
        double size = random.nextDouble() * minSize + minSize; // Ensure minimum size
        bool isPositionValid = false;
        Rect? position;

        // Generate a random position that does not overlap with any existing positions
        int tryCount = 0;
        while (!isPositionValid) {
          double left = random.nextDouble() * (MediaQuery.of(context).size.width - size);
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
    List<Rect> positions = [];
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
    List<Widget> list = [
      Positioned(
        left: 0,
        top: statusBarHeight,
        child: Image.asset(
          'assets/images/bg_bubble.png',
          width: MediaQuery.of(context).size.width,
          height: bubbleHeight,
          fit: BoxFit.cover,
        ),
      ),
    ];
    for (int i = 0; i < testImages.length && i < positions.length; i++) {
      double borderWidth = positions[i].width * 3 / 46;
      list.add(
        Positioned(
          left: positions[i].left,
          top: positions[i].top,
          child: Container(
            width: positions[i].width,
            height: positions[i].height,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: GradientBoxBorder(
                  width: borderWidth,
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFF0C7FF),
                      Color(0xFFAE42D4),
                    ],
                  )),
            ),
            child: ClipOval(
              child: Image.asset(
                testImages[i],
                width: positions[i].width - borderWidth * 2,
                height: positions[i].height - borderWidth * 2,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      );
    }

    return Stack(
      children: list,
    );
  }
}
