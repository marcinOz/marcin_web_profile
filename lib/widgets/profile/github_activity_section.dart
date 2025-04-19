import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:marcin_web_profile/constants.dart';

// --- GitHub Activity Section ---
class GithubActivitySection extends StatelessWidget {
  const GithubActivitySection({super.key}); // Add key

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;

    // TODO: Replace with actual data
    const String contributions = '1,248';
    const String pullRequests = '186';
    const String issuesClosed = '342';

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(l10n.githubActivity,
                    style: textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold)),
                // TODO: Add actual Github logo icon/link
                const Icon(Icons.code,
                    color: kSecondaryTextColor), // Placeholder
              ],
            ),
            const SizedBox(height: kDefaultPadding),
            _buildGithubStat(context, l10n.contributions, contributions),
            _buildGithubStat(context, l10n.pullRequests, pullRequests),
            _buildGithubStat(context, l10n.issuesClosed, issuesClosed),
            const SizedBox(height: kDefaultPadding),
            // Placeholder for the contribution graph
            Container(
              height: 100,
              color: Colors.grey.shade200,
              alignment: Alignment.center,
              child: Text('Contribution Graph Placeholder',
                  style: textTheme.bodySmall),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGithubStat(BuildContext context, String label, String value) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: textTheme.bodyMedium),
          Text(value,
              style:
                  textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
