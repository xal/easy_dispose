library easy_dispose_test;

import 'dart:async';

import 'package:easy_dispose/src/stream_subscription_disposable.dart';
import 'package:test/test.dart';

// ignore_for_file: no-magic-number
void main() {
  test('StreamSubscriptionDisposable isDisposed', () async {
    final streamSubscriptionDisposable = StreamSubscriptionDisposable(
      _createTestStreamSubscription(),
    );
    expect(streamSubscriptionDisposable.isDisposed, isFalse);

    await streamSubscriptionDisposable.dispose();
    expect(streamSubscriptionDisposable.isDisposed, isTrue);
  });

  test('StreamSubscriptionDisposable disposeCallback', () async {
    // ignore: close_sinks
    final streamController = StreamController();

    int? listenedValue;

    // ignore: cancel_subscriptions
    final streamSubscription = streamController.stream.listen(
      (value) {
        listenedValue = value;
      },
    );
    final streamSubscriptionDisposable =
        StreamSubscriptionDisposable(streamSubscription);

    expect(listenedValue, isNull);

    streamController.add(1);
    await Future.delayed(
      const Duration(
        milliseconds: 500,
      ),
    );
    expect(listenedValue, 1);

    await streamSubscriptionDisposable.dispose();

    streamController.add(2);
    await Future.delayed(
      const Duration(
        milliseconds: 500,
      ),
    );

    // still old value
    expect(listenedValue, 1);
  });
}

StreamSubscription _createTestStreamSubscription() => Stream.value(null).listen(
      // ignore: no-empty-block
      (_) {},
    );
