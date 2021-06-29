library easy_dispose_flutter_test;

import 'package:easy_dispose_flutter/easy_dispose_flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ChangeNotifierListenerDisposable', () async {
    String? changedValue;

    final textEditingController = _createTestTextEditingController();
    final textEditingControllerDisposable = ChangeNotifierListenerDisposable(
      textEditingController,
      () {
        changedValue = textEditingController.text;
      },
    );

    expect(changedValue, isNull);
    textEditingController.text = 'test1';
    expect(changedValue, 'test1');

    await textEditingControllerDisposable.dispose();

    textEditingController.text = 'test2';
    expect(changedValue, 'test1');

    textEditingController.dispose();
  });
}

TextEditingController _createTestTextEditingController() =>
    TextEditingController();
