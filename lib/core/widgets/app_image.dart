import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

enum _ImageType { asset, network }

class AppImage extends StatelessWidget {
  const AppImage.asset(
    this.path, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.placeholder,
    this.errorWidget,
    this.color,
    this.colorBlendMode,
  }) : _type = _ImageType.asset;

  const AppImage.network(
    this.path, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.placeholder,
    this.errorWidget,
    this.color,
    this.colorBlendMode,
  }) : _type = _ImageType.network;

  final String path;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Widget? placeholder;
  final Widget? errorWidget;
  final Color? color;
  final BlendMode? colorBlendMode;
  final _ImageType _type;

  Widget get _defaultPlaceholder => Container(
    width: width,
    height: height,
    color: Colors.grey.shade100,
    child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
  );

  Widget get _defaultError => Container(
    width: width,
    height: height,
    color: Colors.grey.shade100,
    child: const Center(
      child: Icon(Icons.broken_image_outlined, color: Colors.grey),
    ),
  );

  Widget _withRadius(Widget child) {
    if (borderRadius == null) return child;
    return ClipRRect(borderRadius: borderRadius!, child: child);
  }

  @override
  Widget build(BuildContext context) {
    return _withRadius(switch (_type) {
      _ImageType.asset => Image.asset(
        path,
        width: width,
        height: height,
        fit: fit,
        color: color,
        colorBlendMode: colorBlendMode,
        errorBuilder: (_, __, ___) => errorWidget ?? _defaultError,
      ),
      _ImageType.network => CachedNetworkImage(
        imageUrl: path,
        width: width,
        height: height,
        fit: fit,
        color: color,
        colorBlendMode: colorBlendMode,
        placeholder: (_, __) => placeholder ?? _defaultPlaceholder,
        errorWidget: (_, __, ___) => errorWidget ?? _defaultError,
      ),
    });
  }
}
