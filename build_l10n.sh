flutter pub run intl_translation:extract_to_arb --output-dir=lib/l10n lib/main.dart
flutter pub run intl_translation:generate_from_arb --output-dir=lib/l10n --no-use-deferred-loading lib/localization.dart lib/l10n/intl_*.arb
