import 'package:dreamer/common/router/router_utils.dart';
import 'package:dreamer/common/utils/local_storage.dart';
import 'package:dreamer/common/widget/BubbleGuideDialog.dart';
import 'package:dreamer/common/widget/loading.dart';
import 'package:dreamer/constants/colors.dart';
import 'package:dreamer/data/dreamer_icons.dart';
import 'package:dreamer/page/quiz/quiz_page.dart';
import 'package:dreamer/request/base_result.dart';
import 'package:dreamer/request/bean/dream.dart';
import 'package:flutter/material.dart';

class DreamListView extends StatelessWidget {
  const DreamListView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureLoading<BaseResult<List<Dream>>, List<Dream>>(
      convert: (baseResult) => baseResult?.data,
      // todo
      futureBuilder: () => Future.delayed(const Duration(seconds: 1), () => BaseResult(
        data: [
          Dream(id: '1', title: 'Dream 1', imageUrl: '', layer: 1),
          Dream(id: '2', title: 'Dream 2', imageUrl: '', layer: 2),
          Dream(id: '3', title: 'Dream 3', imageUrl: '', layer: 3),
        ]
      )),
      contentBuilder: (context, data) {
        // print('------data: $data');
        // List<Quiz> list = [];
        // list.addAll(data);
        // list.sort((a, b) => a.layer.compareTo(b.layer));
        // if (data.length < 3) {
        //   for (int i = data.length; i < 3; i++) {
        //     list.add(Quiz(id: 'empty_$i', title: 'title${i + 1}', imageUrl: '', layer: i + 1));
        //   }
        // }
        return SingleChildScrollView(
            child: _DreamList(
          dreams: data,
          openIndex: data.length - 1,
        ));
      },
      emptyCheck: (data) => data.isNotEmpty,
    );
  }
}

class _DreamList extends StatelessWidget {
  final List<Dream> dreams;
  final int openIndex;

  const _DreamList({required this.dreams, this.openIndex = 0});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (int i = 0; i < dreams.length; i++)
            // const SizedBox(height: 12),
            ...[
            GestureDetector(
              onTap: () {
                // todo test
                // Navigator.of(context).push(Right2LeftRouter(child: DreamContentPage(index: i)));
                // RequestManager().getQuestions(quizzes[i].id).then((value) {
                //   print('------value: $value');
                // });
              },
              child: _DreamItem(
                index: i + 1,
                title: dreams[i].title,
                lock: i > openIndex,
                showBubbleGuide: i == 0,
              ),
            ),
            const SizedBox(height: 12),
          ],
          const SizedBox(height: 36),
          ElevatedButton(
            style: ButtonStyle(
              padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              backgroundColor: WidgetStateProperty.all<Color>(
                DreamerColors.primary,
              ),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
            child: const Text(
              'Quizzes',
              style: TextStyle(
                fontSize: 12,
                height: 14.3 / 12,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            onPressed: () {
              Navigator.of(context).push(Right2LeftRouter(child: const QuizListPage()));
            },
          )
        ],
      ),
    );
  }
}

class _DreamItem extends StatefulWidget {
  final int index;
  final String title;
  final bool lock;
  final bool showBubbleGuide;

  const _DreamItem({required this.index, required this.title, this.lock = false, this.showBubbleGuide = false});

  @override
  State<StatefulWidget> createState() => _DreamItemState();
}

class _DreamItemState extends State<_DreamItem> {
  static const String _bubbleGuideShowedKey = 'hasShowedBubbleGuide';

  bool _hasShowedBubbleGuide = false;

  int get index => widget.index;

  String get title => widget.title;

  bool get lock => widget.lock;

  @override
  void initState() {
    super.initState();
    _initBubbleGuide();
  }

  _initBubbleGuide() async {
    if (!widget.showBubbleGuide) {
      return;
    }
    final hasShowedBubbleGuide = await LocalStorage.getDataOrDefault<bool>(_bubbleGuideShowedKey, false);
    if (hasShowedBubbleGuide || _hasShowedBubbleGuide) {
      return;
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (_hasShowedBubbleGuide) {
        return;
      }
      _hasShowedBubbleGuide = true;
      LocalStorage.saveData(_bubbleGuideShowedKey, true);
      final renderBox = context.findRenderObject() as RenderBox;
      final Offset offset = renderBox.localToGlobal(Offset.zero);
      showBubbleGuideDialog(context, Offset(16, offset.dy - 12),
          'We have 3 layers of Dream. Dream is a content generated  by AI based on questions and your answers.');
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget container = Container(
      height: 115,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: AssetImage('assets/images/bg_dream.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: DreamerColors.primary,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Text(
                'Dream $index',
                style: const TextStyle(
                  fontSize: 10,
                  height: 12 / 10,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 8,
            left: 8,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                height: 21.5 / 18,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          if (lock)
            const Positioned(
              bottom: 16,
              right: 16,
              child: Icon(
                DreamerIcons.lock,
                color: Colors.white,
                size: 24,
              ),
            ),
        ],
      ),
    );
    if (lock) {
      return Stack(
        children: [
          container,
          Container(
            height: 115,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ],
      );
    } else {
      return container;
    }
  }
}
