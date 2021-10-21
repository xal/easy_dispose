import 'package:easy_dispose/easy_dispose.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

///  [ProxyProvider3] for [IDisposable] with implemented dispose() method
class DisposableProxyProvider3<T, T2, T3, D extends IDisposable>
    extends ProxyProvider3<T, T2, T3, D> {
  /// Same constructor as [ProxyProvider]
  /// But dispose already implemented
  DisposableProxyProvider3({
    required ProxyProviderBuilder3<T, T2, T3, D> update,
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
