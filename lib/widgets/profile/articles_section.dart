import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:marcin_web_profile/constants.dart';
import 'section_title.dart'; // Import helper widget

// --- Recent Articles Section ---
class ArticlesSection extends StatelessWidget {
  const ArticlesSection({super.key}); // Add key

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // TODO: Replace with actual Article data model and list
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: l10n.recentArticles),
        _ArticleCard(
          sourceIcon: Icons.article, // Placeholder
          sourceName: 'Published on Medium',
          title: 'Scaling Mobile Architecture for Millions of Users',
          description:
              'A deep dive into how we scaled our mobile architecture at OLX to handle millions of daily active users...',
          date: 'Mar 15, 2025',
          readTime: '12 min read',
          engagement: '2.3k claps',
        ),
        const SizedBox(height: kDefaultPadding),
        _ArticleCard(
          sourceIcon: Icons.link, // Placeholder for LinkedIn
          sourceName: 'Published on LinkedIn',
          title: 'Building High-Performance Mobile Teams',
          description:
              'Insights from my journey of building and leading mobile engineering teams...',
          date: 'Feb 28, 2025',
          readTime: '8 min read',
          engagement: '856 likes',
        ),
      ],
    );
  }
}

// --- Article Card Widget ---
class _ArticleCard extends StatelessWidget {
  final IconData sourceIcon; // TODO: Use actual SVG/Image assets
  final String sourceName;
  final String title;
  final String description;
  final String date;
  final String readTime;
  final String engagement;

  const _ArticleCard({
    required this.sourceIcon,
    required this.sourceName,
    required this.title,
    required this.description,
    required this.date,
    required this.readTime,
    required this.engagement,
    // Removed key here as it's internal
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(sourceIcon, size: 16, color: kSecondaryTextColor),
                const SizedBox(width: 8),
                Text(sourceName, style: textTheme.bodySmall),
              ],
            ),
            const SizedBox(height: kDefaultPadding / 2),
            Text(title,
                style: textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: kDefaultPadding / 2),
            Text(description,
                style: textTheme.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis),
            const SizedBox(height: kDefaultPadding),
            Row(
              children: [
                Text(date, style: textTheme.bodySmall),
                const Text(' • ',
                    style: TextStyle(fontSize: 12, color: kSecondaryTextColor)),
                Text(readTime, style: textTheme.bodySmall),
                const Text(' • ',
                    style: TextStyle(fontSize: 12, color: kSecondaryTextColor)),
                Text(engagement, style: textTheme.bodySmall),
              ],
            )
          ],
        ),
      ),
    );
  }
}
