library easy_dispose_test;

import 'dart:async';

import 'package:easy_dispose/src/stream_controller_disposable.dart';
import 'package:test/test.dart';

void main() {
  test('StreamControllerDisposable isDisposed', () async {
    var streamControllerDisposable = StreamControllerDisposable(
      _createTestStreamController(),
    );
    expect(streamControllerDisposable.isDisposed, isFalse);

    await streamControllerDisposable.dispose();
    expect(streamControllerDisposable.isDisposed, isTrue);
  });

  test('StreamControllerDisposable disposeCallback', () async {
    var streamController = _createTestStreamController();
    var streamControllerDisposable =
        StreamControllerDisposable(streamController);

    expect(streamController.isClosed, isFalse);
    await streamControllerDisposable.dispose();
    expect(streamController.isClosed, isTrue);
  });
}

StreamController _createTestStreamController() => StreamController();
