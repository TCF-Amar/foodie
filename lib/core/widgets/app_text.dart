import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow overflow;
  final TextDecoration decoration;
  final Color? decorationColor;
  final TextDecorationStyle? decorationStyle;
  final double? decorationThickness;
  final double? letterSpacing;
  final double? wordSpacing;
  final double? height;
  final FontStyle fontStyle;
  final String? fontFamily;
  final List<String>? fontFamilyFallback;
  final List<Shadow>? shadows;
  final Color? backgroundColor;
  final Paint? foreground;
  final bool softWrap;
  final TextDirection? textDirection;
  final String? semanticsLabel;
  final TextBaseline? textBaseline;
  final bool? inherit;

  // which TextTheme slot to pull from
  final _AppTextVariant _variant;

  const AppText(
    this.text, {
    super.key,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow = TextOverflow.ellipsis,
    this.decoration = TextDecoration.none,
    this.decorationColor,
    this.decorationStyle,
    this.decorationThickness,
    this.letterSpacing,
    this.wordSpacing,
    this.height,
    this.fontStyle = FontStyle.normal,
    this.fontFamily,
    this.fontFamilyFallback,
    this.shadows,
    this.backgroundColor,
    this.foreground,
    this.softWrap = true,
    this.textDirection,
    this.semanticsLabel,
    this.textBaseline,
    this.inherit,
  }) : _variant = _AppTextVariant.body;

  /// bodySmall — 12px | normal | textHint
  const AppText.small(
    this.text, {
    super.key,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow = TextOverflow.ellipsis,
    this.decoration = TextDecoration.none,
    this.decorationColor,
    this.decorationStyle,
    this.decorationThickness,
    this.letterSpacing,
    this.wordSpacing,
    this.height,
    this.fontStyle = FontStyle.normal,
    this.fontFamily,
    this.fontFamilyFallback,
    this.shadows,
    this.backgroundColor,
    this.foreground,
    this.softWrap = true,
    this.textDirection,
    this.semanticsLabel,
    this.textBaseline,
    this.inherit,
  }) : _variant = _AppTextVariant.small;

  /// bodyMedium — 14px | w500 | textSecondary
  const AppText.medium(
    this.text, {
    super.key,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow = TextOverflow.ellipsis,
    this.decoration = TextDecoration.none,
    this.decorationColor,
    this.decorationStyle,
    this.decorationThickness,
    this.letterSpacing,
    this.wordSpacing,
    this.height,
    this.fontStyle = FontStyle.normal,
    this.fontFamily,
    this.fontFamilyFallback,
    this.shadows,
    this.backgroundColor,
    this.foreground,
    this.softWrap = true,
    this.textDirection,
    this.semanticsLabel,
    this.textBaseline,
    this.inherit,
  }) : _variant = _AppTextVariant.medium;

  /// titleMedium — 18px | w600 | textPrimary
  const AppText.large(
    this.text, {
    super.key,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow = TextOverflow.ellipsis,
    this.decoration = TextDecoration.none,
    this.decorationColor,
    this.decorationStyle,
    this.decorationThickness,
    this.letterSpacing,
    this.wordSpacing,
    this.height,
    this.fontStyle = FontStyle.normal,
    this.fontFamily,
    this.fontFamilyFallback,
    this.shadows,
    this.backgroundColor,
    this.foreground,
    this.softWrap = true,
    this.textDirection,
    this.semanticsLabel,
    this.textBaseline,
    this.inherit,
  }) : _variant = _AppTextVariant.large;

  /// headlineSmall — 24px | bold | textPrimary
  const AppText.extraLarge(
    this.text, {
    super.key,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow = TextOverflow.ellipsis,
    this.decoration = TextDecoration.none,
    this.decorationColor,
    this.decorationStyle,
    this.decorationThickness,
    this.letterSpacing,
    this.wordSpacing,
    this.height,
    this.fontStyle = FontStyle.normal,
    this.fontFamily,
    this.fontFamilyFallback,
    this.shadows,
    this.backgroundColor,
    this.foreground,
    this.softWrap = true,
    this.textDirection,
    this.semanticsLabel,
    this.textBaseline,
    this.inherit,
  }) : _variant = _AppTextVariant.extraLarge;

  /// Pass any TextTheme style directly — full manual control
  const AppText.custom(
    this.text, {
    super.key,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow = TextOverflow.ellipsis,
    this.decoration = TextDecoration.none,
    this.decorationColor,
    this.decorationStyle,
    this.decorationThickness,
    this.letterSpacing,
    this.wordSpacing,
    this.height,
    this.fontStyle = FontStyle.normal,
    this.fontFamily,
    this.fontFamilyFallback,
    this.shadows,
    this.backgroundColor,
    this.foreground,
    this.softWrap = true,
    this.textDirection,
    this.semanticsLabel,
    this.textBaseline,
    this.inherit,
  }) : _variant = _AppTextVariant.custom;

  // ── Resolve base style from theme ──────────────────────────────
  TextStyle _baseStyle(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    switch (_variant) {
      case _AppTextVariant.small:
        return tt.bodySmall!;
      case _AppTextVariant.medium:
        return tt.bodyMedium!;
      case _AppTextVariant.large:
        return tt.titleMedium!;
      case _AppTextVariant.extraLarge:
        return tt.headlineSmall!;
      case _AppTextVariant.body:
        return tt.bodyLarge!;
      case _AppTextVariant.custom:
        return const TextStyle();
    }
  }

  @override
  Widget build(BuildContext context) {
    final base = _baseStyle(context);

    // Override only the properties explicitly passed by the caller
    final resolved = base.copyWith(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: foreground != null ? null : color,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      height: height,
      fontStyle: fontStyle,
      fontFamily: fontFamily,
      fontFamilyFallback: fontFamilyFallback,
      shadows: shadows,
      backgroundColor: backgroundColor,
      foreground: foreground,
      textBaseline: textBaseline,
      inherit: inherit,
    );

    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textDirection: textDirection,
      semanticsLabel: semanticsLabel,
      style: resolved,
    );
  }
}

enum _AppTextVariant { body, small, medium, large, extraLarge, custom }
