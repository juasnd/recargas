import 'package:flutter/services.dart';

class PhoneNumberFormatter extends TextInputFormatter {
  const PhoneNumberFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final limitedDigits = digits.length > 10 ? digits.substring(0, 10) : digits;
    final formatted = StringBuffer();

    for (var index = 0; index < limitedDigits.length; index++) {
      if (index == 3 || index == 6) formatted.write(' ');
      formatted.write(limitedDigits[index]);
    }

    return TextEditingValue(
      text: formatted.toString(),
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
