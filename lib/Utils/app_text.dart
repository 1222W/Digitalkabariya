import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final String? fontFamily;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final TextDecoration? textDecoration;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final Function()? onTap;
  final double? letterSpacing;
  final double? wordSpacing;
  final double? height;
  final TextBaseline? textBaseline;
  final bool? softWrap;
  final bool? wrapWords;
  final List<Shadow>? shadows;
  final double? backgroundOpacity;
  final Color? backgroundColor;
  final TextDecoration? backgroundDecoration;

  const AppText({
    Key? key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.fontStyle,
    this.textDecoration,
    this.textAlign,
    this.overflow,
    this.onTap,
    this.maxLines,
    this.letterSpacing,
    this.wordSpacing,
    this.height,
    this.textBaseline,
    this.softWrap,
    this.wrapWords,
    this.shadows,
    this.fontFamily,
    this.backgroundOpacity,
    this.backgroundColor,
    this.backgroundDecoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
          fontFamily: fontFamily,
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontStyle: fontStyle,
          decoration: textDecoration,
          letterSpacing: letterSpacing,
          wordSpacing: wordSpacing,
          height: height,
          textBaseline: textBaseline,
          shadows: shadows,
        ),
        textAlign: textAlign,
        overflow: overflow,
        maxLines: maxLines,
        softWrap: softWrap,
      ),
    );
  }
}
