import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum _SvgType { asset, network }

class AppSvg extends StatelessWidget {
  const AppSvg.asset(
    this.path, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.color,
    this.placeholder,
    this.errorWidget,
  }) : _type = _SvgType.asset;

  const AppSvg.network(
    this.path, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.color,
    this.placeholder,
    this.errorWidget,
  }) : _type = _SvgType.network;

  final String path;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Color? color;
  static const double _defaultSize = 24.0;
  final Widget? placeholder;
  final Widget? errorWidget;
  final _SvgType _type;

  Widget get _fallbackPlaceholder => SizedBox(
    width: width ?? _defaultSize,
    height: height ?? _defaultSize,
    child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
  );

  Widget get _fallbackError => SizedBox(
    width: width ?? _defaultSize,
    height: height ?? _defaultSize,
    child: const Center(
      child: Icon(Icons.broken_image_outlined, color: Colors.grey),
    ),
  );

  ColorFilter? get _colorFilter =>
      color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null;

  @override
  Widget build(BuildContext context) {
    return switch (_type) {
      _SvgType.asset => SvgPicture.asset(
        path,
        width: width ?? _defaultSize,
        height: height ?? _defaultSize,
        fit: fit,
        colorFilter: _colorFilter,
        placeholderBuilder: (_) => placeholder ?? _fallbackPlaceholder,
      ),
      _SvgType.network => SvgPicture.network(
        path,
        width: width ?? _defaultSize,
        height: height ?? _defaultSize,
        fit: fit,
        colorFilter: _colorFilter,
        placeholderBuilder: (_) => placeholder ?? _fallbackPlaceholder,
        // network SVG uses headers if needed — extend via copyWith pattern
      ),
    };
  }
}
