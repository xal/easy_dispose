library easy_dispose_flutter_test;

// ignore_for_file: avoid-ignoring-return-values
import 'package:easy_dispose_flutter/src/material/tab_controller/tab_controller_disposable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart' as matcher;

void main() {
  test('TabControllerDisposable isDisposed', () async {
    final tabControllerDisposable = TabControllerDisposable(
      _createTestTabController(),
    );
    expect(tabControllerDisposable.isDisposed, isFalse);

    await tabControllerDisposable.dispose();
    expect(tabControllerDisposable.isDisposed, isTrue);
  });

  test('TabControllerDisposable disposeCallback', () async {
    final tabController = _createTestTabController();
    final tabControllerDisposable = TabControllerDisposable(tabController);

    // not throws exception
    tabController.notifyListeners();

    await tabControllerDisposable.dispose();
    expect(
      tabController.notifyListeners,
      throwsA(
        // ignore:
        const matcher.TypeMatcher<FlutterError>(),
      ),
    );
  });
}

TabController _createTestTabController() => TabController(
      vsync: const TestVSync(),
      length: 1,
    );
