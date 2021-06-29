library easy_dispose_flutter_test;

import 'package:easy_dispose_flutter/easy_dispose_flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('WidgetsBindingObserverDisposable', () async {
    var observerNotifiedCount = 0;

    final observer = LifecycleEventHandler(
      (state) {
        observerNotifiedCount++;
      },
    );

    final widgetsBinding = _createTestWidgetsBinding();
    final widgetsBindingDisposable = WidgetsBindingObserverDisposable(
      widgetsBinding,
      observer,
    );

    expect(observerNotifiedCount, 0);
    widgetsBinding.handleAppLifecycleStateChanged(AppLifecycleState.detached);
    await Future.delayed(
      const Duration(
        seconds: 1,
      ),
    );
    expect(observerNotifiedCount, 1);

    await widgetsBindingDisposable.dispose();
    widgetsBinding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
    expect(observerNotifiedCount, 1);
  });
}

AutomatedTestWidgetsFlutterBinding _createTestWidgetsBinding() =>
    AutomatedTestWidgetsFlutterBinding();

class LifecycleEventHandler extends WidgetsBindingObserver {
  final Function(AppLifecycleState appLifecycleState) callback;

  LifecycleEventHandler(this.callback);

  @override
  Future didChangeAppLifecycleState(AppLifecycleState state) async {
    callback(state);
  }
}
