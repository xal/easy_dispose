[![Pub](https://img.shields.io/pub/v/easy_dispose_rxdart.svg)](https://pub.dev/packages/easy_dispose_rxdart)

 
Add disposable feature to `rxdart` classes.
Read [`easy_dispose`](https://pub.dev/packages/easy_dispose) documentation for details.

## Supported features

* SubjectDisposable

## Example

```
import 'dart:async';

import 'package:easy_dispose/easy_dispose.dart';
import 'package:rxdart/rxdart.dart';

// ignore_for_file: no-empty-block, avoid_print
Future main() async {
  final myDisposableOwner = MyDisposableOwner();

  // do something

  await myDisposableOwner.dispose();
}

class MyDisposableOwner extends DisposableOwner {
  final Subject subject = BehaviorSubject();

  MyDisposableOwner()
      : super(
          disposeOrder: DisposeOrder.lifo,
        ) {
    addCustomDisposable(() => print('Final dispose'));
    subject.disposeWith(this);

    subject.stream
        .listen(
          (_) {},
        )
        .disposeWith(this);
    addCustomDisposable(() => print('First dispose'));
  }
}


```