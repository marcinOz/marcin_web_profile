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
          logoAsset: 'assets/images/olx_logo_placeholder.png',
          title: 'Engineering Manager',
          company: 'OLX',
          period: 'January 2025 - Present • Gdańsk, Poland',
          descriptionPoints: [
            'Leading the Engineering team for the App Platform',
            'Managing engineering quality baselines and best practices',
            'Driving technical excellence across mobile platforms',
          ],
        ),
        const SizedBox(height: kDefaultPadding),
        _ExperienceCard(
          logoAsset: 'assets/images/netguru_logo_placeholder.png',
          title: 'Engineering Lead',
          company: 'Netguru',
          period: 'August 2021 - December 2024 • Gdańsk, Poland',
          descriptionPoints: [
            'Led cross-functional teams and set engineering quality baselines',
            'Mentored and coached direct reports across multiple projects',
            'Set engineering strategy and maintained key stakeholder relationships',
            'Balanced client, team, and company needs to achieve optimal results',
          ],
        ),
        const SizedBox(height: kDefaultPadding),
        _ExperienceCard(
          logoAsset: 'assets/images/netguru_logo_placeholder.png',
          title: 'Senior Flutter Developer',
          company: 'Netguru',
          period: 'March 2020 - October 2021 • Gdańsk, Poland',
          descriptionPoints: [
            'Started Flutter department at Netguru',
            'Flutter Recruitment and Processes Owner',
            'Established Flutter development best practices',
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
