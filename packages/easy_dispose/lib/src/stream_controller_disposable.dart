import 'dart:async';

import 'composite_disposable.dart';
import 'disposable.dart';

/// Disposable implementation for [StreamController]
class StreamControllerDisposable extends Disposable {
  /// [StreamController] to dispose
  final StreamController streamController;

  /// Default constructor
  StreamControllerDisposable(
    this.streamController,
  );

  @override
  Future<void> performDispose() async {
    // see streamController.close() docs why it is not awaited
    // ignore: unawaited_futures, avoid-ignoring-return-values
    streamController.close();
  }
}

/// add [disposeWith] to [StreamController]
extension StreamControllerDisposableExtension on StreamController {
  /// shortcut to add [StreamControllerDisposable] to [ICompositeDisposable]
  void disposeWith(ICompositeDisposable compositeDisposable) {
    compositeDisposable.addDisposable(
      StreamControllerDisposable(
        this,
      ),
    );
  }
}
