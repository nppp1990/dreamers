import 'package:dreamer/common/router/router_utils.dart';
import 'package:dreamer/common/widget/image.dart';
import 'package:dreamer/page/quiz/quiz_page.dart';
import 'package:dreamer/request/bean/quiz.dart';
import 'package:flutter/material.dart';

class CategoryQuizzes extends StatelessWidget {
  static const double _quizGap = 16;

  final QuizInfo quizInfo;

  const CategoryQuizzes({super.key, required this.quizInfo});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      final width = constraints.maxWidth;
      final quizzes = quizInfo.quizzes;
      final quizWidth = (width - 2 * _quizGap) / 3;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            quizInfo.categoryName,
            style: const TextStyle(
              fontSize: 16,
              height: 19 / 16,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),
          // 每三个一行
          for (var i = 0; i < quizzes.length; i += 3) ...[
            _buildQuizLine(quizWidth, i, quizzes),
            const SizedBox(height: 16),
          ]
        ],
      );
    });
  }

  Widget _buildQuizLine(double quizWidth, int startIndex, List<Quiz> quizzes) {
    return Row(
      children: [
        for (var i = 0; i < 3; i++)
          if (startIndex + i < quizzes.length) ...[
            _QuizCard(quiz: quizzes[startIndex + i], width: quizWidth),
            if (i != 2) const SizedBox(width: _quizGap),
          ] else ...[
            SizedBox(width: quizWidth),
            if (i != 2) const SizedBox(width: _quizGap),
          ],
      ],
    );
  }
}

class _QuizCard extends StatelessWidget {
  // height/width = 7/6
  static const double _aspectRatio = 6 / 7;

  final Quiz quiz;
  final double width;

  const _QuizCard({required this.quiz, required this.width});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(Bottom2TopRouter(child: TakeQuizPage(quiz: quiz)));
      },
      child: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AspectRatio(
              aspectRatio: _aspectRatio,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedImage(
                  imageUrl: quiz.imageUrl ?? '',
                  showProgress: false,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              quiz.title,
              maxLines: 1,
              style: const TextStyle(
                fontSize: 14,
                height: 16.8 / 14,
                fontWeight: FontWeight.w700,
                overflow: TextOverflow.ellipsis,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
