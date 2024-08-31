import 'package:dreamer/common/router/router_utils.dart';
import 'package:dreamer/common/utils/dialog_utils.dart';
import 'package:dreamer/constants/colors.dart';
import 'package:dreamer/page/quiz/quiz_page.dart';
import 'package:dreamer/request/base_result.dart';
import 'package:dreamer/request/bean/quiz.dart';
import 'package:dreamer/request/request_manager.dart';
import 'package:flutter/material.dart';

class QuestionsLoadingButton extends StatefulWidget {
  final Quiz quiz;

  const QuestionsLoadingButton({super.key, required this.quiz});

  @override
  State<StatefulWidget> createState() => _QuestionsLoadingButtonState();
}

class _QuestionsLoadingButtonState extends State<QuestionsLoadingButton> {
  QuestionInfo? _questionInfo;
  bool _isLoadingData = false;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _loadData(true);
  }

  void _loadData(bool isInit) async {
    if (_isLoadingData) {
      return;
    }
    _isLoadingData = true;
    final res = await RequestManager().getQuestions(widget.quiz.id);
    // final res = await Future.delayed(const Duration(seconds: 5), () => BaseResult(
    //   data: QuestionInfo(
    //     id: '1',
    //     title: 'Personality Quiz',
    //     questions: [
    //       Question(
    //         id: '1',
    //         content: 'What is your favorite color?',
    //         options: [
    //           QuestionOption(id: '1', content: 'Red', sort: 1),
    //           QuestionOption(id: '2', content: 'Blue', sort: 2),
    //           QuestionOption(id: '3', content: 'Green', sort: 3),
    //           QuestionOption(id: '4', content: 'Yellow', sort: 4),
    //         ],
    //       ),
    //       Question(
    //         id: '2',
    //         content: 'What is your favorite animal?',
    //         options: [
    //           QuestionOption(id: '5', content: 'Dog', sort: 1),
    //           QuestionOption(id: '6', content: 'Cat', sort: 2),
    //           QuestionOption(id: '7', content: 'Elephant', sort: 3),
    //         ],
    //       ),
    //       Question(id: '3', content: 'content3', options: [
    //         QuestionOption(id: '9', content: 'content9', sort: 1),
    //         QuestionOption(id: '10', content: 'content10', sort: 2),
    //         QuestionOption(id: '11', content: 'content11', sort: 3),
    //         QuestionOption(id: '12', content: 'content12', sort: 4),
    //       ]),
    //     ],
    //   ),
    // ));


    if (res.data != null) {
      _questionInfo = res.data;
    } else {
      // todo :Handle error
      debugPrint('load data error: ${res.error}');
    }
    _isLoadingData = false;
    if (mounted && _isSubmitting && _questionInfo != null) {
      Navigator.of(context).pop();
      _goToQuestionPage(_questionInfo!);
    }
  }

  void _onPressed() async {
    if (_isSubmitting) {
      return;
    }
    if (_questionInfo != null) {
      _goToQuestionPage(_questionInfo!);
      return;
    }
    _loadData(false);
    _isSubmitting = true;
    await DialogUtils.showLoading(context);
    _isSubmitting = false;
  }

  void _goToQuestionPage(QuestionInfo questionInfo) {
    if (_questionInfo == null) {
      return;
    }

    Navigator.of(context).push(
      Right2LeftRouter(
        child: QuizQuestionPage(
          questionInfo: questionInfo,
          index: 0,
          selectedOptions: List.generate(questionInfo.questions.length, (index) => null),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          minimumSize: const Size(double.infinity, 0),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          backgroundColor: DreamerColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        onPressed: _onPressed,
        child: const Text(
          'Take personality quiz',
          style: TextStyle(
            fontSize: 16,
            height: 19.1 / 16,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ));
  }
}
