library easy_dispose_test;

import 'dart:async';

import 'package:easy_dispose/src/timer_disposable.dart';
import 'package:test/test.dart';

void main() {
  test('TimerDisposable isDisposed', () async {
    final timerDisposable = TimerDisposable(
      _createTestTimer(),
    );
    expect(timerDisposable.isDisposed, isFalse);

    await timerDisposable.dispose();
    expect(timerDisposable.isDisposed, isTrue);
  });

  test('TimerDisposable disposeCallback', () async {
    final timer = _createTestTimer();
    final timerDisposable = TimerDisposable(timer);

    expect(timer.isActive, isTrue);
    await timerDisposable.dispose();
    expect(timer.isActive, isFalse);
  });
}

Timer _createTestTimer() => Timer(
      const Duration(seconds: 10),
      // ignore: no-empty-block
      () {},
    );
