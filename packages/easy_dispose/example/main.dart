import 'dart:async';

import 'package:easy_dispose/easy_dispose.dart';

// ignore_for_file: no-empty-block, avoid_print, prefer-match-file-name
Future main() async {
  final myDisposableOwner = MyDisposableOwner();

  // do something

  await myDisposableOwner.dispose();
}

class MyDisposableOwner extends DisposableOwner {
  final StreamController streamController = StreamController<dynamic>();
  final Timer timer = Timer(
    const Duration(seconds: 5),
    () async {},
  );

  MyDisposableOwner()
      : super(
          disposeOrder: DisposeOrder.lifo,
        ) {
    addCustomDisposable(() => print('Final dispose'));
    streamController.disposeWith(this);
    timer.disposeWith(this);

    streamController.stream
        .listen(
          (dynamic event) {},
        )
        .disposeWith(this);
    addCustomDisposable(() => print('First dispose'));
  }
}
