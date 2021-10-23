import 'package:easy_dispose/easy_dispose.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

///  [ProxyProvider5] for [IDisposable] with implemented dispose() method
class DisposableProxyProvider5<T, T2, T3, T4, T5, D extends IDisposable>
    extends ProxyProvider5<T, T2, T3, T4, T5, D> {
  /// Same constructor as [ProxyProvider]
  /// But dispose already implemented
  DisposableProxyProvider5({
    required ProxyProviderBuilder5<T, T2, T3, T4, T5, D> update,
    Key? key,
    Create<D>? create,
    UpdateShouldNotify<D>? updateShouldNotify,
    bool? lazy,
    Widget? child,
  }) : super(
          key: key,
          create: create,
          update: update,
          updateShouldNotify: updateShouldNotify,
          lazy: lazy,
          child: child,
          dispose: (_, disposable) => disposable.dispose(),
        );
}
