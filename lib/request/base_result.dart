class BaseResult<T> {
  final T? data;
  final Exception? error;
  final String? errMsg;

  BaseResult({this.data, this.error, this.errMsg});

  @override
  String toString() {
    return 'BaseResult{data: $data, error: $error, errMsg: $errMsg}';
  }
}
