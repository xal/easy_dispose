import 'dart:async';

import 'package:easy_dispose/easy_dispose.dart';
import 'package:flutter/widgets.dart';

/// Disposable implementation for [WidgetsBinding]
class WidgetsBindingObserverDisposable extends Disposable {
  /// [WidgetsBinding] to dispose
  final WidgetsBinding widgetsBinding;

  /// see [WidgetsBinding] addObserver details
  final WidgetsBindingObserver observer;

  /// Default constructor
  WidgetsBindingObserverDisposable(
    this.widgetsBinding,
    this.observer,
  ) {
    widgetsBinding.addObserver(observer);
  }

  @override
  Future performDispose() async {
    widgetsBinding.removeObserver(observer);
  }
}

/// add [observeAsDisposable] to [WidgetsBinding]
extension WidgetsBindingDisposableExtension on WidgetsBinding {
  /// shortcut to create [WidgetsBindingObserverDisposable]
  WidgetsBindingObserverDisposable observeAsDisposable(
    WidgetsBindingObserver observer,
  ) =>
      WidgetsBindingObserverDisposable(
        this,
        observer,
      );
}
