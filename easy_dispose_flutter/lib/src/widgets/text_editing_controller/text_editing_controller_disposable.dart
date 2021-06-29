import 'dart:async';

import 'package:easy_dispose/easy_dispose.dart';
import 'package:flutter/widgets.dart';

/// Disposable implementation for [TextEditingController]
class TextEditingControllerDisposable extends Disposable {
  /// [TextEditingController] to dispose
  final TextEditingController textEditingController;

  /// Default constructor
  TextEditingControllerDisposable(
    this.textEditingController,
  );

  @override
  Future performDispose() async {
    textEditingController.dispose();
  }
}

/// add [disposeWith] to [TextEditingController]
extension TextEditingControllerDisposableExtension on TextEditingController {
  /// shortcut to add [TextEditingControllerDisposable]
  /// to [ICompositeDisposable]
  void disposeWith(ICompositeDisposable compositeDisposable) {
    compositeDisposable.addDisposable(
      TextEditingControllerDisposable(
        this,
      ),
    );
  }
}
