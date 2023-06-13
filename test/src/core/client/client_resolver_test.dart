// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// 🌎 Project imports:
import 'package:kbin_api/src/old_mastodon/core/client/anonymous_client.dart';
import 'package:kbin_api/src/old_mastodon/core/client/client_resolver.dart';
import 'package:kbin_api/src/old_mastodon/core/client/oauth2_client.dart';
import 'package:kbin_api/src/old_mastodon/core/client/user_context.dart';
import 'package:kbin_api/src/old_mastodon/core/exception/unauthorized_exception.dart';
// 📦 Package imports:
import 'package:test/test.dart';

void main() {
  group('.execute', () {
    test('when user context is oauth2Only', () {
      final resolver = ClientResolver(
        AnonymousClient(),
        OAuth2Client(bearerToken: 'test'),
      );

      final client = resolver.execute(UserContext.oauth2Only);

      expect(client, isA<OAuth2Client>());
    });

    test('when user context is oauth2OrAnonymous and bearer token is empty',
        () {
      final resolver = ClientResolver(
        AnonymousClient(),
        null,
      );

      final client = resolver.execute(UserContext.oauth2OrAnonymous);

      expect(client, isA<AnonymousClient>());
    });

    test('when user context is oauth2OrAnonymous and bearer token is not empty',
        () {
      final resolver = ClientResolver(
        AnonymousClient(),
        OAuth2Client(bearerToken: ''),
      );

      final client = resolver.execute(UserContext.oauth2OrAnonymous);

      expect(client, isA<OAuth2Client>());
    });

    test('when user context is oauth2Only and bearer token is not passed', () {
      final resolver = ClientResolver(
        AnonymousClient(),
        null,
      );

      expect(
        () => resolver.execute(UserContext.oauth2Only),
        throwsA(isA<UnauthorizedException>()),
      );
    });
  });
}
