import 'dart:async';

// ignore_for_file: prefer-match-file-name
/// Base disposable interface
abstract class IDisposable {
  /// is [dispose] was already called
  bool get isDisposed;

  /// free resources. Do nothing if [isDisposed] already true
  Future<void> dispose();
}

/// Base disposable implementation with [isDisposed] check
/// before [performDispose] call
abstract class Disposable extends IDisposable with DisposableMixin {}

/// Mixin with [isDisposed] check before [performDispose] call
mixin DisposableMixin on IDisposable {
  @override
  bool isDisposed = false;

  @override
  Future<void> dispose() async {
    if (!isDisposed) {
      await performDispose();
      isDisposed = true;
    }
  }

  /// actually dispose resources called in dispose() after isDisposed check
  Future<void> performDispose();
}
