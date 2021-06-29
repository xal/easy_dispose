library easy_dispose_test;

import 'package:easy_dispose/src/composite_disposable.dart';
import 'package:easy_dispose/src/custom_disposable.dart';
import 'package:test/test.dart';

void main() {
  test('CompositeDisposable isDisposed', () async {
    var compositeDisposable = CompositeDisposable();
    expect(compositeDisposable.isDisposed, isFalse);

    await compositeDisposable.dispose();
    expect(compositeDisposable.isDisposed, isTrue);
  });

  test('CompositeDisposable disposeOrder lifo', () async {
    DateTime? disposable1DisposedTime;
    DateTime? disposable2DisposedTime;
    DateTime? disposable3DisposedTime;

    var disposable1 = CustomDisposable(() async {
      disposable1DisposedTime = DateTime.now();
    });
    var disposable2 = CustomDisposable(() async {
      disposable2DisposedTime = DateTime.now();
    });
    var disposable3 = CustomDisposable(() async {
      disposable3DisposedTime = DateTime.now();
    });

    var compositeDisposable = CompositeDisposable(
      disposeOrder: DisposeOrder.lifo,
    );

    compositeDisposable.addDisposables([
      disposable1,
      disposable2,
    ]);

    compositeDisposable.addDisposable(disposable3);

    await compositeDisposable.dispose();

    expect(disposable1DisposedTime, isNotNull);
    expect(disposable2DisposedTime, isNotNull);
    expect(disposable3DisposedTime, isNotNull);

    // reversed order
    expect(
      disposable3DisposedTime!.microsecondsSinceEpoch <
          disposable2DisposedTime!.microsecondsSinceEpoch,
      isTrue,
    );
    expect(
      disposable2DisposedTime!.microsecondsSinceEpoch <
          disposable1DisposedTime!.microsecondsSinceEpoch,
      isTrue,
    );
  });

  test('CompositeDisposable disposeOrder fifo', () async {
    DateTime? disposable1DisposedTime;
    DateTime? disposable2DisposedTime;
    DateTime? disposable3DisposedTime;

    var disposable1 = CustomDisposable(() async {
      disposable1DisposedTime = DateTime.now();
    });
    var disposable2 = CustomDisposable(() async {
      disposable2DisposedTime = DateTime.now();
    });
    var disposable3 = CustomDisposable(() async {
      disposable3DisposedTime = DateTime.now();
    });

    var compositeDisposable = CompositeDisposable(
      disposeOrder: DisposeOrder.fifo,
    );

    compositeDisposable.addDisposables([
      disposable1,
      disposable2,
    ]);

    compositeDisposable.addDisposable(disposable3);

    await compositeDisposable.dispose();

    expect(disposable1DisposedTime, isNotNull);
    expect(disposable2DisposedTime, isNotNull);
    expect(disposable3DisposedTime, isNotNull);

    expect(
      disposable3DisposedTime!.microsecondsSinceEpoch >
          disposable2DisposedTime!.microsecondsSinceEpoch,
      isTrue,
    );
    expect(
      disposable2DisposedTime!.microsecondsSinceEpoch >
          disposable1DisposedTime!.microsecondsSinceEpoch,
      isTrue,
    );
  });

  test('CompositeDisposable disposeOrder parallel', () async {
    DateTime? disposable1DisposedTime;
    DateTime? disposable2DisposedTime;
    DateTime? disposable3DisposedTime;

    var disposable1 = CustomDisposable(() async {
      disposable1DisposedTime = DateTime.now();
    });
    var disposable2 = CustomDisposable(() async {
      disposable2DisposedTime = DateTime.now();
    });
    var disposable3 = CustomDisposable(() async {
      disposable3DisposedTime = DateTime.now();
    });

    var compositeDisposable = CompositeDisposable(
      disposeOrder: DisposeOrder.parallel,
    );

    compositeDisposable.addDisposables([
      disposable1,
      disposable2,
    ]);

    compositeDisposable.addDisposable(disposable3);

    await compositeDisposable.dispose();

    expect(disposable1DisposedTime, isNotNull);
    expect(disposable2DisposedTime, isNotNull);
    expect(disposable3DisposedTime, isNotNull);
  });

  test('CompositeDisposable disposeOrder fifo catchExceptions false', () async {
    DateTime? disposable1DisposedTime;
    DateTime? disposable2DisposedTime;

    var disposable1 = CustomDisposable(() async {
      throw Exception();
      disposable1DisposedTime = DateTime.now();
    });
    var disposable2 = CustomDisposable(() async {
      disposable2DisposedTime = DateTime.now();
    });

    var compositeDisposable = CompositeDisposable(
      disposeOrder: DisposeOrder.fifo,
      catchExceptions: false,
      disposableExceptionCallback: null,
    );

    compositeDisposable.addDisposables([
      disposable1,
      disposable2,
    ]);

    expect(() async => await compositeDisposable.dispose(), throwsException);

    expect(disposable1DisposedTime, isNull);
    expect(disposable2DisposedTime, isNull);
  });

  test('CompositeDisposable disposeOrder fifo catchExceptions true', () async {
    DateTime? disposable1DisposedTime;
    DateTime? disposable2DisposedTime;

    var disposable1 = CustomDisposable(() async {
      throw Exception();
      disposable1DisposedTime = DateTime.now();
    });
    var disposable2 = CustomDisposable(() async {
      disposable2DisposedTime = DateTime.now();
    });

    var compositeDisposable = CompositeDisposable(
      disposeOrder: DisposeOrder.fifo,
      catchExceptions: true,
    );

    compositeDisposable.addDisposables([
      disposable1,
      disposable2,
    ]);

    await compositeDisposable.dispose();

    expect(disposable1DisposedTime, isNull);
    expect(disposable2DisposedTime, isNotNull);
  });

  test('CompositeDisposable disposeOrder parallel catchExceptions false',
      () async {
    DateTime? disposable1DisposedTime;
    DateTime? disposable2DisposedTime;

    var disposable1 = CustomDisposable(() async {
      throw Exception();
    });
    var disposable2 = CustomDisposable(() async {
      disposable2DisposedTime = DateTime.now();
    });

    var compositeDisposable = CompositeDisposable(
      disposeOrder: DisposeOrder.parallel,
      catchExceptions: false,
      disposableExceptionCallback: null,
    );

    compositeDisposable.addDisposables([
      disposable1,
      disposable2,
    ]);

    expect(() async => await compositeDisposable.dispose(), throwsException);

    expect(disposable1DisposedTime, isNull);
    // disposable2DisposedTime value is undefined maybe null or not null
  });

  test('CompositeDisposable disposeOrder parallel catchExceptions true',
      () async {
    DateTime? disposable1DisposedTime;
    DateTime? disposable2DisposedTime;

    var disposable1 = CustomDisposable(() async {
      throw Exception();
    });
    var disposable2 = CustomDisposable(() async {
      disposable2DisposedTime = DateTime.now();
    });

    var compositeDisposable = CompositeDisposable(
      disposeOrder: DisposeOrder.parallel,
      catchExceptions: true,
    );

    compositeDisposable.addDisposables([
      disposable1,
      disposable2,
    ]);

    await compositeDisposable.dispose();

    expect(disposable1DisposedTime, isNull);
    expect(disposable2DisposedTime, isNotNull);
  });

  test(
      'CompositeDisposable '
      'catchExceptions true disposableExceptionCallback', () async {
    DateTime? disposable1DisposedTime;
    DateTime? disposable2DisposedTime;

    var disposable1 = CustomDisposable(() async {
      throw Exception();
    });
    var disposable2 = CustomDisposable(() async {
      throw Exception();
    });

    var disposableExceptionCallbackCalledCount = 0;

    var compositeDisposable = CompositeDisposable(
      catchExceptions: true,
      disposableExceptionCallback: (_, __, ___) {
        disposableExceptionCallbackCalledCount++;
      },
    );

    compositeDisposable.addDisposables([
      disposable1,
      disposable2,
    ]);

    await compositeDisposable.dispose();

    expect(disposableExceptionCallbackCalledCount, 2);
  });

  test(
      'CompositeDisposable '
      'catchExceptions false disposableExceptionCallback', () async {
    expect(
      () => CompositeDisposable(
        catchExceptions: false,
        disposableExceptionCallback: (_, __, ___) {},
      ),
      throwsArgumentError,
    );
  });
}
