import 'package:flutter/material.dart';

class RichTextWidget extends StatelessWidget {
  final List<String> texts;
  final List<Color> colors;
  final List<String> fontFamilies;
  final double fontSize;

  const RichTextWidget({
    Key? key,
    required this.texts,
    required this.colors,
    required this.fontFamilies,
    required this.fontSize
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    assert(texts.length == colors.length &&
        texts.length == fontFamilies.length);

    List<TextSpan> textSpans = [];
    for (int i = 0; i < texts.length; i++) {
      textSpans.add(
        TextSpan(
          text: texts[i],
          style: TextStyle(
            color: colors[i],
            fontFamily: fontFamilies[i],
            fontSize: fontSize,
          ),
        ),
      );
    }

    return RichText(
      text: TextSpan(children: textSpans),
    );
  }
}

