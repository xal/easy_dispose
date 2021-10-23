import 'package:easy_dispose/easy_dispose.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

///  [ProxyProvider] for [IDisposable] with implemented dispose() method
class DisposableProxyProvider<T, D extends IDisposable>
    extends ProxyProvider<T, D> {
  /// Same constructor as [ProxyProvider]
  /// But dispose already implemented
  DisposableProxyProvider({
    required ProxyProviderBuilder<T, D> update,
    Key? key,
    Create<D>? create,
    UpdateShouldNotify<D>? updateShouldNotify,
    TransitionBuilder? builder,
    bool? lazy,
    Widget? child,
  }) : super(
          key: key,
          create: create,
          update: update,
          builder: builder,
          updateShouldNotify: updateShouldNotify,
          lazy: lazy,
          child: child,
          dispose: (_, disposable) => disposable.dispose(),
        );
}
