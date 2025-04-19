import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:marcin_web_profile/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 60,
      title: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kSectionPadding),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.grey.shade300,
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/app_bar_avatar.png',
                      width: 36,
                      height: 36,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.person, size: 18),
                    ),
                  ),
                ),
                const SizedBox(width: kDefaultPadding),
                Text(
                  l10n.name,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                TextButton(onPressed: () {}, child: Text(l10n.overview)),
                TextButton(onPressed: () {}, child: Text(l10n.experience)),
                TextButton(onPressed: () {}, child: Text(l10n.articles)), 
                TextButton(onPressed: () {}, child: Text(l10n.projects)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}