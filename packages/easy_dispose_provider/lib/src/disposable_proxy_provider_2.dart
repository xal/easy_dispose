import 'package:easy_dispose/easy_dispose.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

///  [ProxyProvider2] for [IDisposable] with implemented dispose() method
class DisposableProxyProvider2<T, T2, D extends IDisposable>
    extends ProxyProvider2<T, T2, D> {
  /// Same constructor as [ProxyProvider]
  /// But dispose already implemented
  DisposableProxyProvider2({
    required ProxyProviderBuilder2<T, T2, D> update,
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
