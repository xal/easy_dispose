[![Pub](https://img.shields.io/pub/v/easy_dispose.svg)](https://pub.dev/packages/easy_dispose)

Dart and Flutter classes have different methods to dispose and clean up.
Like cancel, stop, removeListener, etc.
This package define `IDisposable` interface and special implementations for different types, like `StreamControllerDisposable`
You can use `CompositeDisposable` & `DisposableOwner` to group different `IDisposable`
Additionally `disposeWith` extensions makes using disposables easier.

You can also use easy_dispose_* extensions:

* [`easy_dispose_flutter`](https://pub.dev/packages/easy_dispose_flutter)
* [`easy_dispose_provider`](https://pub.dev/packages/easy_dispose_provider)
* [`easy_dispose_rxdart`](https://pub.dev/packages/easy_dispose_rxdart)