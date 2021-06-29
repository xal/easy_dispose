import 'composite_disposable.dart';

/// just title alias for [CompositeDisposable] for backward compatibility
class DisposableOwner extends CompositeDisposable {
  /// Default constructor
  /// [disposeOrder] = [DisposeOrder.lifo],
  /// [catchExceptions} = true,
  /// [disposableExceptionCallback] = [printDisposableErrorToConsole],
  DisposableOwner({
    DisposeOrder disposeOrder = DisposeOrder.lifo,
    bool catchExceptions = true,
    DisposableExceptionCallback? disposableExceptionCallback =
        printDisposableErrorToConsole,
  }) : super(
          disposeOrder: disposeOrder,
          catchExceptions: catchExceptions,
          disposableExceptionCallback: disposableExceptionCallback,
        );
}
