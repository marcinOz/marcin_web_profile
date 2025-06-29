import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:marcin_web_profile/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

// --- Profile Footer Section ---
class ProfileFooter extends StatelessWidget {
  const ProfileFooter({super.key}); // Add key

  // TODO: Replace with actual URLs
  final String githubUrl = 'https://github.com';
  final String linkedinUrl = 'https://linkedin.com';
  final String mediumUrl = 'https://medium.com';
  final String twitterUrl = 'https://x.com';

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      // TODO: Handle error (e.g., show a snackbar)
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;

    // TODO: Get actual last updated date
    final String lastUpdatedDate =
        DateFormat('MMMM yyyy').format(DateTime.now());

    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: kSectionPadding, vertical: kDefaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Social Links
          Row(
            children: [
              // TODO: Replace with actual SVG Icons for better quality
              IconButton(
                  icon: const Icon(Icons.code_sharp),
                  tooltip: 'GitHub',
                  onPressed: () => _launchUrl(githubUrl)),
              IconButton(
                  icon: const Icon(Icons.link),
                  tooltip: 'LinkedIn',
                  onPressed: () => _launchUrl(linkedinUrl)),
              IconButton(
                  icon: const Icon(Icons.article_outlined),
                  tooltip: 'Medium',
                  onPressed: () => _launchUrl(mediumUrl)),
              IconButton(
                  icon: const Icon(Icons.flutter_dash_rounded),
                  tooltip: 'Twitter/X',
                  onPressed: () => _launchUrl(twitterUrl)),
            ],
          ),
          // Last Updated Text
          Text(
            l10n.lastUpdated(lastUpdatedDate),
            style: textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
