import 'dart:async';

import 'package:easy_dispose/easy_dispose.dart';
import 'package:rxdart/rxdart.dart';

// ignore_for_file: no-empty-block, avoid_print, prefer-match-file-name
// ignore_for_file: prefer-match-file-name
Future main() async {
  final myDisposableOwner = MyDisposableOwner();

  // do something

  await myDisposableOwner.dispose();
}

class MyDisposableOwner extends DisposableOwner {
  final Subject subject = BehaviorSubject<dynamic>();

  MyDisposableOwner()
      : super(
          disposeOrder: DisposeOrder.lifo,
        ) {
    addCustomDisposable(() => print('Final dispose'));
    subject.disposeWith(this);

    subject.stream
        .listen(
          (dynamic event) {},
        )
        .disposeWith(this);
    addCustomDisposable(() => print('First dispose'));
  }
}
