library easy_dispose_rxdart_test;

// ignore_for_file: avoid-ignoring-return-values
import 'package:easy_dispose_rxdart/src/subject_disposable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:test/test.dart';

void main() {
  test('SubjectDisposable isDisposed', () async {
    final subjectDisposable = SubjectDisposable(
      _createTestSubject(),
    );
    expect(subjectDisposable.isDisposed, isFalse);

    await subjectDisposable.dispose();
    expect(subjectDisposable.isDisposed, isTrue);
  });

  test('SubjectDisposable disposeCallback', () async {
    // ignore: close_sinks
    final subject = _createTestSubject();
    final subjectDisposable = SubjectDisposable(subject);

    expect(subject.isClosed, isFalse);
    await subjectDisposable.dispose();
    expect(subject.isClosed, isTrue);
  });
}

Subject _createTestSubject() => BehaviorSubject<dynamic>();
