import 'package:dreamer/common/router/router_utils.dart';
import 'package:dreamer/common/widget/base_normal_page.dart';
import 'package:dreamer/common/widget/bg_page.dart';
import 'package:dreamer/common/widget/loading.dart';
import 'package:dreamer/constants/colors.dart';
import 'package:dreamer/page/quiz/quiz_category.dart';
import 'package:dreamer/page/quiz/quiz_loading.dart';
import 'package:dreamer/page/quiz/quiz_question.dart';
import 'package:dreamer/page/quiz/quiz_result_card.dart';
import 'package:dreamer/request/base_result.dart';
import 'package:dreamer/request/bean/quiz.dart';
import 'package:dreamer/request/request_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TakeQuizPage extends StatelessWidget {
  final Quiz quiz;

  const TakeQuizPage({super.key, required this.quiz});

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.viewPaddingOf(context).top;
    return PageBackground(
      assetImage: const AssetImage('assets/images/bg_base1.png'),
      child: Column(
        children: [
          SizedBox(
            height: statusBarHeight,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: SvgPicture.asset(
                  'assets/images/icons/ic_close.svg',
                  width: 28,
                  height: 28,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 130),
          Text(
            quiz.title,
            style: const TextStyle(
              fontSize: 24,
              height: 28.6 / 24,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          Text(
            '${quiz.layer}st layer questions',
            style: const TextStyle(
              fontSize: 17,
              height: 20.3 / 17,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 230),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: QuestionsLoadingButton(quiz: quiz),
          ),
        ],
      ),
    );
  }
}

class QuizQuestionPage extends StatelessWidget {
  // start from 0
  final int index;
  final QuestionInfo questionInfo;
  final List<int?> selectedOptions;

  const QuizQuestionPage({
    super.key,
    required this.questionInfo,
    required this.index,
    required this.selectedOptions,
  });

  @override
  Widget build(BuildContext context) {
    final question = questionInfo.questions[index];
    final title = question.content;
    final options = question.options.map((e) => e.content).toList();
    final statusBarHeight = MediaQuery.viewPaddingOf(context).top;
    return PageBackground(
      assetImage: const AssetImage('assets/images/bg_base1.png'),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: statusBarHeight + 35),
            Row(
              children: [
                _buildBtn('Back', DreamerColors.black1, () {
                  Navigator.pop(context);
                }),
                const Spacer(),
                _buildBtn('Next', DreamerColors.primary, () {
                  if (index + 1 < questionInfo.questions.length) {
                    Navigator.of(context).push(Right2LeftRouter(
                        child: QuizQuestionPage(
                      questionInfo: questionInfo,
                      index: index + 1,
                      selectedOptions: selectedOptions,
                    )));
                    // RouterUtils.push(context, QuizQuestionPage(
                    //   questionInfo: questionInfo,
                    //   index: index + 1,
                    //   selectedOptions: selectedOptions,
                    // ));
                  } else {
                    // RouterUtils.push(context, QuizResultPage(
                    //   questionInfo: questionInfo,
                    //   selectedOptions: selectedOptions,
                    // ));
                  }
                }),
              ],
            ),
            const SizedBox(height: 16),
            _buildIndexLabel(index + 1),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                height: 23.8 / 20,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            QuizStepIndicator(total: questionInfo.questions.length, current: index),
            const SizedBox(height: 24),
            QuizOptionListView(
              options: options,
              selectedOption: selectedOptions[index],
              onSelected: (optionIndex) {
                selectedOptions[index] = optionIndex;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBtn(String label, Color color, VoidCallback onPressed) {
    return SizedBox(
      height: 24,
      width: 73,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(0),
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            height: 14.3 / 12,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildIndexLabel(int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Text(
        'Q$index',
        style: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 20,
          height: 23.4 / 20,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
      ),
    );
  }
}

class QuizListPage extends StatelessWidget {
  const QuizListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return NormalPage(
        title: 'Quizzes',
        bottomPadding: false,
        child: Container(
          margin: const EdgeInsets.only(top: 12),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: FutureLoading<BaseResult<List<QuizInfo>>, List<QuizInfo>>(
            convert: (result) => result?.data,
            futureBuilder: RequestManager().getQuizzes,
            // futureBuilder: loadData,
            contentBuilder: (context, data) {
              addTestData(data);
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var quizInfo in data) ...[
                        CategoryQuizzes(quizInfo: quizInfo),
                        const SizedBox(height: 16),
                      ]
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }

  Future<BaseResult<List<QuizInfo>>> loadData() {
    return Future.delayed(const Duration(seconds: 1), () => BaseResult(data: []));
  }

  addTestData(List<QuizInfo> list) {
    list.addAll([
      QuizInfo(categoryName: 'For you22222', quizzes: [
        Quiz(
            title: 'Personality',
            imageUrl: 'https://i0.hdslb.com/bfs/archive/bd0dee2db09ff7aac805215df5b56b59898fd07f.jpg',
            layer: 1,
            id: '1'),
        Quiz(
            title: 'too long title too long title to long title',
            imageUrl: 'https://i0.hdslb.com/bfs/archive/bd0dee2db09ff7aac805215df5b56b59898fd07f.jpg',
            layer: 2,
            id: '2'),
        Quiz(
            title: 'title3',
            imageUrl: 'https://i0.hdslb.com/bfs/archive/bd0dee2db09ff7aac805215df5b56b59898fd07f.jpg',
            layer: 3,
            id: '3'),
        Quiz(
            title: 'title4',
            imageUrl: 'https://i0.hdslb.com/bfs/archive/bd0dee2db09ff7aac805215df5b56b59898fd07f.jpg',
            layer: 4,
            id: '4'),
        Quiz(
            title: 'title5',
            imageUrl: 'https://i0.hdslb.com/bfs/archive/bd0dee2db09ff7aac805215df5b56b59898fd07f.jpg',
            layer: 5,
            id: '5'),
      ]),
      QuizInfo(categoryName: 'tag2', quizzes: [
        Quiz(
            title: 'title6',
            imageUrl: 'https://i0.hdslb.com/bfs/archive/c767587cee407f2d7bf7ef40efe9e90d88e2dd82.jpg',
            layer: 6,
            id: '6'),
        Quiz(
            title: 'title7',
            imageUrl: 'https://i0.hdslb.com/bfs/archive/c767587cee407f2d7bf7ef40efe9e90d88e2dd82.jpg',
            layer: 7,
            id: '7'),
        Quiz(
            title: 'title8',
            imageUrl: 'https://i0.hdslb.com/bfs/archive/bd0dee2db09ff7aac805215df5b56b59898fd07f.jpg',
            layer: 8,
            id: '8'),
        Quiz(
            title: 'title9',
            imageUrl: 'https://i0.hdslb.com/bfs/archive/c767587cee407f2d7bf7ef40efe9e90d88e2dd82.jpg',
            layer: 9,
            id: '9'),
        Quiz(
            title: 'title10',
            imageUrl: 'https://i0.hdslb.com/bfs/archive/bd0dee2db09ff7aac805215df5b56b59898fd07f.jpg',
            layer: 10,
            id: '10'),
      ]),
      QuizInfo(categoryName: 'tag3', quizzes: [
        Quiz(
            title: 'title6',
            imageUrl: 'https://i0.hdslb.com/bfs/archive/c767587cee407f2d7bf7ef40efe9e90d88e2dd82.jpg',
            layer: 6,
            id: '6'),
        Quiz(
            title: 'title7',
            imageUrl: 'https://i0.hdslb.com/bfs/archive/c767587cee407f2d7bf7ef40efe9e90d88e2dd82.jpg',
            layer: 7,
            id: '7'),
        Quiz(
            title: 'title8',
            imageUrl: 'https://i0.hdslb.com/bfs/archive/bd0dee2db09ff7aac805215df5b56b59898fd07f.jpg',
            layer: 8,
            id: '8'),
        Quiz(
            title: 'title9',
            imageUrl: 'https://i0.hdslb.com/bfs/archive/c767587cee407f2d7bf7ef40efe9e90d88e2dd82.jpg',
            layer: 9,
            id: '9'),
        Quiz(
            title: 'title10',
            imageUrl: 'https://i0.hdslb.com/bfs/archive/bd0dee2db09ff7aac805215df5b56b59898fd07f.jpg',
            layer: 10,
            id: '10'),
      ]),
      QuizInfo(categoryName: 'tag4', quizzes: [
        Quiz(
            title: 'title6',
            imageUrl: 'https://i0.hdslb.com/bfs/archive/c767587cee407f2d7bf7ef40efe9e90d88e2dd82.jpg',
            layer: 6,
            id: '6'),
        Quiz(
            title: 'title7',
            imageUrl: 'https://i0.hdslb.com/bfs/archive/c767587cee407f2d7bf7ef40efe9e90d88e2dd82.jpg',
            layer: 7,
            id: '7'),
        Quiz(
            title: 'title8',
            imageUrl: 'https://i0.hdslb.com/bfs/archive/bd0dee2db09ff7aac805215df5b56b59898fd07f.jpg',
            layer: 8,
            id: '8'),
        Quiz(
            title: 'title9',
            imageUrl: 'https://i0.hdslb.com/bfs/archive/c767587cee407f2d7bf7ef40efe9e90d88e2dd82.jpg',
            layer: 9,
            id: '9'),
        Quiz(
            title: 'title10',
            imageUrl: 'https://i0.hdslb.com/bfs/archive/bd0dee2db09ff7aac805215df5b56b59898fd07f.jpg',
            layer: 10,
            id: '10'),
      ]),
    ]);
  }
}

class QuizResultPage extends StatelessWidget {
  final String title;
  final String content;
  final String desc;

  const QuizResultPage({super.key, required this.title, required this.content, required this.desc});

  @override
  Widget build(BuildContext context) {
    return PageBackground(
      assetImage: const AssetImage('assets/images/bg_base1.png'),
      child: QuizResultContainer(
        title: title,
        content: content,
        desc: desc,
      ),
    );
  }
}
