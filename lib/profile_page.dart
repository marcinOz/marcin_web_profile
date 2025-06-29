import 'package:flutter/material.dart';
import 'package:marcin_web_profile/constants.dart';
import 'package:marcin_web_profile/widgets/profile/custom_app_bar.dart';
import 'package:marcin_web_profile/widgets/profile/profile_header.dart';
import 'package:marcin_web_profile/widgets/profile/profile_stats.dart';
import 'package:marcin_web_profile/widgets/profile/experience_section.dart';
import 'package:marcin_web_profile/widgets/profile/articles_section.dart';
import 'package:marcin_web_profile/widgets/profile/github_activity_section.dart';
import 'package:marcin_web_profile/widgets/profile/certifications_section.dart';
import 'package:marcin_web_profile/widgets/profile/skills_section.dart';
import 'package:marcin_web_profile/widgets/profile/profile_footer.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Instantiate public widgets directly
    const experienceSection = ExperienceSection();
    const articlesSection = ArticlesSection();
    const githubActivitySection = GithubActivitySection();
    const certificationsSection = CertificationsSection();
    const skillsSection = SkillsSection();
    const footerSection = ProfileFooter();

    return Scaffold(
      appBar: CustomAppBar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // The main SingleChildScrollView allows the page to scroll
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header content (constrained)
                Card(
                  shape:
                      RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  margin: EdgeInsets.only(top: kSmallPadding),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1200),
                      child: const Padding(
                        padding: EdgeInsets.all(kSectionPadding),
                        child: ProfileHeader(), // Use public widget
                      ),
                    ),
                  ),
                ),
                // Stats content (constrained)
                Card(
                  shape:
                      RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  margin: EdgeInsets.zero,
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1200),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: kSectionPadding,
                            vertical: kSectionPadding),
                        child: ProfileStats(), // Use public widget
                      ),
                    ),
                  ),
                ),
                // Space before main content
                const SizedBox(height: kSectionPadding),
                // The rest of the content is centered and constrained
                Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1200),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Responsive layout for main content and sidebar
                        if (constraints.maxWidth < kDesktopBreakpoint)
                          // Mobile/Tablet: Stack content vertically
                          Padding(
                            padding: const EdgeInsets.all(kSectionPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                experienceSection,
                                const SizedBox(height: kSectionPadding),
                                articlesSection,
                                const SizedBox(height: kSectionPadding),
                                githubActivitySection,
                                const SizedBox(height: kSectionPadding),
                                certificationsSection,
                                const SizedBox(height: kSectionPadding),
                                skillsSection,
                              ],
                            ),
                          )
                        else
                          // Desktop: Row with Main Content and Sidebar
                          Padding(
                            padding: const EdgeInsets.all(kSectionPadding),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Main Content (Experience, Articles)
                                Expanded(
                                  flex: 2, // Takes 2/3 width
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      experienceSection,
                                      const SizedBox(height: kSectionPadding),
                                      articlesSection,
                                    ],
                                  ),
                                ),
                                const SizedBox(width: kSectionPadding),
                                // Sidebar (GitHub, Certs, Skills)
                                Expanded(
                                  flex: 1, // Takes 1/3 width
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      githubActivitySection,
                                      const SizedBox(height: kSectionPadding),
                                      certificationsSection,
                                      const SizedBox(height: kSectionPadding),
                                      skillsSection,
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        // Footer is also constrained
                        Padding(
                          padding: const EdgeInsets.only(top: kSectionPadding),
                          child: footerSection,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
