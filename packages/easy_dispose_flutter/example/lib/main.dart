import 'dart:async';

import 'package:easy_dispose/easy_dispose.dart';
import 'package:easy_dispose_flutter/easy_dispose_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ignore_for_file: no-empty-block, avoid_print, public_member_api_docs
Future main() async {
  runApp(
    const MaterialApp(
      home: HomeWidget(),
    ),
  );
}

class HomeWidget extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _HomeWidgetState createState() => _HomeWidgetState();

  const HomeWidget({
    Key? key,
  }) : super(key: key);
}

class _HomeWidgetState extends State<HomeWidget> with TickerProviderStateMixin {
  late MyDisposableOwner? _myDisposableOwner;

  @override
  void initState() {
    super.initState();
    _myDisposableOwner = MyDisposableOwner(tickerProvider: this);
  }

  @override
  void dispose() {
    super.dispose();
    _myDisposableOwner?.dispose();
  }

  @override
  Widget build(BuildContext context) => const Text('Hello world');
}

class MyDisposableOwner extends DisposableOwner {
  final TextEditingController textEditingController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final FocusNode focusNode = FocusNode();
  final TabController tabController;

  MyDisposableOwner({
    required TickerProvider tickerProvider,
  })  : tabController = TabController(
          length: 1,
          vsync: tickerProvider,
        ),
        super(
          disposeOrder: DisposeOrder.lifo,
        ) {
    addCustomDisposable(() => print('Final dispose'));

    textEditingController.disposeWith(this);
    scrollController.disposeWith(this);
    focusNode.disposeWith(this);
    tabController.disposeWith(this);

    textEditingController.listenAsDisposable(() {
      // textEditingController changed
    }).disposeWith(this);
    scrollController.listenAsDisposable(() {
      // scrollController changed
    }).disposeWith(this);
    focusNode.listenAsDisposable(() {
      // focusNode changed
    }).disposeWith(this);
    tabController.listenAsDisposable(() {
      // tabController changed
    }).disposeWith(this);

    WidgetsBinding.instance!.observeAsDisposable(
      LifecycleEventHandler(
        (appLifecycleState) {
          // appLifecycleState changed
        },
      ),
    );

    addCustomDisposable(() => print('First dispose'));
  }
}

class LifecycleEventHandler extends WidgetsBindingObserver {
  final Function(AppLifecycleState appLifecycleState) callback;

  LifecycleEventHandler(this.callback);

  @override
  Future didChangeAppLifecycleState(AppLifecycleState state) async {
    callback(state);
  }
}
