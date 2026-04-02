import 'package:flutter/material.dart';

abstract final class AppColors {
  // ── Primary · Electric Violet ─────────────────────────────────
  static const Color primary50 = Color(0xFFF3EEFF);
  static const Color primary100 = Color(0xFFD9BFFF);
  static const Color primary200 = Color(0xFFB98EFF);
  static const Color primary = Color(0xFF8B5CF6); // 500 – main
  static const Color primary600 = Color(0xFF6D3EE8);
  static const Color primary800 = Color(0xFF4C27C0);
  static const Color primary900 = Color(0xFF2E1678);

  // ── Secondary · Neon Lime ──────────────────────────────────────
  static const Color secondary50 = Color(0xFFF2FFE5);
  static const Color secondary100 = Color(0xFFCCFF80);
  static const Color secondary = Color(0xFFAAFF3E); // 300 – main
  static const Color secondary500 = Color(0xFF7ACC1A);
  static const Color secondary700 = Color(0xFF5A9910);
  static const Color secondary800 = Color(0xFF3B660A);
  static const Color secondary900 = Color(0xFF1F3305);

  // ── Accent · Hot Coral ─────────────────────────────────────────
  static const Color accent50 = Color(0xFFFFF0ED);
  static const Color accent100 = Color(0xFFFFCCC4);
  static const Color accent200 = Color(0xFFFF9B8A);
  static const Color accent = Color(0xFFFF5C44); // 500 – main
  static const Color accent700 = Color(0xFFD93B25);
  static const Color accent800 = Color(0xFFA82B18);
  static const Color accent900 = Color(0xFF6E1A0C);

  // ── Highlight · Electric Yellow ────────────────────────────────
  static const Color yellow50 = Color(0xFFFFFBDF);
  static const Color yellow100 = Color(0xFFFFF176);
  static const Color yellow = Color(0xFFFFE500); // 400 – main
  static const Color yellow600 = Color(0xFFCCA800);
  static const Color yellow800 = Color(0xFF8A6E00);

  // ── Light · Backgrounds & Surfaces ────────────────────────────
  static const Color bgPrimary = Color(0xFFFAFAFA);
  static const Color bgSecondary = Color(0xFFF4F2FF);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF0ECFF);

  // ── Light · Borders ────────────────────────────────────────────
  static const Color borderLight = Color(0xFFEBE6FF);
  static const Color borderMedium = Color(0xFFD4C9FF);
  static const Color borderStrong = Color(0xFFB09EEA);

  // ── Light · Text ───────────────────────────────────────────────
  static const Color textPrimary = Color(0xFF0D0B1A);
  static const Color textSecondary = Color(0xFF4A4262);
  static const Color textHint = Color(0xFF9B93B8);
  static const Color textDisabled = Color(0xFFCEC9E3);
  static const Color textOnDark = Color(0xFFFFFFFF);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color textOnLime = Color(0xFF1F3305);

  // ── Dark · Backgrounds & Surfaces ─────────────────────────────
  static const Color darkBg = Color(0xFF0A0A0F);
  static const Color darkSurface = Color(0xFF13111E);
  static const Color darkCard = Color(0xFF1E1A30);
  static const Color darkElevated = Color(0xFF2A2540);
  static const Color darkBorder = Color(0xFF362F55);

  // ── Dark · Text ────────────────────────────────────────────────
  static const Color darkTextPrimary = Color(0xFFF0ECFF);
  static const Color darkTextSecondary = Color(0xFFB09EEA);
  static const Color darkTextHint = Color(0xFF6B5E8F);

  // ── Semantic ───────────────────────────────────────────────────
  static const Color success = Color(0xFF00D68F);
  static const Color successLight = Color(0xFFDFFFF6);
  static const Color warning = Color(0xFFFFE500);
  static const Color warningLight = Color(0xFFFFFBDF);
  static const Color error = Color(0xFFFF5C44);
  static const Color errorLight = Color(0xFFFFF0ED);
  static const Color info = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFFEFF6FF);

  // ── App-specific ───────────────────────────────────────────────
  static const Color rating = Color(0xFFFFE500);
  static const Color vegDot = Color(0xFF00D68F);
  static const Color nonVegDot = Color(0xFFFF5C44);
  static const Color promoChipBg = Color(0xFFF3EEFF);
  static const Color promoChipText = Color(0xFF6D3EE8);
  static const Color offerBadgeBg = Color(0xFFCCFF80);
  static const Color offerBadgeText = Color(0xFF1F3305);
  static const Color shimmerBase = Color(0xFFF0ECFF);
  static const Color shimmerHighlight = Color(0xFFFFFFFF);

  // ── Overlay ────────────────────────────────────────────────────
  static const Color overlay10 = Color(0x1A000000);
  static const Color overlay30 = Color(0x4D000000);
  static const Color overlay60 = Color(0x99000000);
  static const Color overlayImage = Color(0x55000000);
}
