import 'dart:async';

import 'package:easy_dispose/easy_dispose.dart';
import 'package:rxdart/rxdart.dart';

/// Disposable implementation for [Subject]
class SubjectDisposable extends Disposable {
  /// [Subject] to dispose
  final Subject subject;

  /// Default constructor
  SubjectDisposable(
    this.subject,
  );

  @override
  Future<void> performDispose() async {
    // see subject.close() docs why it is not awaited
    // ignore: unawaited_futures, avoid-ignoring-return-values
    subject.close();
  }
}

/// add [disposeWith] to [Subject]
extension SubjectDisposableExtension on Subject {
  /// shortcut to add [SubjectDisposable] to [ICompositeDisposable]
  void disposeWith(ICompositeDisposable compositeDisposable) {
    compositeDisposable.addDisposable(
      SubjectDisposable(
        this,
      ),
    );
  }
}
