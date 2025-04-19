import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:marcin_web_profile/constants.dart';

// --- Profile Header Widget ---
class ProfileHeader extends StatelessWidget {
  // Use a more specific placeholder name
  final String profileImageUrl =
      'assets/images/profile_image.png'; // Placeholder

  const ProfileHeader({super.key}); // Add constructor

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final chipTheme = Theme.of(context).chipTheme;

    // Keep simple Row, ensure image SizedBox is square
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Profile Picture (Square with rounded corners)
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          // TODO: Add assets/images/profile_image.png
          child: Image.asset(
            profileImageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: Colors.grey.shade300,
              child: const Icon(Icons.person, size: 200, color: Colors.white),
            ), // Fallback container
          ),
        ),
        const SizedBox(width: kSectionPadding),
        // Text Details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.name,
                  style: textTheme.headlineLarge
                      ?.copyWith(fontSize: 32)), // Slightly larger name
              const SizedBox(height: kDefaultPadding * 0.75),
              Text(l10n.jobTitle,
                  style: textTheme.headlineSmall?.copyWith(
                      color: kSecondaryTextColor,
                      fontWeight: FontWeight.normal)), // Adjust style
              const SizedBox(height: kDefaultPadding * 1.5),
              Text(l10n.bio, style: textTheme.bodyLarge),
              const SizedBox(height: kDefaultPadding * 1.5),
              // Chips/Badges with specific colors and icons
              Wrap(
                spacing: kDefaultPadding,
                runSpacing: kDefaultPadding / 2,
                children: [
                  Chip(
                    avatar: const Icon(Icons.location_on_outlined, size: 18),
                    label: Text(l10n.location),
                    backgroundColor: kLocationChipColor,
                    labelStyle: chipTheme.labelStyle
                        ?.copyWith(color: Colors.blue.shade800),
                    iconTheme: chipTheme.iconTheme
                        ?.copyWith(color: Colors.blue.shade800),
                  ),
                  Chip(
                    avatar: const Icon(Icons.groups_outlined, size: 18),
                    label: Text(l10n.mentoring),
                    backgroundColor: kMentoringChipColor,
                    labelStyle: chipTheme.labelStyle
                        ?.copyWith(color: Colors.green.shade800),
                    iconTheme: chipTheme.iconTheme
                        ?.copyWith(color: Colors.green.shade800),
                  ),
                  Chip(
                    avatar: const Icon(Icons.code_outlined, size: 18),
                    label: Text(l10n.area),
                    backgroundColor: kAreaChipColor,
                    labelStyle: chipTheme.labelStyle
                        ?.copyWith(color: Colors.purple.shade800),
                    iconTheme: chipTheme.iconTheme
                        ?.copyWith(color: Colors.purple.shade800),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
