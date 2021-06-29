import 'composite_disposable.dart';
import 'disposable.dart';

/// Define function for [CustomDisposable.disposeCallback]
typedef DisposeCallback = Function();

/// Executes [disposeCallback] when [IDisposable.dispose] called
class CustomDisposable extends Disposable {
  /// Callback called when [IDisposable.dispose] executes
  final DisposeCallback disposeCallback;

  /// Default constructor
  CustomDisposable(this.disposeCallback);

  @override
  Future performDispose() async {
    await disposeCallback();
  }
}

/// [addCustomDisposable] method for [ICompositeDisposable]
extension CustomDisposableExtension on ICompositeDisposable {

  /// shortcut to add [DisposeCallback]
  void addCustomDisposable(DisposeCallback disposeCallback) {
    addDisposable(
      CustomDisposable(
        disposeCallback,
      ),
    );
  }
}
