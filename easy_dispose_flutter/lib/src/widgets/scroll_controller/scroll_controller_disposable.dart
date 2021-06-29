import 'dart:async';

import 'package:easy_dispose/easy_dispose.dart';
import 'package:flutter/widgets.dart';

/// Disposable implementation for [ScrollController]
class ScrollControllerDisposable extends Disposable {
  /// [ScrollController] to dispose
  final ScrollController scrollController;

  /// Default constructor
  ScrollControllerDisposable(
    this.scrollController,
  );

  @override
  Future performDispose() async {
    scrollController.dispose();
  }
}

/// add [disposeWith] to [ScrollController]
extension ScrollControllerDisposableExtension on ScrollController {
  /// shortcut to add [ScrollControllerDisposable]
  /// to [ICompositeDisposable]
  void disposeWith(ICompositeDisposable compositeDisposable) {
    compositeDisposable.addDisposable(
      ScrollControllerDisposable(
        this,
      ),
    );
  }
}
