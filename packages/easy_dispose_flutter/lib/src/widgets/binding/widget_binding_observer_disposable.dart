import 'dart:async';

import 'package:easy_dispose/easy_dispose.dart';
import 'package:flutter/widgets.dart';

/// Disposable implementation for [WidgetsBinding]
class WidgetBindingObserverDisposable extends Disposable {
  /// [WidgetsBinding] to dispose
  final WidgetsBinding widgetsBinding;

  /// see [WidgetsBinding] addObserver details
  final WidgetsBindingObserver observer;

  /// Default constructor
  WidgetBindingObserverDisposable(
    this.widgetsBinding,
    this.observer,
  ) {
    widgetsBinding.addObserver(observer);
  }

  @override
  Future<void> performDispose() async {
    // ignore: avoid-ignoring-return-values
    widgetsBinding.removeObserver(observer);
  }
}

/// add [observeAsDisposable] to [WidgetsBinding]
extension WidgetsBindingDisposableExtension on WidgetsBinding {
  /// shortcut to create [WidgetBindingObserverDisposable]
  WidgetBindingObserverDisposable observeAsDisposable(
    WidgetsBindingObserver observer,
  ) =>
      WidgetBindingObserverDisposable(
        this,
        observer,
      );
}
