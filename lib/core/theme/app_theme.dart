import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodie/core/constant/colors/app_colors.dart';

abstract final class AppTheme {
  static const String _font = 'Poppins';

  // ── Entry points ───────────────────────────────────────────────
  static ThemeData get light => _build(Brightness.light);
  static ThemeData get dark => _build(Brightness.dark);

  // ── Single builder ─────────────────────────────────────────────
  static ThemeData _build(Brightness brightness) {
    final isLight = brightness == Brightness.light;

    // ── Color scheme ──────────────────────────────────────────────
    final scheme = isLight ? _lightScheme : _darkScheme;

    // ── System UI overlay ─────────────────────────────────────────
    final overlayStyle = isLight
        ? const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: AppColors.surface,
            systemNavigationBarIconBrightness: Brightness.dark,
          )
        : const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarColor: AppColors.darkSurface,
            systemNavigationBarIconBrightness: Brightness.light,
          );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      fontFamily: _font,
      colorScheme: scheme,

      scaffoldBackgroundColor: isLight ? AppColors.bgPrimary : AppColors.darkBg,

      // ── AppBar ────────────────────────────────────────────────
      appBarTheme: AppBarTheme(
        backgroundColor: isLight ? AppColors.surface : AppColors.darkSurface,
        foregroundColor: isLight
            ? AppColors.textPrimary
            : AppColors.darkTextPrimary,
        elevation: 0,
        scrolledUnderElevation: 0.5,
        centerTitle: false,
        systemOverlayStyle: overlayStyle,
        titleTextStyle: TextStyle(
          fontFamily: _font,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: isLight ? AppColors.textPrimary : AppColors.darkTextPrimary,
          letterSpacing: -0.3,
        ),
        iconTheme: IconThemeData(
          color: isLight ? AppColors.textPrimary : AppColors.darkTextPrimary,
          size: 22,
        ),
      ),

      // ── Bottom Nav ────────────────────────────────────────────
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: isLight ? AppColors.surface : AppColors.darkSurface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: isLight
            ? AppColors.textHint
            : AppColors.darkTextHint,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: const TextStyle(
          fontFamily: _font,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: _font,
          fontSize: 11,
          fontWeight: FontWeight.w400,
        ),
      ),

      // ── Nav Bar M3 ────────────────────────────────────────────
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: isLight ? AppColors.surface : AppColors.darkSurface,
        indicatorColor: AppColors.primary50,
        elevation: 0,
        iconTheme: WidgetStateProperty.resolveWith(
          (s) => IconThemeData(
            size: 22,
            color: s.contains(WidgetState.selected)
                ? AppColors.primary
                : (isLight ? AppColors.textHint : AppColors.darkTextHint),
          ),
        ),
        labelTextStyle: WidgetStateProperty.resolveWith(
          (s) => TextStyle(
            fontFamily: _font,
            fontSize: 11,
            fontWeight: s.contains(WidgetState.selected)
                ? FontWeight.w700
                : FontWeight.w400,
            color: s.contains(WidgetState.selected)
                ? AppColors.primary
                : (isLight ? AppColors.textHint : AppColors.darkTextHint),
          ),
        ),
      ),

      // ── Card ─────────────────────────────────────────────────
      cardTheme: CardThemeData(
        color: isLight ? AppColors.surface : AppColors.darkCard,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: isLight ? AppColors.borderLight : AppColors.darkBorder,
            width: 1,
          ),
        ),
      ),

      // ── Elevated Button ───────────────────────────────────────
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textOnPrimary,
          disabledBackgroundColor: isLight
              ? AppColors.textDisabled
              : AppColors.darkBorder,
          elevation: 0,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(
            fontFamily: _font,
            fontSize: 15,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.2,
          ),
        ),
      ),

      // ── Outlined Button ───────────────────────────────────────
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(
            fontFamily: _font,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      // ── Text Button ───────────────────────────────────────────
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: const TextStyle(
            fontFamily: _font,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      // ── FAB ───────────────────────────────────────────────────
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        elevation: 0,
        highlightElevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(18)),
        ),
      ),

      // ── Input ────────────────────────────────────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isLight ? AppColors.bgSecondary : AppColors.darkCard,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 15,
        ),
        hintStyle: TextStyle(
          fontFamily: _font,
          fontSize: 14,
          color: isLight ? AppColors.textHint : AppColors.darkTextHint,
        ),
        labelStyle: TextStyle(
          fontFamily: _font,
          fontSize: 14,
          color: isLight
              ? AppColors.textSecondary
              : AppColors.darkTextSecondary,
        ),
        floatingLabelStyle: const TextStyle(
          fontFamily: _font,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: isLight ? AppColors.borderMedium : AppColors.darkBorder,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: isLight ? AppColors.borderLight : AppColors.darkBorder,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        prefixIconColor: isLight ? AppColors.textHint : AppColors.darkTextHint,
        suffixIconColor: isLight ? AppColors.textHint : AppColors.darkTextHint,
        errorStyle: const TextStyle(
          fontFamily: _font,
          fontSize: 12,
          color: AppColors.error,
        ),
      ),

      // ── Chip ─────────────────────────────────────────────────
      chipTheme: ChipThemeData(
        backgroundColor: isLight ? AppColors.bgSecondary : AppColors.darkCard,
        selectedColor: AppColors.primary50,
        checkmarkColor: AppColors.primary,
        side: BorderSide(
          color: isLight ? AppColors.borderLight : AppColors.darkBorder,
          width: 1,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        labelStyle: TextStyle(
          fontFamily: _font,
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: isLight
              ? AppColors.textSecondary
              : AppColors.darkTextSecondary,
        ),
        secondaryLabelStyle: const TextStyle(
          fontFamily: _font,
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
      ),

      // ── Tab Bar ───────────────────────────────────────────────
      tabBarTheme: TabBarThemeData(
        labelColor: AppColors.primary,
        unselectedLabelColor: isLight
            ? AppColors.textHint
            : AppColors.darkTextHint,
        indicatorColor: AppColors.primary,
        indicatorSize: TabBarIndicatorSize.label,
        dividerColor: Colors.transparent,
        labelStyle: const TextStyle(
          fontFamily: _font,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: _font,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),

      // ── Divider ───────────────────────────────────────────────
      dividerTheme: DividerThemeData(
        color: isLight ? AppColors.borderLight : AppColors.darkBorder,
        thickness: 1,
        space: 1,
      ),

      // ── Icon ─────────────────────────────────────────────────
      iconTheme: IconThemeData(
        color: isLight ? AppColors.textSecondary : AppColors.darkTextSecondary,
        size: 22,
      ),

      // ── Switch ───────────────────────────────────────────────
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected)
              ? AppColors.textOnPrimary
              : (isLight ? AppColors.textHint : AppColors.darkTextHint),
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected)
              ? AppColors.primary
              : (isLight ? AppColors.borderMedium : AppColors.darkBorder),
        ),
        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      ),

      // ── Checkbox ─────────────────────────────────────────────
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected)
              ? AppColors.primary
              : Colors.transparent,
        ),
        checkColor: WidgetStateProperty.all(AppColors.textOnPrimary),
        side: BorderSide(
          color: isLight ? AppColors.borderStrong : AppColors.darkBorder,
          width: 1.5,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),

      // ── Radio ────────────────────────────────────────────────
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected)
              ? AppColors.primary
              : (isLight ? AppColors.textHint : AppColors.darkTextHint),
        ),
      ),

      // ── Progress ─────────────────────────────────────────────
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary,
        linearTrackColor: AppColors.primary50,
        circularTrackColor: AppColors.primary50,
      ),

      // ── Slider ───────────────────────────────────────────────
      sliderTheme: SliderThemeData(
        activeTrackColor: AppColors.primary,
        inactiveTrackColor: AppColors.primary50,
        thumbColor: AppColors.primary,
        overlayColor: AppColors.primary.withOpacity(0.12),
        valueIndicatorColor: AppColors.primary800,
        valueIndicatorTextStyle: const TextStyle(
          fontFamily: _font,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: AppColors.textOnPrimary,
        ),
      ),

      // ── SnackBar ─────────────────────────────────────────────
      snackBarTheme: SnackBarThemeData(
        backgroundColor: isLight
            ? AppColors.textPrimary
            : AppColors.darkElevated,
        contentTextStyle: TextStyle(
          fontFamily: _font,
          fontSize: 13,
          color: isLight ? AppColors.bgPrimary : AppColors.darkTextPrimary,
        ),
        actionTextColor: AppColors.secondary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
      ),

      // ── Bottom Sheet ──────────────────────────────────────────
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: isLight ? AppColors.surface : AppColors.darkSurface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        dragHandleColor: isLight
            ? AppColors.borderStrong
            : AppColors.darkBorder,
        showDragHandle: true,
      ),

      // ── Dialog ───────────────────────────────────────────────
      dialogTheme: DialogThemeData(
        backgroundColor: isLight ? AppColors.surface : AppColors.darkCard,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        titleTextStyle: TextStyle(
          fontFamily: _font,
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: isLight ? AppColors.textPrimary : AppColors.darkTextPrimary,
        ),
        contentTextStyle: TextStyle(
          fontFamily: _font,
          fontSize: 14,
          color: isLight
              ? AppColors.textSecondary
              : AppColors.darkTextSecondary,
        ),
      ),

      // ── List Tile ────────────────────────────────────────────
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        iconColor: isLight
            ? AppColors.textSecondary
            : AppColors.darkTextSecondary,
        titleTextStyle: TextStyle(
          fontFamily: _font,
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: isLight ? AppColors.textPrimary : AppColors.darkTextPrimary,
        ),
        subtitleTextStyle: TextStyle(
          fontFamily: _font,
          fontSize: 13,
          color: isLight
              ? AppColors.textSecondary
              : AppColors.darkTextSecondary,
        ),
      ),

      // ── Text Theme ───────────────────────────────────────────
      textTheme: _textTheme(isLight),
    );
  }

  // ── Color Schemes ─────────────────────────────────────────────
  static const ColorScheme _lightScheme = ColorScheme.light(
    primary: AppColors.primary,
    onPrimary: AppColors.textOnPrimary,
    primaryContainer: AppColors.primary50,
    onPrimaryContainer: AppColors.primary800,
    secondary: AppColors.secondary500,
    onSecondary: AppColors.textOnDark,
    secondaryContainer: AppColors.secondary50,
    onSecondaryContainer: AppColors.secondary900,
    tertiary: AppColors.accent,
    onTertiary: AppColors.textOnPrimary,
    tertiaryContainer: AppColors.accent50,
    onTertiaryContainer: AppColors.accent800,
    error: AppColors.error,
    onError: AppColors.textOnPrimary,
    errorContainer: AppColors.errorLight,
    onErrorContainer: AppColors.accent800,
    surface: AppColors.surface,
    onSurface: AppColors.textPrimary,
    onSurfaceVariant: AppColors.textSecondary,
    outline: AppColors.borderMedium,
    outlineVariant: AppColors.borderLight,
    scrim: AppColors.overlay60,
    inverseSurface: AppColors.darkSurface,
    onInverseSurface: AppColors.darkTextPrimary,
    inversePrimary: AppColors.primary200,
  );

  static const ColorScheme _darkScheme = ColorScheme.dark(
    primary: AppColors.primary,
    onPrimary: AppColors.textOnPrimary,
    primaryContainer: AppColors.primary800,
    onPrimaryContainer: AppColors.primary200,
    secondary: AppColors.secondary,
    onSecondary: AppColors.secondary900,
    secondaryContainer: AppColors.secondary800,
    onSecondaryContainer: AppColors.secondary100,
    tertiary: AppColors.accent,
    onTertiary: AppColors.textOnPrimary,
    tertiaryContainer: AppColors.accent800,
    onTertiaryContainer: AppColors.accent200,
    error: AppColors.error,
    onError: AppColors.textOnPrimary,
    errorContainer: AppColors.accent800,
    onErrorContainer: AppColors.accent100,
    surface: AppColors.darkSurface,
    onSurface: AppColors.darkTextPrimary,
    onSurfaceVariant: AppColors.darkTextSecondary,
    outline: AppColors.darkBorder,
    outlineVariant: AppColors.darkCard,
    scrim: AppColors.overlay60,
    inverseSurface: AppColors.surface,
    onInverseSurface: AppColors.textPrimary,
    inversePrimary: AppColors.primary600,
  );

  // ── Text Theme ────────────────────────────────────────────────
  static TextTheme _textTheme(bool isLight) {
    final p = isLight ? AppColors.textPrimary : AppColors.darkTextPrimary;
    final s = isLight ? AppColors.textSecondary : AppColors.darkTextSecondary;
    final h = isLight ? AppColors.textHint : AppColors.darkTextHint;

    return TextTheme(
      displayLarge: _s(32, FontWeight.w800, p, -1.0),
      displayMedium: _s(28, FontWeight.w800, p, -0.5),
      displaySmall: _s(24, FontWeight.w700, p, -0.5),
      headlineLarge: _s(22, FontWeight.w700, p, -0.3),
      headlineMedium: _s(20, FontWeight.w700, p, -0.2),
      headlineSmall: _s(18, FontWeight.w700, p, 0.0),
      titleLarge: _s(16, FontWeight.w700, p, 0.0),
      titleMedium: _s(15, FontWeight.w600, p, 0.1),
      titleSmall: _s(14, FontWeight.w600, s, 0.1),
      bodyLarge: _s(16, FontWeight.w400, p, 0.0),
      bodyMedium: _s(14, FontWeight.w400, s, 0.0),
      bodySmall: _s(12, FontWeight.w400, h, 0.0),
      labelLarge: _s(14, FontWeight.w700, p, 0.2),
      labelMedium: _s(12, FontWeight.w600, s, 0.3),
      labelSmall: _s(11, FontWeight.w500, h, 0.4),
    );
  }

  static TextStyle _s(
    double size,
    FontWeight weight,
    Color color,
    double spacing,
  ) => TextStyle(
    fontFamily: _font,
    fontSize: size,
    fontWeight: weight,
    color: color,
    letterSpacing: spacing,
    height: 1.4,
  );
}
