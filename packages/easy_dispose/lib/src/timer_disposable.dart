import 'dart:async';

import 'composite_disposable.dart';
import 'disposable.dart';

/// Disposable implementation for [Timer]
class TimerDisposable extends Disposable {
  /// [Timer] to dispose
  final Timer timer;

  /// Default constructor
  TimerDisposable(this.timer);

  @override
  Future<void> performDispose() async {
    timer.cancel();
  }
}

/// add [disposeWith] to [Timer]
extension TimerDisposableExtension on Timer {
  /// shortcut to add [TimerDisposable] to [ICompositeDisposable]
  void disposeWith(ICompositeDisposable compositeDisposable) {
    compositeDisposable.addDisposable(
      TimerDisposable(
        this,
      ),
    );
  }
}
