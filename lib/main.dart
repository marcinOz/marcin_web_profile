import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:marcin_web_profile/profile_page.dart'; // Import the profile page
import 'package:marcin_web_profile/constants.dart'; // Import constants

void main() {
  // TODO: Initialize GetIt dependency injection here
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) {
        // Use the context to get the localized title
        // This ensures the title updates if the locale changes
        return AppLocalizations.of(context)?.profilePageTitle ?? 'Profile';
      },
      theme: ThemeData(
        scaffoldBackgroundColor: kScaffoldBackground,
        colorScheme: ColorScheme.fromSeed(
          seedColor: kAccentColor,
          surface: kScaffoldBackground,
        ),
        textTheme: const TextTheme(
          // Define some basic text styles matching the design intent
          headlineLarge: TextStyle(
              color: kPrimaryTextColor,
              fontWeight: FontWeight.bold,
              fontSize: 28),
          headlineMedium: TextStyle(
              color: kPrimaryTextColor,
              fontWeight: FontWeight.bold,
              fontSize: 22),
          headlineSmall: TextStyle(
              color: kPrimaryTextColor,
              fontWeight: FontWeight.bold,
              fontSize: 18),
          bodyLarge: TextStyle(color: kPrimaryTextColor, fontSize: 16),
          bodyMedium: TextStyle(color: kSecondaryTextColor, fontSize: 14),
          labelLarge:
              TextStyle(color: kPrimaryTextColor, fontWeight: FontWeight.bold),
          // Add more styles as needed (e.g., for buttons, chips)
        ),
        cardTheme: CardTheme(
          elevation: 1.0,
          color: kCardBackground,
          surfaceTintColor: Colors.transparent, // Prevents M3 tinting
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            side: BorderSide(color: Colors.grey.shade300, width: 0.5),
          ),
          margin: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor:
              kCardBackground, // Match card background for seamless look
          elevation: 1.0, // Slight shadow
          titleTextStyle: TextStyle(
              color: kPrimaryTextColor,
              fontSize: 18,
              fontWeight: FontWeight.w500),
          iconTheme: IconThemeData(color: kPrimaryTextColor),
          surfaceTintColor: Colors.transparent,
        ),
        chipTheme: ChipThemeData(
          labelStyle: const TextStyle(
              color: kSecondaryTextColor,
              fontSize: 12,
              fontWeight: FontWeight.w500),
          iconTheme: const IconThemeData(color: kSecondaryTextColor, size: 16),
          side: BorderSide.none,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding * 0.75,
              vertical: kDefaultPadding * 0.5),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: kPrimaryTextColor,
            textStyle: const TextStyle(fontWeight: FontWeight.w500),
            padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
          ),
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('pl'), // Polish
      ],
      home: const ProfilePage(), // Set ProfilePage as the home
      // Remove the default MyHomePage
    );
  }
}

// Remove the default MyHomePage StatefulWidget and State
