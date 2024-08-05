import 'package:dreamer/common/tindercard/flutter_tindercard_plus.dart';
import 'package:dreamer/common/widget/bg_page.dart';
import 'package:dreamer/page/home/swipe_card.dart';
import 'package:flutter/material.dart';

class SwipePage extends StatelessWidget {
  const SwipePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageBackground(
      assetImage: const AssetImage('assets/images/bg_base1.png'),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SwipeCardView(height: constraints.maxHeight, width: constraints.maxWidth);
          },
        ),
      ),
    );
  }
}

class SwipeCardView extends StatefulWidget {
  final double height;
  final double width;

  const SwipeCardView({super.key, required this.height, required this.width});

  @override
  State<StatefulWidget> createState() => _SwipeCardViewState();
}

class _SwipeCardViewState extends State<SwipeCardView> {
  static const testAbout =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
      '\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
      '\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.';

  static final List<SwipeCardInfo> testInfoList = [
    const SwipeCardInfo(
      userName: 'John Doe',
      desc: 'Hello! I’m John.',
      avatarUrl: 'https://pic1.zhimg.com/v2-d24a84ea4ea3e152f5eb035b736caf97_r.jpg',
      about: testAbout,
    ),
    const SwipeCardInfo(
      userName: 'Jane Doe',
      desc: 'Hello! I’m Jane.',
      avatarUrl: 'https://picx.zhimg.com/v2-86c411ee09650ce48ab40eee88a82a5a_r.jpg',
      about: testAbout,
    ),
    const SwipeCardInfo(
      userName: 'Jack Doe',
      desc: 'Hello! I’m Jack.',
      avatarUrl: 'https://img2.woyaogexing.com/2021/03/02/395e91b43ac74217935de343600ea51b%21400x400.jpeg',
      about: 'test------\ntest \ntest',
    ),
    const SwipeCardInfo(
      userName: 'Jill Doe',
      desc: 'Hello! I’m Jill.',
      avatarUrl: 'https://img2.woyaogexing.com/2021/03/02/411c00abc54446d99eb4c933578d06bf%21400x400.jpeg',
      about: 'test \n test \n test\n this is a long text',
    ),
    const SwipeCardInfo(
      userName: 'Jim Doe',
      desc: 'Hello! I’m Jim.',
      avatarUrl: 'https://picx.zhimg.com/v2-13b79479d87b35fc328c35fabb275aaa_r.jpg',
      about: 'test \n test \n test\n this is a long text\n this is a long text',
    ),
    const SwipeCardInfo(
      userName: 'Jenny Doe',
      desc: 'Hello! I’m Jenny.\n lalalala',
      avatarUrl: 'https://c-ssl.dtstatic.com/uploads/blog/202103/04/20210304093424_67c7e.thumb.1000_0.jpg',
      about: testAbout,
    ),
  ];

  late CardController _cardController;

  late List<SwipeCardInfo> _dataList;
  List<SwipeCardInfo> _moreData = [];
  int _testIndex = testInfoList.length;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _cardController = CardController();
    _dataList = List.from(testInfoList);
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('-----build');
    return TinderSwapCard(
      swipeUp: true,
      swipeDown: true,
      orientation: AmassOrientation.bottom,
      totalNum: _dataList.length,
      stackNum: 3,
      swipeEdge: 4.0,
      maxWidth: widget.width,
      maxHeight: widget.height,
      minWidth: widget.width * 0.8,
      minHeight: widget.height * 0.8,
      cardBuilder: (context, index) => SwipeCard(info: _dataList[index]),
      cardController: _cardController,
      swipeUpdateCallback: (DragUpdateDetails details, Alignment align) {
        /// Get swiping card's alignment
        if (align.x < 0) {
          //Card is LEFT swiping
        } else if (align.x > 0) {
          //Card is RIGHT swiping
        }
        // debugPrint('align: $align');
      },
      swipeCompleteCallback: (CardSwipeOrientation orientation, int index) {
        debugPrint('index: $index, orientation: $orientation----${_dataList.length}');
        if (_dataList.length - index <= 6) {
          // load more data
          _loadMoreData();
        }
        if (_moreData.isNotEmpty) {
          setState(() {
            // _dataList.sublist(index, length-1)
            if (_dataList.isEmpty) {
              _dataList = _moreData;
            } else {
              // _dataList = _moreData;
              _dataList = List<SwipeCardInfo>.from(_dataList.sublist(index + 1))..addAll(_moreData);
            }
            for (int i = 0; i < _dataList.length; i++) {
              debugPrint('dataList: ${_dataList[i].userName}');
            }
            print('dataList: ${_dataList.length}');
            _moreData = [];
          });
        }
      },
    );
  }

  void _loadMoreData() async {
    debugPrint('try load more data');
    if (isLoading || _moreData.isNotEmpty) {
      return;
    }
    debugPrint('loading more data');
    isLoading = true;
    await Future.delayed(const Duration(milliseconds: 2000), () {
      final tempList = List<SwipeCardInfo>.from(testInfoList)..shuffle();
      _moreData = [];
      for (int i = 0; i < tempList.length; i++) {
        _moreData.add(tempList[i].copyWith(userName: '${tempList[i].userName}: ${_testIndex + i}'));
      }
      _testIndex += tempList.length;
    });
    isLoading = false;
  }
}
