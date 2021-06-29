import 'dart:async';

import 'package:easy_dispose/easy_dispose.dart';
import 'package:flutter/widgets.dart';

/// Disposable implementation for [FocusNode]
class FocusNodeDisposable extends Disposable {
  /// [FocusNode] to dispose
  final FocusNode focusNode;

  /// Default constructor
  FocusNodeDisposable(
    this.focusNode,
  );

  @override
  Future performDispose() async {
    focusNode.dispose();
  }
}

/// add [disposeWith] to [FocusNode]
extension FocusNodeDisposableExtension on FocusNode {
  /// shortcut to add [FocusNodeDisposable]
  /// to [ICompositeDisposable]
  void disposeWith(ICompositeDisposable compositeDisposable) {
    compositeDisposable.addDisposable(
      FocusNodeDisposable(
        this,
      ),
    );
  }
}
