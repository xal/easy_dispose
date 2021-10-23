import 'dart:async';

import 'disposable.dart';

// ignore_for_file: prefer-match-file-name
/// Dispose several disposables
abstract class ICompositeDisposable implements IDisposable {
  /// Unmodifiable List of disposables to dispose
  List<IDisposable> get disposables;

  /// Dispose Order: LIFO(preferable), FIFO, Parallel
  DisposeOrder get disposeOrder;

  /// is need to try/catch each item dispose() call
  bool get catchExceptions;

  /// callback which executes on error catch during dispose
  /// [catchExceptions] should be enabled
  DisposableExceptionCallback? get disposableExceptionCallback;

  /// add single disposables
  /// see also [addDisposables]
  void addDisposable(IDisposable disposable);

  /// add several disposables
  /// see also [addDisposable]
  void addDisposables(Iterable<IDisposable> disposables);
}

/// [ICompositeDisposable] disposables dispose order
enum DisposeOrder {
  /// last input first output
  /// (preferable)
  lifo,

  /// first input first output
  fifo,

  /// dispose all in parallel
  parallel,
}

/// Additional logic to [ICompositeDisposable] interface
extension ICompositeDisposableExtension on ICompositeDisposable {
  /// is [disposableExceptionCallback] exist
  bool get isHaveDisposableExceptionCallback =>
      disposableExceptionCallback != null;
}

/// Function defined for [ICompositeDisposable.disposableExceptionCallback]
typedef DisposableExceptionCallback = FutureOr<void> Function(
  IDisposable disposable,
  // ignore: avoid_annotating_with_dynamic
  dynamic error,
  StackTrace stackTrace,
);

/// default implementation
/// for [ICompositeDisposable.disposableExceptionCallback]
void printDisposableErrorToConsole(
  IDisposable disposable,
  // ignore: avoid_annotating_with_dynamic
  dynamic error,
  StackTrace? stackTrace,
) {
  // ignore_for_file: avoid_print
  print('Error during dispose. $disposable');
  if (error != null) {
    print('\n$error');
  }
  if (stackTrace != null) {
    print('\n$stackTrace');
  }
}

/// Default implementation for [ICompositeDisposable]
class CompositeDisposable extends Disposable implements ICompositeDisposable {
  @override
  final DisposeOrder disposeOrder;

  @override
  final bool catchExceptions;
  @override
  final DisposableExceptionCallback? disposableExceptionCallback;

  final List<IDisposable> _disposables = [];

  @override
  List<IDisposable> get disposables => List.unmodifiable(_disposables);

  /// Default constructor
  /// [disposeOrder] = [DisposeOrder.lifo],
  /// [catchExceptions} = true,
  /// [disposableExceptionCallback] = [printDisposableErrorToConsole],
  CompositeDisposable({
    this.disposeOrder = DisposeOrder.lifo,
    this.catchExceptions = true,
    this.disposableExceptionCallback = printDisposableErrorToConsole,
  }) {
    if (disposableExceptionCallback != null && !catchExceptions) {
      throw ArgumentError(
        'catchExceptions should be true '
        'if disposableExceptionCallback is not null',
      );
    }
  }

  @override
  void addDisposable(IDisposable disposable) => _disposables.add(
        disposable,
      );

  @override
  void addDisposables(Iterable<IDisposable> disposables) => _disposables.addAll(
        disposables,
      );

  @override
  Future<void> performDispose() async {
    final sortedDisposables = _calculateSortedDisposables();

    if (disposeOrder == DisposeOrder.parallel) {
      final futures = sortedDisposables.map(
        _dispose,
      );

      // ignore: avoid-ignoring-return-values
      await Future.wait(futures);
    } else {
      for (final disposable in sortedDisposables) {
        await _dispose(disposable);
      }
    }
  }

  Future<void> _dispose(IDisposable disposable) async {
    if (catchExceptions) {
      try {
        await disposable.dispose();
        // catch all errors
        // ignore: avoid_catches_without_on_clauses
      } catch (e, stackTrace) {
        final callback = disposableExceptionCallback;
        if (callback != null) {
          callback(disposable, e, stackTrace);
        }
      }
    } else {
      await disposable.dispose();
    }
  }

  Iterable<IDisposable> _calculateSortedDisposables() {
    Iterable<IDisposable> sortedDisposables;

    switch (disposeOrder) {
      case DisposeOrder.lifo:
        sortedDisposables = _disposables.reversed;
        break;
      case DisposeOrder.fifo:
      case DisposeOrder.parallel:
        sortedDisposables = _disposables;
        break;
    }

    return sortedDisposables;
  }
}

/// add [disposeWith] to [ICompositeDisposable]
extension CompositeDisposableExtension on IDisposable {
  /// shortcut to add [ICompositeDisposable] to [ICompositeDisposable]
  void disposeWith(ICompositeDisposable compositeDisposable) {
    compositeDisposable.addDisposable(
      this,
    );
  }
}
