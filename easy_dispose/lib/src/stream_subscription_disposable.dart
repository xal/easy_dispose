import 'dart:async';

import 'composite_disposable.dart';
import 'disposable.dart';

/// Disposable implementation for [StreamSubscription]
class StreamSubscriptionDisposable extends Disposable {
  /// [StreamSubscription] to dispose
  final StreamSubscription streamSubscription;

  /// Default constructor
  StreamSubscriptionDisposable(
    this.streamSubscription,
  );

  @override
  Future performDispose() async {
    await streamSubscription.cancel();
  }
}

/// add [disposeWith] to [StreamSubscription]
extension StreamSubscriptionDisposableExtension on StreamSubscription {

  /// shortcut to add [StreamSubscriptionDisposable] to [ICompositeDisposable]
  void disposeWith(ICompositeDisposable compositeDisposable) {
    compositeDisposable.addDisposable(
      StreamSubscriptionDisposable(
        this,
      ),
    );
  }
}
