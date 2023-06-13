// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

import 'package:kbin_api/kbin_api.dart';

Future<void> main() async {
  //! You need to specify mastodon instance (domain) you want to access.
  //! Also you need to get bearer token from your developer page, or OAuth 2.0.
  final mastodon = KbinApi(
    instance: 'KBIN_INSTANCE',
    bearerToken: 'YOUR_BEARER_TOKEN',

    //! Automatic retry is available when server error or network error occurs
    //! when communicating with the API.
    retryConfig: RetryConfig(
      maxAttempts: 5,
      jitter: Jitter(
        minInSeconds: 2,
        maxInSeconds: 5,
      ),
      onExecute: (event) => print(
        'Retry after ${event.intervalInSeconds} seconds...'
        '[${event.retryCount} times]',
      ),
    ),

    //! The default timeout is 10 seconds.
    timeout: Duration(seconds: 20),
  );

  try {
    //! Let's Toot from v1 endpoint!
    final status = await mastodon.v1.statuses.createStatus(
      text: 'Toot!',
    );

    print(status.rateLimit);
    print(status.data);

    //! Search contents includes accounts, statuses, hashtags.
    final contents = await mastodon.v2.search.searchContents(
      query: 'test',
      excludeUnreviewedTags: true,
      limit: 10,
      offset: 2,
    );

    print(contents);
  } on UnauthorizedException catch (e) {
    print(e);
  } on RateLimitExceededException catch (e) {
    print(e);
  } on KbinException catch (e) {
    print(e.response);
    print(e.body);
    print(e);
  }
}
