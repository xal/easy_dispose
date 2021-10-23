[![Pub](https://img.shields.io/pub/v/easy_dispose.svg)](https://pub.dev/packages/easy_dispose)
[![codecov](https://codecov.io/gh/xal/easy_dispose/branch/master/graph/badge.svg?token=2IN0I5DT4C)](https://codecov.io/gh/xal/easy_dispose)

| Package               | Pub | Details |
|-----------------------|-----|---------|
| `easy_dispose`          | [![Pub](https://img.shields.io/pub/v/easy_dispose.svg)](https://pub.dev/packages/easy_dispose) | Base implementation for dart |
| `easy_dispose_flutter`  | [![Pub](https://img.shields.io/pub/v/easy_dispose_flutter.svg)](https://pub.dev/packages/easy_dispose_flutter) | Base implementation for flutter |
| `easy_dispose_provider` | [![Pub](https://img.shields.io/pub/v/easy_dispose_provider.svg)](https://pub.dev/packages/easy_dispose_provider) | Classes for provider library |
| `easy_dispose_rxdart`   | [![Pub](https://img.shields.io/pub/v/easy_dispose_rxdart.svg)](https://pub.dev/packages/easy_dispose_rxdart) | Classes for rxdart library |

Dart and Flutter classes have different methods to dispose and clean up.
Like cancel, stop, removeListener, etc.
This package define `IDisposable` interface and special implementations for different types, like `StreamControllerDisposable`
You can use `CompositeDisposable` & `DisposableOwner` to group different `IDisposable`
Additionally `disposeWith` extensions makes using disposables easier.