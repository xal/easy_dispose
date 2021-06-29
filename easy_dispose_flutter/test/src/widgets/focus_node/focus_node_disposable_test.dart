library easy_dispose_flutter_test;

import 'package:easy_dispose_flutter/src/widgets/focus_node/focus_node_disposable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart' as matcher;

void main() {
  test('FocusNodeDisposable isDisposed', () async {
    final focusNodeDisposable = FocusNodeDisposable(
      _createTestFocusNode(),
    );
    expect(focusNodeDisposable.isDisposed, isFalse);

    await focusNodeDisposable.dispose();
    expect(focusNodeDisposable.isDisposed, isTrue);
  });

  test('FocusNodeDisposable disposeCallback', () async {
    final focusNode = _createTestFocusNode();
    final focusNodeDisposable = FocusNodeDisposable(focusNode);

    // not throws exception
    focusNode.notifyListeners();

    await focusNodeDisposable.dispose();
    expect(
      () => focusNode.notifyListeners(),
      throwsA(
        // ignore:
        const matcher.TypeMatcher<FlutterError>(),
      ),
    );
  });
}

FocusNode _createTestFocusNode() => FocusNode();
