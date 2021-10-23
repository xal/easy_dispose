[![Pub](https://img.shields.io/pub/v/easy_dispose_rxdart.svg)](https://pub.dev/packages/easy_dispose_rxdart)

[![Unit tests](https://github.com/xal/easy_dispose/actions/workflows/unit_tests_with_coverage.yml/badge.svg)](https://github.com/xal/easy_dispose/actions/workflows/unit_tests_with_coverage.yml/)
[![Lints](https://github.com/xal/easy_dispose/actions/workflows/lints.yml/badge.svg)](https://github.com/xal/easy_dispose/actions/workflows/lints.yml.yml/)
[![dartfmt](https://github.com/xal/easy_dispose/actions/workflows/code_formatting.yml/badge.svg)](https://github.com/xal/easy_dispose/actions/workflows/code_formatting.yml/)

[![codecov](https://codecov.io/gh/xal/easy_dispose/branch/master/graph/badge.svg?token=2IN0I5DT4C)](https://codecov.io/gh/xal/easy_dispose)

Add disposable feature to `rxdart` classes.
Read [`easy_dispose`](https://pub.dev/packages/easy_dispose) documentation for details.

You can find all available extensions in [`easy_dispose`](https://github.com/xal/easy_dispose) repository. 

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