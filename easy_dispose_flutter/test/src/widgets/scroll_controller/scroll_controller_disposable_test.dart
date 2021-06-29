library easy_dispose_flutter_test;

import 'package:easy_dispose_flutter/src/widgets/scroll_controller/scroll_controller_disposable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart' as matcher;

void main() {
  test('ScrollControllerDisposable isDisposed', () async {
    final scrollControllerDisposable = ScrollControllerDisposable(
      _createTestScrollController(),
    );
    expect(scrollControllerDisposable.isDisposed, isFalse);

    await scrollControllerDisposable.dispose();
    expect(scrollControllerDisposable.isDisposed, isTrue);
  });

  test('ScrollControllerDisposable disposeCallback', () async {
    final scrollController = _createTestScrollController();
    final scrollControllerDisposable =
        ScrollControllerDisposable(scrollController);

    // not throws exception
    scrollController.notifyListeners();

    await scrollControllerDisposable.dispose();
    expect(
      () => scrollController.notifyListeners(),
      throwsA(
        // ignore:
        const matcher.TypeMatcher<FlutterError>(),
      ),
    );
  });
}

ScrollController _createTestScrollController() => ScrollController();
