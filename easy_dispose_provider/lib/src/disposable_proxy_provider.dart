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

///  [ProxyProvider4] for [IDisposable] with implemented dispose() method
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
