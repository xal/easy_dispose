import 'dart:async';

import 'package:easy_dispose/easy_dispose.dart';
import 'package:flutter/material.dart';

/// Disposable implementation for [TabController]
class TabControllerDisposable extends Disposable {
  /// [TabController] to dispose
  final TabController tabController;

  /// Default constructor
  TabControllerDisposable(
    this.tabController,
  );

  @override
  Future performDispose() async {
    tabController.dispose();
  }
}

/// add [disposeWith] to [TabController]
extension TabControllerDisposableExtension on TabController {
  /// shortcut to add [TabControllerDisposable]
  /// to [ICompositeDisposable]
  void disposeWith(ICompositeDisposable compositeDisposable) {
    compositeDisposable.addDisposable(
      TabControllerDisposable(
        this,
      ),
    );
  }
}
