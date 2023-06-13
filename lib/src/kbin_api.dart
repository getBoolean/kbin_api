// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// 🌎 Project imports:
import 'core/client/client_context.dart';
import 'core/config/retry_config.dart';
import 'service/kbin_v1_service.dart';
import 'service/kbin_v2_service.dart';
import 'service/oembed/oembed_service.dart';

abstract class KbinApi {
  /// Returns the new instance of [KbinApi].
  factory KbinApi({
    required String instance,
    String bearerToken = '',
    Duration timeout = const Duration(seconds: 10),
    RetryConfig? retryConfig,
  }) =>
      _KbinApi(
        instance: instance,
        bearerToken: bearerToken,
        timeout: timeout,
        retryConfig: retryConfig,
      );

  /// Returns the v1 service.
  KbinV1Service get v1;

  /// Returns the v2 service.
  KbinV2Service get v2;

  /// Returns the OEmbed service.
  OEmbedService get oembed;
}

class _KbinApi implements KbinApi {
  /// Returns the new instance of [_KbinApi].
  _KbinApi({
    required String instance,
    required String bearerToken,
    required Duration timeout,
    RetryConfig? retryConfig,
  })  : v1 = KbinV1Service(
          instance: instance,
          context: ClientContext(
            bearerToken: bearerToken,
            timeout: timeout,
            retryConfig: retryConfig,
          ),
        ),
        v2 = KbinV2Service(
          instance: instance,
          context: ClientContext(
            bearerToken: bearerToken,
            timeout: timeout,
            retryConfig: retryConfig,
          ),
        ),
        oembed = OEmbedService(
          instance: instance,
          context: ClientContext(
            bearerToken: bearerToken,
            timeout: timeout,
            retryConfig: retryConfig,
          ),
        );

  @override
  final KbinV1Service v1;

  @override
  final KbinV2Service v2;

  @override
  final OEmbedService oembed;
}
