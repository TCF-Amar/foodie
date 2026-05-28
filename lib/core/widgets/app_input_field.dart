import 'package:foodie/core/constant/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppInputField extends StatefulWidget {
  // ── Controller & Focus ────────────────────────────────────────
  final TextEditingController? controller;
  final FocusNode? focusNode;

  // ── Labels & Hints ────────────────────────────────────────────
  final String? label;
  final bool? showLabel;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final String? counterText;

  // ── Icons & Widgets ───────────────────────────────────────────
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? prefix;
  final Widget? suffix;
  final String? prefixText;
  final String? suffixText;

  // ── Input Config ──────────────────────────────────────────────
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final bool readOnly;
  final bool enabled;
  final bool autofocus;
  final bool autocorrect;
  final bool enableSuggestions;
  final int? maxLength;
  final int maxLines;
  final int minLines;
  final int? maxLengthEnforcement;
  final String obscuringCharacter;
  final TextDirection? textDirection;
  final TextAlign textAlign;
  final bool showCursor;
  final String? initialValue;

  // ── Style Overrides ───────────────────────────────────────────
  final Color? fillColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final Color? labelColor;
  final Color? hintColor;
  final Color? textColor;
  final Color? cursorColor;
  final double? borderRadius;
  final double borderWidth;
  final double focusedBorderWidth;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? textStyle;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? errorStyle;
  final TextStyle? helperStyle;
  final FloatingLabelBehavior floatingLabelBehavior;
  final double? cursorWidth;
  final double? cursorHeight;
  final bool? filled;

  // ── Callbacks ─────────────────────────────────────────────────
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;

  // ── Variant ───────────────────────────────────────────────────
  final _FieldVariant _variant;

  // ─────────────────────────────────────────────
  //  DEFAULT
  // ─────────────────────────────────────────────
  const AppInputField({
    super.key,
    this.controller,
    this.focusNode,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.counterText,
    this.prefixIcon,
    this.suffixIcon,
    this.prefix,
    this.suffix,
    this.prefixText,
    this.suffixText,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.autofocus = false,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.maxLength,
    this.maxLines = 1,
    this.minLines = 1,
    this.maxLengthEnforcement,
    this.obscuringCharacter = '•',
    this.textDirection,
    this.textAlign = TextAlign.start,
    this.showCursor = true,
    this.initialValue,
    this.fillColor,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.labelColor,
    this.hintColor,
    this.textColor,
    this.cursorColor,
    this.borderRadius,
    this.borderWidth = 1.0,
    this.focusedBorderWidth = 2.0,
    this.contentPadding,
    this.textStyle,
    this.labelStyle,
    this.hintStyle,
    this.errorStyle,
    this.helperStyle,
    this.floatingLabelBehavior = FloatingLabelBehavior.auto,
    this.cursorWidth,
    this.cursorHeight,
    this.filled,
    this.onChanged,
    this.onTap,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.validator,
    this.showLabel,
  }) : _variant = _FieldVariant.normal;

  // ─────────────────────────────────────────────
  //  EMAIL
  // ─────────────────────────────────────────────
  const AppInputField.email({
    super.key,
    this.controller,
    this.focusNode,
    this.label = 'Email',
    this.showLabel,
    this.hint = 'you@example.com',
    this.helperText,
    this.errorText,
    this.counterText,
    this.prefixIcon = const Icon(Icons.mail_outline_rounded),
    this.suffixIcon,
    this.prefix,
    this.suffix,
    this.prefixText,
    this.suffixText,
    this.keyboardType = TextInputType.emailAddress,
    this.textInputAction = TextInputAction.next,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.autofocus = false,
    this.autocorrect = false,
    this.enableSuggestions = false,
    this.maxLength,
    this.maxLines = 1,
    this.minLines = 1,
    this.maxLengthEnforcement,
    this.obscuringCharacter = '•',
    this.textDirection,
    this.textAlign = TextAlign.start,
    this.showCursor = true,
    this.initialValue,
    this.fillColor,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.labelColor,
    this.hintColor,
    this.textColor,
    this.cursorColor,
    this.borderRadius,
    this.borderWidth = 1.0,
    this.focusedBorderWidth = 2.0,
    this.contentPadding,
    this.textStyle,
    this.labelStyle,
    this.hintStyle,
    this.errorStyle,
    this.helperStyle,
    this.floatingLabelBehavior = FloatingLabelBehavior.auto,
    this.cursorWidth,
    this.cursorHeight,
    this.filled,
    this.onChanged,
    this.onTap,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.validator,
  }) : _variant = _FieldVariant.email;

  // ─────────────────────────────────────────────
  //  PASSWORD
  // ─────────────────────────────────────────────
  const AppInputField.password({
    super.key,
    this.controller,
    this.focusNode,
    this.label = 'Password',
    this.showLabel,

    this.hint = 'Enter your password',
    this.helperText,
    this.errorText,
    this.counterText,
    this.prefixIcon = const Icon(Icons.lock_outline_rounded),
    this.suffixIcon, // auto eye toggle — set in state
    this.prefix,
    this.suffix,
    this.prefixText,
    this.suffixText,
    this.keyboardType = TextInputType.visiblePassword,
    this.textInputAction = TextInputAction.done,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.obscureText = true,
    this.readOnly = false,
    this.enabled = true,
    this.autofocus = false,
    this.autocorrect = false,
    this.enableSuggestions = false,
    this.maxLength,
    this.maxLines = 1,
    this.minLines = 1,
    this.maxLengthEnforcement,
    this.obscuringCharacter = '•',
    this.textDirection,
    this.textAlign = TextAlign.start,
    this.showCursor = true,
    this.initialValue,
    this.fillColor,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.labelColor,
    this.hintColor,
    this.textColor,
    this.cursorColor,
    this.borderRadius,
    this.borderWidth = 1.0,
    this.focusedBorderWidth = 2.0,
    this.contentPadding,
    this.textStyle,
    this.labelStyle,
    this.hintStyle,
    this.errorStyle,
    this.helperStyle,
    this.floatingLabelBehavior = FloatingLabelBehavior.auto,
    this.cursorWidth,
    this.cursorHeight,
    this.filled,
    this.onChanged,
    this.onTap,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.validator,
  }) : _variant = _FieldVariant.password;

  // ─────────────────────────────────────────────
  //  PHONE
  // ─────────────────────────────────────────────
  const AppInputField.phone({
    super.key,
    this.controller,
    this.focusNode,
    this.showLabel,

    this.label = 'Phone Number',
    this.hint = '9876543210',
    this.helperText,
    this.errorText,
    this.counterText,
    this.prefixIcon = const Icon(Icons.phone_outlined),
    this.suffixIcon,
    this.prefix,
    this.suffix,
    this.prefixText,
    this.suffixText,
    this.keyboardType = TextInputType.phone,
    this.textInputAction = TextInputAction.next,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.autofocus = false,
    this.autocorrect = false,
    this.enableSuggestions = false,
    this.maxLength = 15,
    this.maxLines = 1,
    this.minLines = 1,
    this.maxLengthEnforcement,
    this.obscuringCharacter = '•',
    this.textDirection,
    this.textAlign = TextAlign.start,
    this.showCursor = true,
    this.initialValue,
    this.fillColor,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.labelColor,
    this.hintColor,
    this.textColor,
    this.cursorColor,
    this.borderRadius,
    this.borderWidth = 1.0,
    this.focusedBorderWidth = 2.0,
    this.contentPadding,
    this.textStyle,
    this.labelStyle,
    this.hintStyle,
    this.errorStyle,
    this.helperStyle,
    this.floatingLabelBehavior = FloatingLabelBehavior.auto,
    this.cursorWidth,
    this.cursorHeight,
    this.filled,
    this.onChanged,
    this.onTap,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.validator,
  }) : _variant = _FieldVariant.phone;

  // ─────────────────────────────────────────────
  //  SEARCH
  // ─────────────────────────────────────────────
  const AppInputField.search({
    super.key,
    this.controller,
    this.focusNode,
    this.label,
    this.hint = 'Search...',
    this.showLabel,

    this.helperText,
    this.errorText,
    this.counterText,
    this.prefixIcon = const Icon(Icons.search_rounded),
    this.suffixIcon,
    this.prefix,
    this.suffix,
    this.prefixText,
    this.suffixText,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.search,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.autofocus = false,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.maxLength,
    this.maxLines = 1,
    this.minLines = 1,
    this.maxLengthEnforcement,
    this.obscuringCharacter = '•',
    this.textDirection,
    this.textAlign = TextAlign.start,
    this.showCursor = true,
    this.initialValue,
    this.fillColor,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.labelColor,
    this.hintColor,
    this.textColor,
    this.cursorColor,
    this.borderRadius = 50,
    this.borderWidth = 0,
    this.focusedBorderWidth = 1.5,
    this.contentPadding,
    this.textStyle,
    this.labelStyle,
    this.hintStyle,
    this.errorStyle,
    this.helperStyle,
    this.floatingLabelBehavior = FloatingLabelBehavior.never,
    this.cursorWidth,
    this.cursorHeight,
    this.filled,
    this.onChanged,
    this.onTap,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.validator,
  }) : _variant = _FieldVariant.search;

  // ─────────────────────────────────────────────
  //  MULTILINE / TEXTAREA
  // ─────────────────────────────────────────────
  const AppInputField.multiline({
    super.key,
    this.controller,
    this.focusNode,
    this.label,
    this.showLabel,

    this.hint = 'Write something...',
    this.helperText,
    this.errorText,
    this.counterText,
    this.prefixIcon,
    this.suffixIcon,
    this.prefix,
    this.suffix,
    this.prefixText,
    this.suffixText,
    this.keyboardType = TextInputType.multiline,
    this.textInputAction = TextInputAction.newline,
    this.textCapitalization = TextCapitalization.sentences,
    this.inputFormatters,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.autofocus = false,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.maxLength,
    this.maxLines = 5,
    this.minLines = 3,
    this.maxLengthEnforcement,
    this.obscuringCharacter = '•',
    this.textDirection,
    this.textAlign = TextAlign.start,
    this.showCursor = true,
    this.initialValue,
    this.fillColor,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.labelColor,
    this.hintColor,
    this.textColor,
    this.cursorColor,
    this.borderRadius = 16,
    this.borderWidth = 1.0,
    this.focusedBorderWidth = 2.0,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 18,
      vertical: 16,
    ),
    this.textStyle,
    this.labelStyle,
    this.hintStyle,
    this.errorStyle,
    this.helperStyle,
    this.floatingLabelBehavior = FloatingLabelBehavior.auto,
    this.cursorWidth,
    this.cursorHeight,
    this.filled,
    this.onChanged,
    this.onTap,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.validator,
  }) : _variant = _FieldVariant.multiline;

  // ─────────────────────────────────────────────
  //  OTP
  // ─────────────────────────────────────────────
  const AppInputField.otp({
    super.key,
    this.controller,
    this.focusNode,
    this.label,
    this.showLabel,

    this.hint = '·',
    this.helperText,
    this.errorText,
    this.counterText = '',
    this.prefixIcon,
    this.suffixIcon,
    this.prefix,
    this.suffix,
    this.prefixText,
    this.suffixText,
    this.keyboardType = TextInputType.number,
    this.textInputAction = TextInputAction.next,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.autofocus = false,
    this.autocorrect = false,
    this.enableSuggestions = false,
    this.maxLength = 1,
    this.maxLines = 1,
    this.minLines = 1,
    this.maxLengthEnforcement,
    this.obscuringCharacter = '•',
    this.textDirection,
    this.textAlign = TextAlign.center,
    this.showCursor = false,
    this.initialValue,
    this.fillColor,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.labelColor,
    this.hintColor,
    this.textColor,
    this.cursorColor,
    this.borderRadius = 14,
    this.borderWidth = 1.5,
    this.focusedBorderWidth = 2.5,
    this.contentPadding = const EdgeInsets.symmetric(vertical: 16),
    this.textStyle,
    this.labelStyle,
    this.hintStyle,
    this.errorStyle,
    this.helperStyle,
    this.floatingLabelBehavior = FloatingLabelBehavior.never,
    this.cursorWidth,
    this.cursorHeight,
    this.filled,
    this.onChanged,
    this.onTap,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.validator,
  }) : _variant = _FieldVariant.otp;

  @override
  State<AppInputField> createState() => _AppInputFieldState();
}

// ─────────────────────────────────────────────────
//  STATE
// ─────────────────────────────────────────────────
class _AppInputFieldState extends State<AppInputField> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
  }

  bool get _isPassword => widget._variant == _FieldVariant.password;
  bool get _isOtp => widget._variant == _FieldVariant.otp;
  bool get _isSearch => widget._variant == _FieldVariant.search;

  // ── Resolved defaults per variant ─────────────────────────────
  double get _radius {
    if (widget.borderRadius != null) return widget.borderRadius!;
    return switch (widget._variant) {
      _FieldVariant.search => 50,
      _FieldVariant.otp => 14,
      _FieldVariant.multiline => 16,
      _ => 14,
    };
  }

  EdgeInsetsGeometry get _padding {
    if (widget.contentPadding != null) return widget.contentPadding!;
    return switch (widget._variant) {
      _FieldVariant.search => const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 14,
      ),
      _FieldVariant.otp => const EdgeInsets.symmetric(vertical: 16),
      _ => const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
    };
  }

  // ── Password eye toggle ───────────────────────────────────────
  Widget? get _suffixIcon {
    if (_isPassword) {
      return GestureDetector(
        onTap: () => setState(() => _obscure = !_obscure),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Icon(
            _obscure
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            size: 20,
            color:
                widget.hintColor ??
                Theme.of(context).inputDecorationTheme.prefixIconColor,
          ),
        ),
      );
    }
    if (_isSearch && widget.controller != null) {
      return ValueListenableBuilder<TextEditingValue>(
        valueListenable: widget.controller!,
        builder: (_, val, _) => val.text.isEmpty
            ? const SizedBox.shrink()
            : GestureDetector(
                onTap: () => widget.controller?.clear(),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Icon(Icons.close_rounded, size: 18),
                ),
              ),
      );
    }
    return widget.suffixIcon;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // final scheme = theme.colorScheme;
    // final idTheme = theme.inputDecorationTheme;
    final isLight = theme.brightness == Brightness.light;

    // ── Resolved colors ───────────────────────────────────────
    final resolvedFill =
        widget.fillColor ??
        (isLight ? AppColors.bgSecondary : AppColors.darkCard);

    final resolvedBorder =
        widget.borderColor ??
        (isLight ? AppColors.borderLight : AppColors.darkBorder);

    final resolvedFocusBorder = widget.focusedBorderColor ?? AppColors.primary;

    final resolvedErrorBorder = widget.errorBorderColor ?? AppColors.error;

    final resolvedTextColor =
        widget.textColor ??
        (isLight ? AppColors.textPrimary : AppColors.darkTextPrimary);

    final resolvedHint =
        widget.hintColor ??
        (isLight ? AppColors.textHint : AppColors.darkTextHint);

    final resolvedLabel =
        widget.labelColor ??
        (isLight ? AppColors.textSecondary : AppColors.darkTextSecondary);

    final resolvedCursor = widget.cursorColor ?? AppColors.primary;

    // ── OTP: no border when empty, filled when has value ──────
    final otpFocusBorder = _isOtp ? resolvedFocusBorder : resolvedFocusBorder;

    // ── Text styles ───────────────────────────────────────────
    final resolvedTextStyle =
        widget.textStyle ??
        TextStyle(
          fontSize: _isOtp ? 20 : 15,
          fontWeight: _isOtp ? FontWeight.w700 : FontWeight.w500,
          color: resolvedTextColor,
          fontFamily: theme.textTheme.bodyLarge?.fontFamily,
        );

    final resolvedLabelStyle =
        widget.labelStyle ??
        TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: resolvedLabel,
          fontFamily: theme.textTheme.bodyLarge?.fontFamily,
        );

    final resolvedHintStyle =
        widget.hintStyle ??
        TextStyle(
          fontSize: _isOtp ? 18 : 14,
          color: resolvedHint,
          fontFamily: theme.textTheme.bodyLarge?.fontFamily,
        );

    final resolvedErrorStyle =
        widget.errorStyle ??
        const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.error,
        );

    final resolvedHelperStyle =
        widget.helperStyle ??
        TextStyle(
          fontSize: 12,
          color: resolvedHint,
          fontFamily: theme.textTheme.bodyLarge?.fontFamily,
        );

    // ── Border builder ────────────────────────────────────────
    OutlineInputBorder border(Color color, double width) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(_radius),
      borderSide: BorderSide(color: color, width: width),
    );

    // ── Field ────────────────────────────────────────────────
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      initialValue: widget.initialValue,
      keyboardType: widget.maxLines > 1
          ? TextInputType.multiline
          : widget.keyboardType,
      textInputAction: widget.textInputAction,
      textCapitalization: widget.textCapitalization,
      inputFormatters:
          widget.inputFormatters ??
          (_isOtp ? [FilteringTextInputFormatter.digitsOnly] : null),
      obscureText: _isPassword ? _obscure : widget.obscureText,
      obscuringCharacter: widget.obscuringCharacter,
      readOnly: widget.readOnly,
      enabled: widget.enabled,
      autofocus: widget.autofocus,
      autocorrect: widget.autocorrect,
      enableSuggestions: widget.enableSuggestions,
      maxLength: widget.maxLength,
      maxLines: widget.obscureText ? 1 : widget.maxLines,
      minLines: widget.minLines,
      textAlign: widget.textAlign,
      textDirection: widget.textDirection,
      showCursor: widget.showCursor,
      cursorColor: resolvedCursor,
      cursorWidth: widget.cursorWidth ?? 2,
      cursorHeight: widget.cursorHeight,
      cursorRadius: const Radius.circular(2),
      style: resolvedTextStyle,
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      onEditingComplete: widget.onEditingComplete,
      onFieldSubmitted: widget.onFieldSubmitted,
      onSaved: widget.onSaved,
      validator: widget.validator,
      decoration: InputDecoration(
        labelText: widget.showLabel == false ? null : widget.label,
        hintText: widget.hint,
        helperText: widget.helperText,
        errorText: widget.errorText,
        counterText: widget.counterText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: _suffixIcon,
        prefix: widget.prefix,
        suffix: widget.suffix,
        prefixText: widget.prefixText,
        suffixText: widget.suffixText,
        filled: widget.filled ?? true,
        fillColor: widget.enabled
            ? resolvedFill
            : resolvedFill.withValues(alpha: 0.5),
        contentPadding: _padding,
        floatingLabelBehavior: widget.floatingLabelBehavior,
        labelStyle: resolvedLabelStyle,
        floatingLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: resolvedFocusBorder,
          fontFamily: theme.textTheme.bodyLarge?.fontFamily,
        ),
        hintStyle: resolvedHintStyle,
        errorStyle: resolvedErrorStyle,
        helperStyle: resolvedHelperStyle,
        prefixIconColor: resolvedHint,
        suffixIconColor: resolvedHint,
        border: border(resolvedBorder, widget.borderWidth),
        enabledBorder: border(resolvedBorder, widget.borderWidth),
        focusedBorder: border(otpFocusBorder, widget.focusedBorderWidth),
        errorBorder: border(resolvedErrorBorder, widget.borderWidth),
        focusedErrorBorder: border(
          resolvedErrorBorder,
          widget.focusedBorderWidth,
        ),
        disabledBorder: border(
          resolvedBorder.withValues(alpha: 0.4),
          widget.borderWidth,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────
//  ENUM
// ─────────────────────────────────────────────────
enum _FieldVariant { normal, email, password, phone, search, multiline, otp }
