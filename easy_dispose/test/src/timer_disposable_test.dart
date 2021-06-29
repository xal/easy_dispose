library easy_dispose_test;

import 'dart:async';

import 'package:easy_dispose/src/timer_disposable.dart';
import 'package:test/test.dart';

void main() {
  test('TimerDisposable isDisposed', () async {
    var timerDisposable = TimerDisposable(
      _createTestTimer(),
    );
    expect(timerDisposable.isDisposed, isFalse);

    await timerDisposable.dispose();
    expect(timerDisposable.isDisposed, isTrue);
  });

  test('TimerDisposable disposeCallback', () async {
    var timer = _createTestTimer();
    var timerDisposable = TimerDisposable(timer);

    expect(timer.isActive, isTrue);
    await timerDisposable.dispose();
    expect(timer.isActive, isFalse);
  });
}

Timer _createTestTimer() {
  return Timer(
    const Duration(seconds: 10),
    // ignore: no-empty-block
    () {},
  );
}
