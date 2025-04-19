import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:marcin_web_profile/constants.dart';

// --- Certifications & Badges Section ---
class CertificationsSection extends StatelessWidget {
  const CertificationsSection({super.key}); // Add key

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.certificationsAndBadges,
                style: textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: kDefaultPadding),
            // TODO: Replace with actual data model and list
            _buildCertificationItem(
              context,
              Icons.g_mobiledata, // Placeholder for Google icon
              'Google Developer Expert',
              'Android Development • 2024',
            ),
            _buildCertificationItem(
              context,
              Icons.flutter_dash, // Placeholder for Flutter icon
              'Flutter Certified Developer',
              'Advanced Level • 2023',
            ),
            _buildCertificationItem(
              context,
              Icons.apple, // Placeholder for Apple icon
              'iOS Development',
              'Apple Certified • 2022',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCertificationItem(
      BuildContext context, IconData icon, String title, String subtitle) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
      child: Row(
        children: [
          // TODO: Use actual Image/SVG assets for icons
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 24, color: kSecondaryTextColor),
          ),
          const SizedBox(width: kDefaultPadding),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w500)),
                Text(subtitle, style: textTheme.bodySmall),
              ],
            ),
          )
        ],
      ),
    );
  }
}
