import 'package:flutter/material.dart';
import 'package:marcin_web_profile/constants.dart';

// --- Section Title Widget ---
class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({required this.title, super.key}); // Add key

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kDefaultPadding),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
