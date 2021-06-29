import 'package:easy_dispose/easy_dispose.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

///  [Provider] for [IDisposable] with implemented dispose() method
class DisposableProvider<T extends IDisposable> extends Provider<T> {
  /// Same constructor as [Provider]
  /// But dispose already implemented
  DisposableProvider({
    required Create<T> create,
    Key? key,
    bool? lazy,
    TransitionBuilder? builder,
    Widget? child,
  }) : super(
          key: key,
          create: create,
          lazy: lazy,
          child: child,
          builder: builder,
          dispose: (_, disposable) => disposable.dispose(),
        );
}
