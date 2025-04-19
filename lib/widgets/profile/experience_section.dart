import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:marcin_web_profile/constants.dart';
import 'section_title.dart'; // Import helper widget

// --- Professional Experience Section ---
class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key}); // Add key

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // TODO: Replace with actual Experience data model and list
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: l10n.professionalExperience),
        _ExperienceCard(
          logoAsset: 'assets/images/olx_logo_placeholder.png', // Placeholder
          title: l10n
              .jobTitle, // Re-using for now, should have specific job titles
          company: 'OLX Group', // Hardcoded
          period: 'Jan 2023 - Present • Berlin, Germany', // Hardcoded
          descriptionPoints: [
            'Leading a team of 15 mobile engineers across iOS and Android platforms',
            'Implementing mobile architecture strategies and best practices',
            'Driving technical excellence and innovation in mobile development',
          ],
        ),
        const SizedBox(height: kDefaultPadding),
        _ExperienceCard(
          logoAsset: 'assets/images/uber_logo_placeholder.png', // Placeholder
          title: 'Senior Mobile Engineer', // Hardcoded
          company: 'Uber', // Hardcoded
          period: 'Jun 2020 - Dec 2022 • Amsterdam, Netherlands', // Hardcoded
          descriptionPoints: [
            'Led development of key features in Uber Driver app',
            'Improved app performance by 40%',
            'Mentored junior engineers and conducted technical interviews',
          ],
        ),
      ],
    );
  }
}

// --- Experience Card Widget ---
class _ExperienceCard extends StatelessWidget {
  final String logoAsset;
  final String title;
  final String company;
  final String period;
  final List<String> descriptionPoints;

  const _ExperienceCard({
    required this.logoAsset,
    required this.title,
    required this.company,
    required this.period,
    required this.descriptionPoints,
    // Removed key here as it's internal
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Company Logo
            ClipRRect(
              borderRadius:
                  BorderRadius.circular(8.0), // Rounded corners for logo
              child: Container(
                width: 50, // Adjust size as needed
                height: 50,
                color: Colors.grey.shade200, // Placeholder bg
                // TODO: Replace with Image.asset(logoAsset)
                child: const Icon(Icons.business,
                    color: Colors.grey), // Placeholder icon
              ),
            ),
            const SizedBox(width: kDefaultPadding),
            // Job Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text("$company • Full-time", style: textTheme.bodyMedium),
                  Text(period,
                      style: textTheme.bodySmall
                          ?.copyWith(color: kSecondaryTextColor)),
                  const SizedBox(height: kDefaultPadding),
                  // Description Points
                  ...descriptionPoints.map((point) => Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('• ',
                                style: TextStyle(color: kSecondaryTextColor)),
                            Expanded(
                                child:
                                    Text(point, style: textTheme.bodyMedium)),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
