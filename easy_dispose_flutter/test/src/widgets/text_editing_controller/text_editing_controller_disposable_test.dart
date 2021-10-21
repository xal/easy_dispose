library easy_dispose_flutter_test;

// ignore_for_file: avoid-ignoring-return-values
import 'package:easy_dispose_flutter/src/widgets/text_editing_controller/text_editing_controller_disposable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart' as matcher;

void main() {
  test('TextEditingControllerDisposable isDisposed', () async {
    final textEditingControllerDisposable = TextEditingControllerDisposable(
      _createTestTextEditingController(),
    );
    expect(textEditingControllerDisposable.isDisposed, isFalse);

    await textEditingControllerDisposable.dispose();
    expect(textEditingControllerDisposable.isDisposed, isTrue);
  });

  test('TextEditingControllerDisposable disposeCallback', () async {
    final textEditingController = _createTestTextEditingController();
    final textEditingControllerDisposable =
        TextEditingControllerDisposable(textEditingController);

    // not throws exception
    textEditingController.notifyListeners();

    await textEditingControllerDisposable.dispose();
    expect(
      textEditingController.notifyListeners,
      throwsA(
        // ignore:
        const matcher.TypeMatcher<FlutterError>(),
      ),
    );
  });
}

TextEditingController _createTestTextEditingController() =>
    TextEditingController();
