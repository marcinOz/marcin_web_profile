import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:marcin_web_profile/constants.dart';

// --- Profile Stats Widget ---
class ProfileStats extends StatelessWidget {
  const ProfileStats({super.key}); // Add constructor

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;

    // TODO: Replace with actual data
    const String followers = '1.2k';
    const String repos = '48';
    const String connections = '5.8k';
    const String articles = '12';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildStatItem(context, l10n.githubFollowers, followers),
        _buildStatItem(context, l10n.repositories, repos),
        _buildStatItem(context, l10n.linkedinConnections, connections),
        _buildStatItem(context, l10n.technicalArticles, articles),
      ],
    );
  }

  Widget _buildStatItem(BuildContext context, String label, String value) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          // Make value bolder/larger per design
          style: textTheme.headlineMedium
              ?.copyWith(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        const SizedBox(height: 8), // Increase spacing
        Text(
          label,
          // Make label smaller/greyer per design
          style: textTheme.bodyMedium
              ?.copyWith(fontSize: 14, color: kSecondaryTextColor),
        ),
      ],
    );
  }
}
