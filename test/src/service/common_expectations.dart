// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// 🌎 Project imports:
import 'package:kbin_api/src/old_mastodon/core/exception/data_not_found_exception.dart';
import 'package:kbin_api/src/old_mastodon/core/exception/kbin_exception.dart';
import 'package:kbin_api/src/old_mastodon/core/exception/rate_limit_exceeded_exception.dart';
import 'package:kbin_api/src/old_mastodon/core/exception/unauthorized_exception.dart';
// 📦 Package imports:
import 'package:test/test.dart';

void expectKbinException(Function fn) {
  expect(
    () async => await fn.call(),
    throwsA(
      allOf(
        isA<KbinException>(),
        predicate(
          (dynamic e) =>
              e.message ==
              'Required parameter is missing or improperly formatted.',
        ),
      ),
    ),
  );
}

void expectUnauthorizedException(Function fn) {
  expect(
    () async => await fn.call(),
    throwsA(
      allOf(
        isA<UnauthorizedException>(),
        predicate(
          (dynamic e) => e.message == 'The specified access token is invalid.',
        ),
      ),
    ),
  );
}

void expectRateLimitExceededException(Function fn) {
  expect(
    () async => fn.call(),
    throwsA(
      allOf(
        isA<RateLimitExceededException>(),
        predicate((RateLimitExceededException e) =>
            e.message == 'Rate limit exceeded.'),
      ),
    ),
  );
}

void expectDataNotFoundExceptionDueToNoJson(Function fn) {
  expect(
    () async => await fn.call(),
    throwsA(
      allOf(
        isA<KbinException>(),
        predicate(
          (KbinException e) => e.message == 'No body exists in response.',
        ),
      ),
    ),
  );
}

void expectDataNotFoundExceptionDueToNotFound(Function fn) {
  expect(
    () async => await fn.call(),
    throwsA(
      allOf(
        isA<DataNotFoundException>(),
        predicate(
          (DataNotFoundException e) =>
              e.message == 'There is no data associated with request.',
        ),
      ),
    ),
  );
}

void expectDataNotFoundExceptionDueToNoData(Function fn) {
  expect(
    () async => await fn.call(),
    throwsA(
      allOf(
        isA<DataNotFoundException>(),
        predicate(
          (DataNotFoundException e) =>
              e.message == 'No data exists in response.',
        ),
      ),
    ),
  );
}
