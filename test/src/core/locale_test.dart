// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// 🌎 Project imports:
import 'package:kbin_api/src/old_mastodon/core/country.dart';
import 'package:kbin_api/src/old_mastodon/core/language.dart';
import 'package:kbin_api/src/old_mastodon/core/locale.dart';
// 📦 Package imports:
import 'package:test/test.dart';

void main() {
  test('.toString', () {
    expect(
      Locale(lang: Language.english, country: Country.unitedStates).toString(),
      'en_US',
    );
  });
}
