import 'package:easy_dispose/easy_dispose.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

///  [ProxyProvider4] for [IDisposable] with implemented dispose() method
class DisposableProxyProvider4<T, T2, T3, T4, D extends IDisposable>
    extends ProxyProvider4<T, T2, T3, T4, D> {
  /// Same constructor as [ProxyProvider]
  /// But dispose already implemented
  DisposableProxyProvider4({
    required ProxyProviderBuilder4<T, T2, T3, T4, D> update,
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
