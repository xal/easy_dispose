import 'dart:async';

import 'package:easy_dispose/easy_dispose.dart';
// ignore_for_file: no-empty-block
void main() {
  var myDisposableOwner = MyDisposableOwner();

  // do something

  myDisposableOwner.dispose();
}

class MyDisposableOwner extends DisposableOwner {
  final StreamController streamController = StreamController();
  final Timer timer = Timer(
    Duration(seconds: 5),
    () async {},
  );

  MyDisposableOwner(): super(
    disposeOrder: DisposeOrder.lifo,
  ) {
    addCustomDisposable(() => print('Final dispose'));
    streamController.disposeWith(this);
    timer.disposeWith(this);

    streamController.stream
        .listen(
          (_) {},
        )
        .disposeWith(this);
    addCustomDisposable(() => print('First dispose'));
  }
}
