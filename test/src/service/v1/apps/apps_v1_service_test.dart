// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// 🌎 Project imports:
import 'package:kbin_api/src/core/client/user_context.dart';
import 'package:kbin_api/src/core/exception/kbin_exception.dart';
import 'package:kbin_api/src/core/scope.dart';
import 'package:kbin_api/src/old_mastodon/service/entities/application.dart';
import 'package:kbin_api/src/old_mastodon/service/entities/empty.dart';
import 'package:kbin_api/src/old_mastodon/service/entities/rate_limit.dart';
import 'package:kbin_api/src/old_mastodon/service/entities/registered_application.dart';
import 'package:kbin_api/src/old_mastodon/service/response/kbin_response.dart';
import 'package:kbin_api/src/old_mastodon/service/v1/apps/apps_v1_service.dart';
// 📦 Package imports:
import 'package:test/test.dart';

import '../../../../mocks/client_context_stubs.dart' as context;
import '../../common_expectations.dart';

void main() {
  group('.createApplication', () {
    test('normal case', () async {
      final appsService = AppsV1Service(
        instance: 'test',
        context: context.buildPostStub(
          'test',
          UserContext.anonymousOnly,
          '/api/v1/apps',
          'test/src/service/v1/apps/data/create_application.json',
        ),
      );

      final response = await appsService.createApplication(
        clientName: 'test',
        redirectUri: 'https://test//:oauth',
        scopes: [Scope.read],
        websiteUrl: 'https://shinyakato.dev',
      );

      expect(response, isA<KbinResponse>());
      expect(response.rateLimit, isA<RateLimit>());
      expect(response.data, isA<RegisteredApplication>());
    });

    test('multiple scopes', () async {
      final appsService = AppsV1Service(
        instance: 'test',
        context: context.buildPostStub(
          'test',
          UserContext.anonymousOnly,
          '/api/v1/apps',
          'test/src/service/v1/apps/data/create_application.json',
        ),
      );

      final response = await appsService.createApplication(
        clientName: 'test',
        redirectUri: 'https://test//:oauth',
        scopes: [Scope.read, Scope.write, Scope.push],
        websiteUrl: 'https://shinyakato.dev',
      );

      expect(response, isA<KbinResponse>());
      expect(response.rateLimit, isA<RateLimit>());
      expect(response.data, isA<RegisteredApplication>());
    });

    test('when unauthorized', () async {
      final appsService = AppsV1Service(
        instance: 'test',
        context: context.buildPostStub(
          'test',
          UserContext.anonymousOnly,
          '/api/v1/apps',
          'test/src/service/v1/apps/data/create_application.json',
          statusCode: 401,
        ),
      );

      expectUnauthorizedException(
        () async => await appsService.createApplication(clientName: 'test'),
      );
    });

    test('when rate limit exceeded', () async {
      final appsService = AppsV1Service(
        instance: 'test',
        context: context.buildPostStub(
          'test',
          UserContext.anonymousOnly,
          '/api/v1/apps',
          'test/src/service/v1/apps/data/create_application.json',
          statusCode: 429,
        ),
      );

      expectRateLimitExceededException(
        () async => await appsService.createApplication(clientName: 'test'),
      );
    });

    test('when parameters are invalid', () async {
      final appsService = AppsV1Service(
        instance: 'test',
        context: context.buildPostStub(
          'test',
          UserContext.anonymousOnly,
          '/api/v1/apps',
          'test/src/service/v1/apps/data/create_application.json',
          statusCode: 422,
        ),
      );

      expect(
        () async => await appsService.createApplication(clientName: ''),
        throwsA(
          allOf(
            isA<KbinException>(),
            predicate(
              (KbinException e) =>
                  e.message ==
                  'Required parameter is missing or improperly formatted.',
            ),
          ),
        ),
      );
    });
  });

  group('.verifyApplicationCredentials', () {
    test('normal case', () async {
      final appsService = AppsV1Service(
        instance: 'test',
        context: context.buildGetStub(
          'test',
          UserContext.anonymousOnly,
          '/api/v1/apps/verify_credentials',
          'test/src/service/v1/apps/data/verify_oauth_credentials.json',
          {},
          headers: {
            'Authorization': 'Bearer test',
          },
        ),
      );

      final response = await appsService.verifyApplicationCredentials(
        bearerToken: 'test',
      );

      expect(response, isA<KbinResponse>());
      expect(response.rateLimit, isA<RateLimit>());
      expect(response.data, isA<Application>());
    });

    test('when unauthorized', () async {
      final appsService = AppsV1Service(
        instance: 'test',
        context: context.buildGetStub(
          'test',
          UserContext.anonymousOnly,
          '/api/v1/apps/verify_credentials',
          'test/src/service/v1/apps/data/verify_oauth_credentials.json',
          statusCode: 401,
          {},
          headers: {
            'Authorization': 'Bearer test',
          },
        ),
      );

      expectUnauthorizedException(
        () async => await appsService.verifyApplicationCredentials(
          bearerToken: 'test',
        ),
      );
    });

    test('when rate limit exceeded', () async {
      final appsService = AppsV1Service(
        instance: 'test',
        context: context.buildGetStub(
          'test',
          UserContext.anonymousOnly,
          '/api/v1/apps/verify_credentials',
          'test/src/service/v1/apps/data/create_application.json',
          statusCode: 429,
          {},
          headers: {
            'Authorization': 'Bearer test',
          },
        ),
      );

      expectRateLimitExceededException(
        () async => await appsService.verifyApplicationCredentials(
          bearerToken: 'test',
        ),
      );
    });
  });

  group('.createNewConfirmationEmail', () {
    test('normal case', () async {
      final appsService = AppsV1Service(
        instance: 'test',
        context: context.buildPostStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/emails/confirmation',
          'test/src/service/v1/apps/data/create_new_confirmation_email.json',
        ),
      );

      final response = await appsService.createNewConfirmationEmail(
        email: 'test',
      );

      expect(response, isA<KbinResponse>());
      expect(response.rateLimit, isA<RateLimit>());
      expect(response.data, isA<Empty>());
    });

    test('when access is forbidden', () async {
      final appsService = AppsV1Service(
        instance: 'test',
        context: context.buildPostStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/emails/confirmation',
          'test/src/service/v1/apps/data/create_new_confirmation_email.json',
          statusCode: 403,
        ),
      );

      expectKbinException(
        () async => await appsService.createNewConfirmationEmail(
          email: 'test',
        ),
      );
    });

    test('when unauthorized', () async {
      final appsService = AppsV1Service(
        instance: 'test',
        context: context.buildPostStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/emails/confirmation',
          'test/src/service/v1/apps/data/create_new_confirmation_email.json',
          statusCode: 401,
        ),
      );

      expectUnauthorizedException(
        () async => await appsService.createNewConfirmationEmail(
          email: 'test',
        ),
      );
    });

    test('when rate limit exceeded', () async {
      final appsService = AppsV1Service(
        instance: 'test',
        context: context.buildPostStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/emails/confirmation',
          'test/src/service/v1/apps/data/create_new_confirmation_email.json',
          statusCode: 429,
        ),
      );

      expectRateLimitExceededException(
        () async => await appsService.createNewConfirmationEmail(
          email: 'test',
        ),
      );
    });
  });
}
