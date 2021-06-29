import 'dart:async';

/// Base disposable interface
abstract class IDisposable {
  /// is [dispose] was already called
  bool get isDisposed;

  /// free resources. Do nothing if [isDisposed] already true
  Future dispose();
}

/// Base disposable implementation with [isDisposed] check
/// before [performDispose] call
abstract class Disposable implements IDisposable {
  @override
  bool isDisposed = false;

  @override
  Future dispose() async {
    if (!isDisposed) {
      await performDispose();
      isDisposed = true;
    }
  }

  /// actually dispose resources called in dispose() after isDisposed check
  Future performDispose();
}
