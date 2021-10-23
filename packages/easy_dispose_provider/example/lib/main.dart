import 'dart:async';

import 'package:easy_dispose/easy_dispose.dart';
import 'package:easy_dispose_provider/easy_dispose_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

// ignore_for_file: no-empty-block, avoid_print
Future main() async {
  runApp(
    MaterialApp(
      home: DisposableProvider<_ParentDisposable>(
        create: (_) => _ParentDisposable(),
        child: DisposableProxyProvider<_ParentDisposable, _ChildDisposable>(
          update: (_, parentDisposable, __) => _ChildDisposable(
            parentDisposable,
          ),
          child: const _HomeWidget(),
        ),
      ),
    ),
  );
}

class _HomeWidget extends StatelessWidget {
  const _HomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final parentDisposable = Provider.of<_ParentDisposable>(context);
    final childDisposable = Provider.of<_ChildDisposable>(context);
    return Scaffold(
      body: Text(
        'Hello world \n${'$parentDisposable \n\n'}${'$childDisposable \n\n'}',
      ),
    );
  }
}

class _ParentDisposable extends CustomDisposable {
  _ParentDisposable()
      : super(
          () => print(
            '_ParentDisposable',
          ),
        );
}

class _ChildDisposable extends CustomDisposable {
  final _ParentDisposable parentDisposable;

  _ChildDisposable(this.parentDisposable)
      : super(
          () => print(
            '_ChildDisposable',
          ),
        );
}
