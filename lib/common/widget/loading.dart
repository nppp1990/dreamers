import 'package:dreamer/constants/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef ResultConvert<T, U> = U? Function(T?);
typedef ContentWidgetBuilder<T> = Widget Function(BuildContext, T);

class FutureLoading<T, U> extends StatefulWidget {
  final AsyncValueGetter<T> futureBuilder;
  final ContentWidgetBuilder<U> contentBuilder;
  final String? errorText;
  final ResultConvert<T, U> convert;

  const FutureLoading({super.key, required this.futureBuilder, required this.contentBuilder, this.errorText, required this.convert});

  @override
  State<StatefulWidget> createState() => _FutureLoadingState<T, U>();
}

class _FutureLoadingState<T, U> extends State<FutureLoading<T, U>> {
  late Future<T> _future;

  @override
  void initState() {
    super.initState();
    _future = widget.futureBuilder();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: DreamerColors.primary,
            ));
          }
          U? res;
          if (snapshot.hasData) {
            res = widget.convert(snapshot.data);
          }
          if (res != null) {
            return widget.contentBuilder(context, res);
          } else {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/empty.png',
                    width: 140,
                    height: 140,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.errorText ?? 'Something went wrong',
                    style: const TextStyle(
                      color: DreamerColors.black1,
                      fontSize: 16,
                    ),
                  ),
                  // retry
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _future = widget.futureBuilder();
                      });
                    },
                    child: const Text('Retry', style: TextStyle(color: DreamerColors.primary)),
                  ),
                ],
              ),
            );
          }
        });
  }
}

enum LoadingType {
  loading,
  // error,
  empty,
  success,
}

typedef ContentChildBuilder = Widget Function();

class Loading extends StatelessWidget {
  final LoadingType type;

  // final VoidCallback? onRefresh;
  // final VoidCallback? onPressEmpty;
  final ContentChildBuilder builder;
  final ContentChildBuilder? loadingBuilder;
  final ContentChildBuilder? emptyBuilder;

  const Loading({
    super.key,
    required this.type,
    required this.builder,
    this.loadingBuilder,
    this.emptyBuilder,
  });

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case LoadingType.loading:
        return _buildLoading();
      // case LoadingType.error:
      //   return _buildError();
      case LoadingType.empty:
        return _buildEmpty();
      case LoadingType.success:
        return builder.call();
    }
  }

  Widget _buildLoading() {
    if (loadingBuilder != null) {
      return loadingBuilder!.call();
    }
    return const Center(
      child: Padding(
        padding: EdgeInsets.only(bottom: 100),
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildEmpty() {
    if (emptyBuilder != null) {
      return emptyBuilder!.call();
    }
    return Center(
      child: Image.asset(
        'assets/images/empty.png',
        width: 140,
        height: 140,
      ),
    );
  }
}
