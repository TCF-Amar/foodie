// app_footer.dart
// ignore_for_file: unused_element_parameter

import 'package:flutter/material.dart';
import 'package:foodie/core/widgets/index.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.fromLTRB(20, 32, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Top divider ───────────────────────────────────────
          Divider(
            color: isLight ? AppColors.borderLight : AppColors.darkBorder,
            thickness: 1,
            height: 1,
          ),
          const SizedBox(height: 28),

          // ── Brand + tagline ───────────────────────────────────
          _Brand(isLight: isLight),
          const SizedBox(height: 24),

          // ── Links row ─────────────────────────────────────────
          _LinksSection(isLight: isLight),
          const SizedBox(height: 24),

          // ── Social row ────────────────────────────────────────
          _SocialRow(isLight: isLight),
          const SizedBox(height: 24),

          Divider(
            color: isLight ? AppColors.borderLight : AppColors.darkBorder,
            thickness: 1,
            height: 1,
          ),
          const SizedBox(height: 16),

          // ── Bottom bar ────────────────────────────────────────
          _BottomBar(isLight: isLight),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────
//  BRAND
// ─────────────────────────────────────────────────
class _Brand extends StatelessWidget {
  final bool isLight;
  const _Brand({required this.isLight});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Logo pill
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: .min,
            children: [
              AppImage.asset(AppImages.logo, height: 24, width: 24),
              AppText(
                'foodie',
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: -0.5,
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        AppText.small(
          'Good food, delivered fast.\nOrder anytime, anywhere.',
          color: isLight
              ? AppColors.textSecondary
              : AppColors.darkTextSecondary,
          height: 1.6,
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────
//  LINKS SECTION
// ─────────────────────────────────────────────────
class _FooterLink {
  final String label;
  final VoidCallback? onTap;
  const _FooterLink(this.label, {this.onTap});
}

class _FooterGroup {
  final String title;
  final List<_FooterLink> links;
  const _FooterGroup({required this.title, required this.links});
}

final _footerGroups = [
  _FooterGroup(
    title: 'Company',
    links: [
      _FooterLink('About Us'),
      _FooterLink('Careers'),
      _FooterLink('Blog'),
      _FooterLink('Press'),
    ],
  ),
  _FooterGroup(
    title: 'Support',
    links: [
      _FooterLink('Help Center'),
      _FooterLink('Contact Us'),
      _FooterLink('Track Order'),
      _FooterLink('Refunds'),
    ],
  ),
  _FooterGroup(
    title: 'Legal',
    links: [
      _FooterLink('Privacy Policy'),
      _FooterLink('Terms of Use'),
      _FooterLink('Cookie Policy'),
    ],
  ),
];

class _LinksSection extends StatelessWidget {
  final bool isLight;
  const _LinksSection({required this.isLight});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _footerGroups
          .map(
            (g) => Expanded(
              child: _LinkGroup(group: g, isLight: isLight),
            ),
          )
          .toList(),
    );
  }
}

class _LinkGroup extends StatelessWidget {
  final _FooterGroup group;
  final bool isLight;
  const _LinkGroup({required this.group, required this.isLight});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Group title
        AppText(
          group.title,
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: isLight ? AppColors.textPrimary : AppColors.darkTextPrimary,
          letterSpacing: 0.4,
        ),
        const SizedBox(height: 10),

        // Links
        ...group.links.map(
          (link) => GestureDetector(
            onTap: link.onTap,
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: AppText(
                link.label,
                fontSize: 12,
                color: isLight
                    ? AppColors.textSecondary
                    : AppColors.darkTextSecondary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────
//  SOCIAL ROW
// ─────────────────────────────────────────────────
class _SocialBtn {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  const _SocialBtn({required this.icon, required this.label, this.onTap});
}

final _socialBtns = [
  _SocialBtn(icon: Icons.facebook_rounded, label: 'Facebook'),
  _SocialBtn(icon: Icons.camera_alt_outlined, label: 'Instagram'),
  _SocialBtn(icon: Icons.close_rounded, label: 'X'), // X/Twitter
  _SocialBtn(icon: Icons.play_circle_outline, label: 'YouTube'),
];

class _SocialRow extends StatelessWidget {
  final bool isLight;
  const _SocialRow({required this.isLight});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          'Follow Us',
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: isLight ? AppColors.textPrimary : AppColors.darkTextPrimary,
        ),
        const SizedBox(height: 10),
        Row(
          children: _socialBtns
              .map(
                (s) => Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: s.onTap,
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: isLight
                            ? AppColors.bgPrimary
                            : AppColors.darkCard,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isLight
                              ? AppColors.borderLight
                              : AppColors.darkBorder,
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        s.icon,
                        size: 18,
                        color: isLight
                            ? AppColors.textSecondary
                            : AppColors.darkTextSecondary,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────
//  BOTTOM BAR
// ─────────────────────────────────────────────────
class _BottomBar extends StatelessWidget {
  final bool isLight;
  const _BottomBar({required this.isLight});

  @override
  Widget build(BuildContext context) {
    final muted = isLight ? AppColors.textHint : AppColors.darkTextHint;

    return Row(
      children: [
        Expanded(
          child: AppText(
            '© ${DateTime.now().year} Foodie. All rights reserved.',
            fontSize: 11,
            color: muted,
          ),
        ),

        // App store badges
        Row(
          children: [
            _StoreBadge(
              icon: Icons.apple,
              label: 'App Store',
              isLight: isLight,
            ),
            const SizedBox(width: 8),
            _StoreBadge(
              icon: Icons.android_rounded,
              label: 'Play Store',
              isLight: isLight,
            ),
          ],
        ),
      ],
    );
  }
}

class _StoreBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isLight;
  const _StoreBadge({
    required this.icon,
    required this.label,
    required this.isLight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isLight ? AppColors.bgPrimary : AppColors.darkCard,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isLight ? AppColors.borderLight : AppColors.darkBorder,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: isLight
                ? AppColors.textSecondary
                : AppColors.darkTextSecondary,
          ),
          const SizedBox(width: 4),
          AppText(
            label,
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: isLight
                ? AppColors.textSecondary
                : AppColors.darkTextSecondary,
          ),
        ],
      ),
    );
  }
}
