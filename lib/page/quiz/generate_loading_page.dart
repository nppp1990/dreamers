import 'package:dreamer/common/widget/bg_page.dart';
import 'package:dreamer/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GeneratingDreamPage extends StatelessWidget {
  const GeneratingDreamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageBackground(
      assetImage: const AssetImage('assets/images/bg_base1.png'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 200,
            width: double.infinity,
          ),
          _LogoLoading(
            logo: SvgPicture.asset(
              'assets/images/icons/ic_generate_loading.svg',
              width: 80,
              height: 80,
              colorFilter: const ColorFilter.mode(
                DreamerColors.primary,
                BlendMode.srcIn,
              ),
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          const _TextLoading(
            text: 'Generating your story',
            dotCount: 3,
            textStyle: TextStyle(
              fontSize: 16,
              height: 19 / 16,
              fontWeight: FontWeight.w500,
              color: DreamerColors.brown,
            ),
          ),
          const SizedBox(
            height: 96,
          ),
          ElevatedButton(
            onPressed: () {
              // todo j
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              backgroundColor: DreamerColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            child: const Text(
              'Back to Home',
              style: TextStyle(
                fontSize: 16,
                height: 19 / 16,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 56, right: 56, top: 16),
            child: Text(
              textAlign: TextAlign.center,
              'You can leave here, and we will let you know after your story is ready',
              style: TextStyle(
                fontSize: 16,
                height: 19 / 16,
                fontWeight: FontWeight.w500,
                color: DreamerColors.brown,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LogoLoading extends StatefulWidget {
  final Widget logo;

  const _LogoLoading({super.key, required this.logo});

  @override
  State<StatefulWidget> createState() => _LogoLoadingState();
}

class _LogoLoadingState extends State<_LogoLoading> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: CurvedAnimation(parent: _controller, curve: Curves.linear),
      child: widget.logo,
    );
  }
}

class _TextLoading extends StatefulWidget {
  final String text;
  final int dotCount;
  final TextStyle textStyle;

  const _TextLoading({required this.text, required this.dotCount, required this.textStyle});

  @override
  State<StatefulWidget> createState() => _TextLoadingState();
}

class _TextLoadingState extends State<_TextLoading> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500 * widget.dotCount),
      vsync: this,
    )..repeat();
    _animation = IntTween(begin: 0, end: widget.dotCount).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.text,
              style: widget.textStyle,
            ),
            SizedBox(
              width: widget.dotCount * 8.0,
              child: Text(
                List.generate(_animation.value, (index) => '.').join(),
                style: widget.textStyle,
              ),
            )
          ],
        );
      },
    );
  }
}
