import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class WidgetUtil {
  static Widget createRichText({
    required String value,
    required List<String> boldStrings,
    List<VoidCallback>? boldStringsCallback,
    TextStyle? normalTextStyle,
    TextStyle? boldTextStyle,
    TextAlign? textAlign,
  }) {
    var str = value;
    List<InlineSpan> richText = [];
    for (var i = 0; i < boldStrings.length; i++) {
      final splitArray = str.split(boldStrings[i]);
      richText.add(TextSpan(text: splitArray.first));
      richText.add(TextSpan(
          recognizer: TapGestureRecognizer()..onTap = boldStringsCallback?[i],
          text: boldStrings[i],
          style: boldTextStyle));

      if (i + 1 >= boldStrings.length) {
        richText.add(TextSpan(text: splitArray.last));
      }

      str = splitArray.last;
    }
    if (richText.isEmpty) {
      richText.add(TextSpan(text: value));
    }
    return RichText(
      textAlign: textAlign ?? TextAlign.center,
      text: TextSpan(
        style: normalTextStyle,
        children: richText.toList(),
      ),
    );
  }
}
