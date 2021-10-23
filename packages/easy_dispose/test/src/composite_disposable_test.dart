// ignore_for_file: cascade_invocations

library easy_dispose_test;

import 'package:easy_dispose/easy_dispose.dart';
import 'package:easy_dispose/src/composite_disposable.dart';
import 'package:easy_dispose/src/custom_disposable.dart';
import 'package:test/test.dart';

// ignore_for_file: avoid-non-null-assertion
void main() {
  test('CompositeDisposable isDisposed', () async {
    final compositeDisposable = CompositeDisposable();
    expect(compositeDisposable.isDisposed, isFalse);

    await compositeDisposable.dispose();
    expect(compositeDisposable.isDisposed, isTrue);
  });

  test('CompositeDisposable disposeOrder lifo', () async {
    DateTime? disposable1DisposedTime;
    DateTime? disposable2DisposedTime;
    DateTime? disposable3DisposedTime;

    final disposable1 = CustomDisposable(() async {
      disposable1DisposedTime = DateTime.now();
    });
    final disposable2 = CustomDisposable(() async {
      disposable2DisposedTime = DateTime.now();
    });
    final disposable3 = CustomDisposable(() async {
      disposable3DisposedTime = DateTime.now();
    });

    final compositeDisposable = CompositeDisposable(
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

    final disposable1 = CustomDisposable(() async {
      disposable1DisposedTime = DateTime.now();
    });
    final disposable2 = CustomDisposable(() async {
      disposable2DisposedTime = DateTime.now();
    });
    final disposable3 = CustomDisposable(() async {
      disposable3DisposedTime = DateTime.now();
    });

    final compositeDisposable = CompositeDisposable(
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

    final disposable1 = CustomDisposable(() async {
      disposable1DisposedTime = DateTime.now();
    });
    final disposable2 = CustomDisposable(() async {
      disposable2DisposedTime = DateTime.now();
    });
    final disposable3 = CustomDisposable(() async {
      disposable3DisposedTime = DateTime.now();
    });

    final compositeDisposable = CompositeDisposable(
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

    final disposable1 = CustomDisposable(() async {
      throw Exception();
    });
    final disposable2 = CustomDisposable(() async {
      disposable2DisposedTime = DateTime.now();
    });

    final compositeDisposable = CompositeDisposable(
      disposeOrder: DisposeOrder.fifo,
      catchExceptions: false,
      disposableExceptionCallback: null,
    );

    compositeDisposable.addDisposables([
      disposable1,
      disposable2,
    ]);

    expect(compositeDisposable.dispose, throwsException);

    expect(disposable1DisposedTime, isNull);
    expect(disposable2DisposedTime, isNull);
  });

  test('CompositeDisposable disposeOrder fifo catchExceptions true', () async {
    DateTime? disposable1DisposedTime;
    DateTime? disposable2DisposedTime;

    final disposable1 = CustomDisposable(() async {
      throw Exception();
    });
    final disposable2 = CustomDisposable(() async {
      disposable2DisposedTime = DateTime.now();
    });

    final compositeDisposable = CompositeDisposable(
      disposeOrder: DisposeOrder.fifo,
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
    'CompositeDisposable disposeOrder parallel catchExceptions false',
    () async {
      DateTime? disposable1DisposedTime;

      final disposable1 = CustomDisposable(() async {
        throw Exception();
      });
      // ignore: no-empty-block
      final disposable2 = CustomDisposable(() async {});

      final compositeDisposable = CompositeDisposable(
        disposeOrder: DisposeOrder.parallel,
        catchExceptions: false,
        disposableExceptionCallback: null,
      )..addDisposables([
          disposable1,
          disposable2,
        ]);

      expect(compositeDisposable.dispose, throwsException);

      expect(disposable1DisposedTime, isNull);
    },
  );

  test(
    'CompositeDisposable disposeOrder parallel catchExceptions true',
    () async {
      DateTime? disposable1DisposedTime;
      DateTime? disposable2DisposedTime;

      final disposable1 = CustomDisposable(() async {
        throw Exception();
      });
      final disposable2 = CustomDisposable(() async {
        disposable2DisposedTime = DateTime.now();
      });

      final compositeDisposable = CompositeDisposable(
        disposeOrder: DisposeOrder.parallel,
        catchExceptions: true,
      )..addDisposables([
          disposable1,
          disposable2,
        ]);

      await compositeDisposable.dispose();

      expect(disposable1DisposedTime, isNull);
      expect(disposable2DisposedTime, isNotNull);
    },
  );

  test(
    'CompositeDisposable '
    'catchExceptions true disposableExceptionCallback',
    () async {
      final disposable1 = CustomDisposable(() async {
        throw Exception();
      });
      final disposable2 = CustomDisposable(() async {
        throw Exception();
      });

      var disposableExceptionCallbackCalledCount = 0;

      final compositeDisposable = CompositeDisposable(
        catchExceptions: true,
        disposableExceptionCallback: (
          IDisposable disposable,
          // ignore: avoid_annotating_with_dynamic
          dynamic error,
          StackTrace stackTrace,
        ) {
          disposableExceptionCallbackCalledCount++;
        },
      );

      compositeDisposable.addDisposables([
        disposable1,
        disposable2,
      ]);

      await compositeDisposable.dispose();

      // ignore: no-magic-number
      expect(disposableExceptionCallbackCalledCount, 2);
    },
  );

  test(
    'CompositeDisposable '
    'catchExceptions false disposableExceptionCallback',
    () async {
      expect(
        () => CompositeDisposable(
          catchExceptions: false,
          // ignore: no-empty-block
          disposableExceptionCallback: (
            IDisposable disposable,
            // ignore: avoid_annotating_with_dynamic
            dynamic error,
            StackTrace stackTrace,
            // ignore: no-empty-block
          ) {},
        ),
        throwsArgumentError,
      );
    },
  );
}
