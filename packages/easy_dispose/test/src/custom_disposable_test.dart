library easy_dispose_test;

import 'package:easy_dispose/src/custom_disposable.dart';
import 'package:test/test.dart';

void main() {
  test('CustomDisposable isDisposed', () async {
    // ignore: no-empty-block
    Future disposeCallback() async {}
    final customDisposable = CustomDisposable(disposeCallback);
    expect(customDisposable.isDisposed, isFalse);

    await customDisposable.dispose();
    expect(customDisposable.isDisposed, isTrue);
  });

  test('CustomDisposable disposeCallback', () async {
    var callbackCalled = false;

    Future disposeCallback() async {
      callbackCalled = true;
    }

    final customDisposable = CustomDisposable(disposeCallback);

    expect(callbackCalled, isFalse);
    await customDisposable.dispose();
    expect(callbackCalled, isTrue);
  });
}
