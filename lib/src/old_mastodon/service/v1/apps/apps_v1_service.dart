// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Project imports:

// 🌎 Project imports:
import '../../../../core/client/client_context.dart';
import '../../../../core/client/user_context.dart';
import '../../../../core/scope.dart';
import '../../base_service.dart';
import '../../entities/application.dart';
import '../../entities/empty.dart';
import '../../entities/registered_application.dart';
import '../../response/kbin_response.dart';

abstract class AppsV1Service {
  /// Returns the new instance of [AppsV1Service].
  factory AppsV1Service({
    required String instance,
    required ClientContext context,
  }) =>
      _AppsV1Service(
        instance: instance,
        context: context,
      );

  /// Create a new application to obtain OAuth2 credentials.
  ///
  /// ## Parameters
  ///
  /// - [clientName]: A name for your application.
  ///
  /// - [redirectUri]: Where the user should be redirected after authorization.
  ///                  In default `urn:ietf:wg:oauth:2.0:oob` will be used.
  ///
  /// - [scopes]: List of scopes. If none is provided, defaults to read.
  ///
  /// - [websiteUrl]: A URL to the homepage of your app.
  ///
  /// ## Endpoint Url
  ///
  /// - GET /api/v1/apps HTTP/1.1
  ///
  /// ## Authentication Methods
  ///
  /// - Anonymous
  ///
  /// ## Reference
  ///
  /// - https://docs.joinmastodon.org/methods/apps/#create
  Future<KbinResponse<RegisteredApplication>> createApplication({
    required String clientName,
    String redirectUri = 'urn:ietf:wg:oauth:2.0:oob',
    List<Scope>? scopes,
    String? websiteUrl,
  });

  /// Confirm that the app’s OAuth2 credentials work.
  ///
  /// ## Parameters
  ///
  /// - [bearerToken]: Access token you want to verify.
  ///
  /// ## Endpoint Url
  ///
  /// - GET /api/v1/apps/verify_credentials HTTP/1.1
  ///
  /// ## Authentication Methods
  ///
  /// - Anonymous
  ///
  /// ## Reference
  ///
  /// - https://docs.joinmastodon.org/methods/apps/#verify_credentials
  Future<KbinResponse<Application>> verifyApplicationCredentials({
    required String bearerToken,
  });

  /// Request a new confirmation email, potentially to a new email address.
  ///
  /// ## Parameters
  ///
  /// - [email]: If provided, updates the unconfirmed user’s email before
  ///            resending the confirmation email.
  ///
  /// ## Endpoint Url
  ///
  /// - POST /api/v1/emails/confirmation HTTP/1.1
  ///
  /// ## Authentication Methods
  ///
  /// - OAuth 2.0
  ///
  /// ## Reference
  ///
  /// - https://docs.joinmastodon.org/methods/emails/#confirmation
  Future<KbinResponse<Empty>> createNewConfirmationEmail({
    required String email,
  });
}

class _AppsV1Service extends BaseService implements AppsV1Service {
  /// Returns the new instance of [_AppsV1Service].
  _AppsV1Service({
    required super.instance,
    required super.context,
  });

  @override
  Future<KbinResponse<RegisteredApplication>> createApplication({
    required String clientName,
    String redirectUri = 'urn:ietf:wg:oauth:2.0:oob',
    List<Scope>? scopes,
    String? websiteUrl,
  }) async =>
      super.transformSingleDataResponse(
        await super.post(
          UserContext.anonymousOnly,
          '/api/v1/apps',
          body: {
            'client_name': clientName,
            'redirect_uris': redirectUri,
            'scopes': scopes?.map((e) => e.value).join(" "),
            'website': websiteUrl,
          },
        ),
        dataBuilder: RegisteredApplication.fromJson,
      );

  @override
  Future<KbinResponse<Application>> verifyApplicationCredentials({
    required String bearerToken,
  }) async =>
      super.transformSingleDataResponse(
        await super.get(
          UserContext.anonymousOnly,
          '/api/v1/apps/verify_credentials',
          headers: {
            'Authorization': 'Bearer $bearerToken',
          },
        ),
        dataBuilder: Application.fromJson,
      );

  @override
  Future<KbinResponse<Empty>> createNewConfirmationEmail({
    required String email,
  }) async =>
      super.transformEmptyResponse(
        await super.post(
          UserContext.oauth2Only,
          '/api/v1/emails/confirmation',
          body: {
            'email': email,
          },
        ),
      );
}
