import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:marcin_web_profile/constants.dart';

// --- Technical Skills Section ---
class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key}); // Add key

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;

    // Based on LinkedIn profile and experience
    final List<String> skills = [
      'Flutter',
      'Android',
      'Team Leadership',
      'Engineering Management',
      'Product Development',
      'Operational Excellence',
      'AWS',
      'Mobile Architecture',
      'Mentoring',
      'Public Speaking',
      'Technical Writing'
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.technicalSkills,
                style: textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: kDefaultPadding),
            Wrap(
              spacing: kDefaultPadding / 2,
              runSpacing: kDefaultPadding / 2,
              children:
                  skills.map((skill) => Chip(label: Text(skill))).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
