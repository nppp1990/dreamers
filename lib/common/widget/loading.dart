import 'package:flutter/material.dart';

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
