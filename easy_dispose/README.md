[![Pub](https://img.shields.io/pub/v/easy_dispose.svg)](https://pub.dev/packages/easy_dispose)

Dart and Flutter classes have different methods to dispose and clean up.
Like cancel, stop, removeListener, etc.
This package define `IDisposable` interface and special implementations for different types, like `StreamControllerDisposable`
You can use `CompositeDisposable` & `DisposableOwner` to group different `IDisposable`
Additionally `disposeWith` extensions makes using disposables easier.

## Supported types

* StreamController
* StreamSubscription
* Timer
* CustomDisposable(execute function on dispose)

## CompositeDisposable & DisposableOwner

Dispose several disposables in one time in LIFO/FIFO order or in parallel

## Example

```
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
```