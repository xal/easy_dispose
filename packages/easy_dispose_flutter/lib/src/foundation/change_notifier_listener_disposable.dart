import 'dart:async';

import 'package:easy_dispose/easy_dispose.dart';
import 'package:flutter/foundation.dart';

/// Disposable implementation for [ChangeNotifier]
class ChangeNotifierListenerDisposable extends Disposable {
  /// [ChangeNotifier] to dispose
  final ChangeNotifier changeNotifier;

  /// see [ChangeNotifier] addListener details
  final VoidCallback listener;

  /// Default constructor
  ChangeNotifierListenerDisposable(
    this.changeNotifier,
    this.listener,
  ) {
    changeNotifier.addListener(listener);
  }

  @override
  Future<void> performDispose() async {
    changeNotifier.removeListener(listener);
  }
}

/// add [listenAsDisposable] to [ChangeNotifier]
extension ChangeNotifierDisposableExtension on ChangeNotifier {
  /// shortcut to create [ChangeNotifierListenerDisposable]
  ChangeNotifierListenerDisposable listenAsDisposable(
    VoidCallback listener,
  ) =>
      ChangeNotifierListenerDisposable(
        this,
        listener,
      );
}
