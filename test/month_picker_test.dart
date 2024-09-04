import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mp_month_picker/mp_month_picker.dart';

void main() {
  testWidgets('MonthPicker displays and selects the correct month and year',
      (WidgetTester tester) async {
    final initialDate = DateTime(2024, 8);
    final firstDate = DateTime(2000);
    final lastDate = DateTime(2100);

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: MpMonthPicker(
          initialDate: initialDate,
          firstDate: firstDate,
          lastDate: lastDate,
          onMonthChanged: (DateTime? value) {},
        ),
      ),
    ));
  });
}
