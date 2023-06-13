// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// 🌎 Project imports:
import 'package:kbin_api/src/old_mastodon/core/client/user_context.dart';
import 'package:kbin_api/src/old_mastodon/core/exception/kbin_exception.dart';
import 'package:kbin_api/src/old_mastodon/service/entities/account.dart';
import 'package:kbin_api/src/old_mastodon/service/entities/empty.dart';
import 'package:kbin_api/src/old_mastodon/service/entities/poll.dart';
import 'package:kbin_api/src/old_mastodon/service/entities/rate_limit.dart';
import 'package:kbin_api/src/old_mastodon/service/entities/scheduled_status.dart';
import 'package:kbin_api/src/old_mastodon/service/entities/status.dart';
import 'package:kbin_api/src/old_mastodon/service/entities/status_context.dart';
import 'package:kbin_api/src/old_mastodon/service/entities/status_edit.dart';
import 'package:kbin_api/src/old_mastodon/service/entities/status_source.dart';
import 'package:kbin_api/src/old_mastodon/service/response/kbin_response.dart';
import 'package:kbin_api/src/old_mastodon/service/v1/statuses/status_poll_param.dart';
import 'package:kbin_api/src/old_mastodon/service/v1/statuses/statuses_v1_service.dart';
// 📦 Package imports:
import 'package:test/test.dart';

import '../../../../mocks/client_context_stubs.dart' as context;
import '../../common_expectations.dart';

void main() {
  group('.createStatus', () {
    test('normal case', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildPostStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/statuses',
          'test/src/service/v1/statuses/data/create_status.json',
        ),
      );

      final response = await statusesService.createStatus(
        text: 'Hello, World!',
        poll: StatusPollParam(
          options: ['test1', 'test2'],
          expiresIn: Duration(days: 10),
        ),
      );

      expect(response, isA<KbinResponse>());
      expect(response.rateLimit, isA<RateLimit>());
      expect(response.data, isA<Status>());
      expect(response.data.id, '109384580642337706');
    });

    test('when unauthorized', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildPostStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/statuses',
          'test/src/service/v1/statuses/data/create_status.json',
          statusCode: 401,
        ),
      );

      expectUnauthorizedException(
        () async => await statusesService.createStatus(text: 'Hello, World!'),
      );
    });

    test('when rate limit exceeded', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildPostStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/statuses',
          'test/src/service/v1/statuses/data/create_status.json',
          statusCode: 429,
        ),
      );

      expectRateLimitExceededException(
        () async => await statusesService.createStatus(text: 'Hello, World!'),
      );
    });
  });

  group('.lookupPoll', () {
    test('normal case', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildGetStub(
          'test',
          UserContext.oauth2OrAnonymous,
          '/api/v1/polls/1234',
          'test/src/service/v1/statuses/data/lookup_poll.json',
          {},
        ),
      );

      final response = await statusesService.lookupPoll(
        pollId: '1234',
      );

      expect(response, isA<KbinResponse>());
      expect(response.rateLimit, isA<RateLimit>());
      expect(response.data, isA<Poll>());
    });

    test('when unauthorized', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildGetStub(
          'test',
          UserContext.oauth2OrAnonymous,
          '/api/v1/polls/1234',
          'test/src/service/v1/statuses/data/lookup_poll.json',
          statusCode: 401,
          {},
        ),
      );

      expectUnauthorizedException(
        () async => await statusesService.lookupPoll(
          pollId: '1234',
        ),
      );
    });

    test('when rate limit exceeded', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildGetStub(
          'test',
          UserContext.oauth2OrAnonymous,
          '/api/v1/polls/1234',
          'test/src/service/v1/statuses/data/lookup_poll.json',
          statusCode: 429,
          {},
        ),
      );

      expectRateLimitExceededException(
        () async => await statusesService.lookupPoll(
          pollId: '1234',
        ),
      );
    });
  });

  group('.createVote', () {
    test('normal case', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildPostStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/polls/1234/votes',
          'test/src/service/v1/statuses/data/create_vote.json',
        ),
      );

      final response = await statusesService.createVote(
        pollId: '1234',
        choice: 1,
      );

      expect(response, isA<KbinResponse>());
      expect(response.rateLimit, isA<RateLimit>());
      expect(response.data, isA<Poll>());
    });

    test('when unauthorized', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildPostStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/polls/1234/votes',
          'test/src/service/v1/statuses/data/create_vote.json',
          statusCode: 401,
        ),
      );

      expectUnauthorizedException(
        () async => await statusesService.createVote(
          pollId: '1234',
          choice: 1,
        ),
      );
    });

    test('when rate limit exceeded', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildPostStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/polls/1234/votes',
          'test/src/service/v1/statuses/data/create_vote.json',
          statusCode: 429,
        ),
      );

      expectRateLimitExceededException(
        () async => await statusesService.createVote(
          pollId: '1234',
          choice: 1,
        ),
      );
    });

    test('when parameters are invalid', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildPostStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/polls/1234/votes',
          'test/src/service/v1/statuses/data/create_vote.json',
          statusCode: 422,
        ),
      );

      expect(
        () async => await statusesService.createVote(
          pollId: '1234',
          choice: 1,
        ),
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

  group('.createVotes', () {
    test('normal case', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildPostStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/polls/1234/votes',
          'test/src/service/v1/statuses/data/create_votes.json',
        ),
      );

      final response = await statusesService.createVotes(
        pollId: '1234',
        choices: [1, 2],
      );

      expect(response, isA<KbinResponse>());
      expect(response.rateLimit, isA<RateLimit>());
      expect(response.data, isA<Poll>());
    });

    test('when unauthorized', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildPostStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/polls/1234/votes',
          'test/src/service/v1/statuses/data/create_votes.json',
          statusCode: 401,
        ),
      );

      expectUnauthorizedException(
        () async => await statusesService.createVotes(
          pollId: '1234',
          choices: [1],
        ),
      );
    });

    test('when rate limit exceeded', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildPostStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/polls/1234/votes',
          'test/src/service/v1/statuses/data/create_votes.json',
          statusCode: 429,
        ),
      );

      expectRateLimitExceededException(
        () async => await statusesService.createVotes(
          pollId: '1234',
          choices: [1],
        ),
      );
    });

    test('when parameters are invalid', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildPostStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/polls/1234/votes',
          'test/src/service/v1/statuses/data/create_votes.json',
          statusCode: 422,
        ),
      );

      expect(
        () async => await statusesService.createVotes(
          pollId: '1234',
          choices: [1],
        ),
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

  group('.lookupStatus', () {
    test('normal case', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildGetStub(
          'test',
          UserContext.oauth2OrAnonymous,
          '/api/v1/statuses/1234',
          'test/src/service/v1/statuses/data/lookup_by_id.json',
          {},
        ),
      );

      final response = await statusesService.lookupStatus(
        statusId: '1234',
      );

      expect(response, isA<KbinResponse>());
      expect(response.rateLimit, isA<RateLimit>());
      expect(response.data, isA<Status>());
    });

    test('when unauthorized', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildGetStub(
          'test',
          UserContext.oauth2OrAnonymous,
          '/api/v1/statuses/1234',
          'test/src/service/v1/statuses/data/lookup_by_id.json',
          statusCode: 401,
          {},
        ),
      );

      expectUnauthorizedException(
        () async => await statusesService.lookupStatus(
          statusId: '1234',
        ),
      );
    });

    test('when rate limit exceeded', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildGetStub(
          'test',
          UserContext.oauth2OrAnonymous,
          '/api/v1/statuses/1234',
          'test/src/service/v1/statuses/data/lookup_by_id.json',
          statusCode: 429,
          {},
        ),
      );

      expectRateLimitExceededException(
        () async => await statusesService.lookupStatus(statusId: '1234'),
      );
    });
  });

  group('.lookupStatusContext', () {
    test('normal case', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildGetStub(
          'test',
          UserContext.oauth2OrAnonymous,
          '/api/v1/statuses/1234/context',
          'test/src/service/v1/statuses/data/lookup_status_context.json',
          {},
        ),
      );

      final response = await statusesService.lookupStatusContext(
        statusId: '1234',
      );

      expect(response, isA<KbinResponse>());
      expect(response.rateLimit, isA<RateLimit>());
      expect(response.data, isA<StatusContext>());
    });

    test('when unauthorized', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildGetStub(
          'test',
          UserContext.oauth2OrAnonymous,
          '/api/v1/statuses/1234/context',
          'test/src/service/v1/statuses/data/lookup_status_context.json',
          statusCode: 401,
          {},
        ),
      );

      expectUnauthorizedException(
        () async => await statusesService.lookupStatusContext(
          statusId: '1234',
        ),
      );
    });

    test('when rate limit exceeded', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildGetStub(
          'test',
          UserContext.oauth2OrAnonymous,
          '/api/v1/statuses/1234/context',
          'test/src/service/v1/statuses/data/lookup_status_context.json',
          statusCode: 429,
          {},
        ),
      );

      expectRateLimitExceededException(
        () async => await statusesService.lookupStatusContext(statusId: '1234'),
      );
    });
  });

  group('.lookupRebloggedUsers', () {
    test('normal case', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildGetStub(
          'test',
          UserContext.oauth2OrAnonymous,
          '/api/v1/statuses/1234/reblogged_by',
          'test/src/service/v1/statuses/data/lookup_reblogged_users.json',
          {},
        ),
      );

      final response = await statusesService.lookupRebloggedUsers(
        statusId: '1234',
      );

      expect(response, isA<KbinResponse>());
      expect(response.rateLimit, isA<RateLimit>());
      expect(response.data, isA<List<Account>>());
    });

    test('when unauthorized', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildGetStub(
          'test',
          UserContext.oauth2OrAnonymous,
          '/api/v1/statuses/1234/reblogged_by',
          'test/src/service/v1/statuses/data/lookup_reblogged_users.json',
          statusCode: 401,
          {},
        ),
      );

      expectUnauthorizedException(
        () async => await statusesService.lookupRebloggedUsers(
          statusId: '1234',
        ),
      );
    });

    test('when rate limit exceeded', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildGetStub(
          'test',
          UserContext.oauth2OrAnonymous,
          '/api/v1/statuses/1234/reblogged_by',
          'test/src/service/v1/statuses/data/lookup_reblogged_users.json',
          statusCode: 429,
          {},
        ),
      );

      expectRateLimitExceededException(
        () async =>
            await statusesService.lookupRebloggedUsers(statusId: '1234'),
      );
    });
  });

  group('.lookupFavouritedUsers', () {
    test('normal case', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildGetStub(
          'test',
          UserContext.oauth2OrAnonymous,
          '/api/v1/statuses/1234/favourited_by',
          'test/src/service/v1/statuses/data/lookup_favourited_users.json',
          {},
        ),
      );

      final response = await statusesService.lookupFavouritedUsers(
        statusId: '1234',
      );

      expect(response, isA<KbinResponse>());
      expect(response.rateLimit, isA<RateLimit>());
      expect(response.data, isA<List<Account>>());
    });

    test('when unauthorized', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildGetStub(
          'test',
          UserContext.oauth2OrAnonymous,
          '/api/v1/statuses/1234/favourited_by',
          'test/src/service/v1/statuses/data/lookup_favourited_users.json',
          statusCode: 401,
          {},
        ),
      );

      expectUnauthorizedException(
        () async => await statusesService.lookupFavouritedUsers(
          statusId: '1234',
        ),
      );
    });

    test('when rate limit exceeded', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildGetStub(
          'test',
          UserContext.oauth2OrAnonymous,
          '/api/v1/statuses/1234/favourited_by',
          'test/src/service/v1/statuses/data/lookup_favourited_users.json',
          statusCode: 429,
          {},
        ),
      );

      expectRateLimitExceededException(
        () async =>
            await statusesService.lookupFavouritedUsers(statusId: '1234'),
      );
    });
  });

  group('.createFavourite', () {
    test('normal case', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildPostStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/statuses/1234/favourite',
          'test/src/service/v1/statuses/data/lookup_by_id.json',
        ),
      );

      final response = await statusesService.createFavourite(
        statusId: '1234',
      );

      expect(response, isA<KbinResponse>());
      expect(response.rateLimit, isA<RateLimit>());
      expect(response.data, isA<Status>());
    });

    test('when unauthorized', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildPostStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/statuses/1234/favourite',
          'test/src/service/v1/statuses/data/lookup_by_id.json',
          statusCode: 401,
        ),
      );

      expectUnauthorizedException(
        () async => await statusesService.createFavourite(
          statusId: '1234',
        ),
      );
    });
  });

  group('.destroyFavourite', () {
    test('normal case', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildPostStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/statuses/1234/unfavourite',
          'test/src/service/v1/statuses/data/lookup_by_id.json',
        ),
      );

      final response = await statusesService.destroyFavourite(
        statusId: '1234',
      );

      expect(response, isA<KbinResponse>());
      expect(response.rateLimit, isA<RateLimit>());
      expect(response.data, isA<Status>());
    });

    test('when unauthorized', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildPostStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/statuses/1234/unfavourite',
          'test/src/service/v1/statuses/data/lookup_by_id.json',
          statusCode: 401,
        ),
      );

      expectUnauthorizedException(
        () async => await statusesService.destroyFavourite(
          statusId: '1234',
        ),
      );
    });
  });

  group('.createReblog', () {
    test('normal case', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildPostStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/statuses/1234/reblog',
          'test/src/service/v1/statuses/data/lookup_by_id.json',
        ),
      );

      final response = await statusesService.createReblog(
        statusId: '1234',
      );

      expect(response, isA<KbinResponse>());
      expect(response.rateLimit, isA<RateLimit>());
      expect(response.data, isA<Status>());
    });

    test('when unauthorized', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildPostStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/statuses/1234/reblog',
          'test/src/service/v1/statuses/data/lookup_by_id.json',
          statusCode: 401,
        ),
      );

      expectUnauthorizedException(
        () async => await statusesService.createReblog(
          statusId: '1234',
        ),
      );
    });
  });

  group('.destroyReblog', () {
    test('normal case', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildPostStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/statuses/1234/unreblog',
          'test/src/service/v1/statuses/data/lookup_by_id.json',
        ),
      );

      final response = await statusesService.destroyReblog(
        statusId: '1234',
      );

      expect(response, isA<KbinResponse>());
      expect(response.rateLimit, isA<RateLimit>());
      expect(response.data, isA<Status>());
    });

    test('when unauthorized', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildPostStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/statuses/1234/unreblog',
          'test/src/service/v1/statuses/data/lookup_by_id.json',
          statusCode: 401,
        ),
      );

      expectUnauthorizedException(
        () async => await statusesService.destroyReblog(
          statusId: '1234',
        ),
      );
    });
  });

  group('.createBookmark', () {
    test('normal case', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildPostStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/statuses/1234/bookmark',
          'test/src/service/v1/statuses/data/lookup_by_id.json',
        ),
      );

      final response = await statusesService.createBookmark(
        statusId: '1234',
      );

      expect(response, isA<KbinResponse>());
      expect(response.rateLimit, isA<RateLimit>());
      expect(response.data, isA<Status>());
    });

    test('when unauthorized', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildPostStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/statuses/1234/bookmark',
          'test/src/service/v1/statuses/data/lookup_by_id.json',
          statusCode: 401,
        ),
      );

      expectUnauthorizedException(
        () async => await statusesService.createBookmark(
          statusId: '1234',
        ),
      );
    });
  });

  group('.destroyBookmark', () {
    test('normal case', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildPostStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/statuses/1234/unbookmark',
          'test/src/service/v1/statuses/data/lookup_by_id.json',
        ),
      );

      final response = await statusesService.destroyBookmark(
        statusId: '1234',
      );

      expect(response, isA<KbinResponse>());
      expect(response.rateLimit, isA<RateLimit>());
      expect(response.data, isA<Status>());
    });

    test('when unauthorized', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildPostStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/statuses/1234/unbookmark',
          'test/src/service/v1/statuses/data/lookup_by_id.json',
          statusCode: 401,
        ),
      );

      expectUnauthorizedException(
        () async => await statusesService.destroyBookmark(
          statusId: '1234',
        ),
      );
    });
  });

  group('.createMute', () {
    test('normal case', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildPostStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/statuses/1234/mute',
          'test/src/service/v1/statuses/data/lookup_by_id.json',
        ),
      );

      final response = await statusesService.createMute(
        statusId: '1234',
      );

      expect(response, isA<KbinResponse>());
      expect(response.rateLimit, isA<RateLimit>());
      expect(response.data, isA<Status>());
    });

    test('when unauthorized', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildPostStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/statuses/1234/mute',
          'test/src/service/v1/statuses/data/lookup_by_id.json',
          statusCode: 401,
        ),
      );

      expectUnauthorizedException(
        () async => await statusesService.createMute(
          statusId: '1234',
        ),
      );
    });
  });

  group('.destroyMute', () {
    test('normal case', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildPostStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/statuses/1234/unmute',
          'test/src/service/v1/statuses/data/lookup_by_id.json',
        ),
      );

      final response = await statusesService.destroyMute(
        statusId: '1234',
      );

      expect(response, isA<KbinResponse>());
      expect(response.rateLimit, isA<RateLimit>());
      expect(response.data, isA<Status>());
    });

    test('when unauthorized', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildPostStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/statuses/1234/unmute',
          'test/src/service/v1/statuses/data/lookup_by_id.json',
          statusCode: 401,
        ),
      );

      expectUnauthorizedException(
        () async => await statusesService.destroyMute(
          statusId: '1234',
        ),
      );
    });
  });

  group('.createPinnedStatus', () {
    test('normal case', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildPostStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/statuses/1234/pin',
          'test/src/service/v1/statuses/data/lookup_by_id.json',
        ),
      );

      final response = await statusesService.createPinnedStatus(
        statusId: '1234',
      );

      expect(response, isA<KbinResponse>());
      expect(response.rateLimit, isA<RateLimit>());
      expect(response.data, isA<Status>());
    });

    test('when unauthorized', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildPostStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/statuses/1234/pin',
          'test/src/service/v1/statuses/data/lookup_by_id.json',
          statusCode: 401,
        ),
      );

      expectUnauthorizedException(
        () async => await statusesService.createPinnedStatus(
          statusId: '1234',
        ),
      );
    });
  });

  group('.destroyPinnedStatus', () {
    test('normal case', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildPostStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/statuses/1234/unpin',
          'test/src/service/v1/statuses/data/lookup_by_id.json',
        ),
      );

      final response = await statusesService.destroyPinnedStatus(
        statusId: '1234',
      );

      expect(response, isA<KbinResponse>());
      expect(response.rateLimit, isA<RateLimit>());
      expect(response.data, isA<Status>());
    });

    test('when unauthorized', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildPostStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/statuses/1234/unpin',
          'test/src/service/v1/statuses/data/lookup_by_id.json',
          statusCode: 401,
        ),
      );

      expectUnauthorizedException(
        () async => await statusesService.destroyPinnedStatus(
          statusId: '1234',
        ),
      );
    });
  });

  group('.lookupEditHistory', () {
    test('normal case', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildGetStub(
          'test',
          UserContext.oauth2OrAnonymous,
          '/api/v1/statuses/1234/history',
          'test/src/service/v1/statuses/data/lookup_edit_history.json',
          {},
        ),
      );

      final response = await statusesService.lookupEditHistory(
        statusId: '1234',
      );

      expect(response, isA<KbinResponse>());
      expect(response.rateLimit, isA<RateLimit>());
      expect(response.data, isA<List<StatusEdit>>());
    });

    test('when unauthorized', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildGetStub(
          'test',
          UserContext.oauth2OrAnonymous,
          '/api/v1/statuses/1234/history',
          'test/src/service/v1/statuses/data/lookup_edit_history.json',
          statusCode: 401,
          {},
        ),
      );

      expectUnauthorizedException(
        () async => await statusesService.lookupEditHistory(
          statusId: '1234',
        ),
      );
    });

    test('when rate limit exceeded', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildGetStub(
          'test',
          UserContext.oauth2OrAnonymous,
          '/api/v1/statuses/1234/history',
          'test/src/service/v1/statuses/data/lookup_edit_history.json',
          statusCode: 429,
          {},
        ),
      );

      expectRateLimitExceededException(
        () async => await statusesService.lookupEditHistory(statusId: '1234'),
      );
    });
  });

  group('.lookupEditableSource', () {
    test('normal case', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildGetStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/statuses/1234/source',
          'test/src/service/v1/statuses/data/lookup_editable_source.json',
          {},
        ),
      );

      final response = await statusesService.lookupEditableSource(
        statusId: '1234',
      );

      expect(response, isA<KbinResponse>());
      expect(response.rateLimit, isA<RateLimit>());
      expect(response.data, isA<StatusSource>());
    });

    test('when unauthorized', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildGetStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/statuses/1234/source',
          'test/src/service/v1/statuses/data/lookup_editable_source.json',
          statusCode: 401,
          {},
        ),
      );

      expectUnauthorizedException(
        () async => await statusesService.lookupEditableSource(
          statusId: '1234',
        ),
      );
    });

    test('when rate limit exceeded', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildGetStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/statuses/1234/source',
          'test/src/service/v1/statuses/data/lookup_editable_source.json',
          statusCode: 429,
          {},
        ),
      );

      expectRateLimitExceededException(
        () async =>
            await statusesService.lookupEditableSource(statusId: '1234'),
      );
    });
  });

  group('.createScheduledStatus', () {
    test('normal case', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildPostStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/statuses',
          'test/src/service/v1/statuses/data/create_scheduled_status.json',
        ),
      );

      final response = await statusesService.createScheduledStatus(
        text: 'Hello, World!',
        schedule: DateTime(2023, 03, 01),
        poll: StatusPollParam(
          options: ['test1', 'test2'],
          expiresIn: Duration(days: 10),
        ),
      );

      expect(response, isA<KbinResponse>());
      expect(response.rateLimit, isA<RateLimit>());
      expect(response.data, isA<ScheduledStatus>());
      expect(response.data.id, '3221');
    });

    test('when unauthorized', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildPostStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/statuses',
          'test/src/service/v1/statuses/data/create_scheduled_status.json',
          statusCode: 401,
        ),
      );

      expectUnauthorizedException(
        () async => await statusesService.createScheduledStatus(
          text: 'Hello, World!',
          schedule: DateTime(2023, 03, 01),
        ),
      );
    });

    test('when rate limit exceeded', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildPostStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/statuses',
          'test/src/service/v1/statuses/data/create_scheduled_status.json',
          statusCode: 429,
        ),
      );

      expectRateLimitExceededException(
        () async => await statusesService.createScheduledStatus(
          text: 'Hello, World!',
          schedule: DateTime(2023, 03, 01),
        ),
      );
    });
  });

  group('.lookupScheduledStatus', () {
    test('normal case', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildGetStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/scheduled_statuses/1234',
          'test/src/service/v1/statuses/data/lookup_scheduled_status.json',
          {},
        ),
      );

      final response = await statusesService.lookupScheduledStatus(
        statusId: '1234',
      );

      expect(response, isA<KbinResponse>());
      expect(response.rateLimit, isA<RateLimit>());
      expect(response.data, isA<ScheduledStatus>());
    });

    test('when unauthorized', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildGetStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/scheduled_statuses/1234',
          'test/src/service/v1/statuses/data/lookup_scheduled_status.json',
          statusCode: 401,
          {},
        ),
      );

      expectUnauthorizedException(
        () async => await statusesService.lookupScheduledStatus(
          statusId: '1234',
        ),
      );
    });

    test('when rate limit exceeded', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildGetStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/scheduled_statuses/1234',
          'test/src/service/v1/statuses/data/lookup_scheduled_status.json',
          statusCode: 429,
          {},
        ),
      );

      expectRateLimitExceededException(
        () async =>
            await statusesService.lookupScheduledStatus(statusId: '1234'),
      );
    });
  });

  group('.lookupScheduledStatuses', () {
    test('normal case', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildGetStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/scheduled_statuses',
          'test/src/service/v1/statuses/data/lookup_scheduled_statuses.json',
          {
            'max_id': '1234',
            'min_id': '5678',
            'since_id': '1289',
            'limit': '40',
          },
        ),
      );

      final response = await statusesService.lookupScheduledStatuses(
        maxStatusId: '1234',
        minStatusId: '5678',
        sinceStatusId: '1289',
        limit: 40,
      );

      expect(response, isA<KbinResponse>());
      expect(response.rateLimit, isA<RateLimit>());
      expect(response.data, isA<List<ScheduledStatus>>());
    });

    test('when unauthorized', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildGetStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/scheduled_statuses',
          'test/src/service/v1/statuses/data/lookup_scheduled_statuses.json',
          {
            'max_id': '1234',
            'min_id': '5678',
            'since_id': '1289',
            'limit': '40',
          },
          statusCode: 401,
        ),
      );

      expectUnauthorizedException(
        () async => await statusesService.lookupScheduledStatuses(
          maxStatusId: '1234',
          minStatusId: '5678',
          sinceStatusId: '1289',
          limit: 40,
        ),
      );
    });

    test('when rate limit exceeded', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildGetStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/scheduled_statuses',
          'test/src/service/v1/statuses/data/lookup_scheduled_statuses.json',
          {
            'max_id': '1234',
            'min_id': '5678',
            'since_id': '1289',
            'limit': '40',
          },
          statusCode: 429,
        ),
      );

      expectRateLimitExceededException(
        () async => await statusesService.lookupScheduledStatuses(
          maxStatusId: '1234',
          minStatusId: '5678',
          sinceStatusId: '1289',
          limit: 40,
        ),
      );
    });
  });

  group('.destroyScheduledStatus', () {
    test('normal case', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildDeleteStub(
          'test',
          '/api/v1/scheduled_statuses/1234',
          'test/src/service/v1/statuses/data/destroy_scheduled_status.json',
        ),
      );

      final response = await statusesService.destroyScheduledStatus(
        statusId: '1234',
      );

      expect(response, isA<KbinResponse>());
      expect(response.rateLimit, isA<RateLimit>());
      expect(response.data, isA<Empty>());
    });

    test('when unauthorized', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildDeleteStub(
          'test',
          '/api/v1/scheduled_statuses/1234',
          'test/src/service/v1/statuses/data/destroy_scheduled_status.json',
          statusCode: 401,
        ),
      );

      expectUnauthorizedException(
        () async => await statusesService.destroyScheduledStatus(
          statusId: '1234',
        ),
      );
    });

    test('when rate limit exceeded', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildDeleteStub(
          'test',
          '/api/v1/scheduled_statuses/1234',
          'test/src/service/v1/statuses/data/destroy_scheduled_status.json',
          statusCode: 429,
        ),
      );

      expectRateLimitExceededException(
        () async =>
            await statusesService.destroyScheduledStatus(statusId: '1234'),
      );
    });
  });

  group('.updateScheduledStatus', () {
    test('normal case', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildPutStub(
          'test',
          '/api/v1/scheduled_statuses/1234',
          'test/src/service/v1/statuses/data/update_scheduled_status.json',
        ),
      );

      final response = await statusesService.updateScheduledStatus(
        statusId: '1234',
        schedule: DateTime(2023, 3, 1),
      );

      expect(response, isA<KbinResponse>());
      expect(response.rateLimit, isA<RateLimit>());
      expect(response.data, isA<ScheduledStatus>());
    });

    test('when unauthorized', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildPutStub(
          'test',
          '/api/v1/scheduled_statuses/1234',
          'test/src/service/v1/statuses/data/update_scheduled_status.json',
          statusCode: 401,
        ),
      );

      expectUnauthorizedException(
        () async => await statusesService.updateScheduledStatus(
          statusId: '1234',
          schedule: DateTime(2023, 3, 1),
        ),
      );
    });

    test('when rate limit exceeded', () async {
      final statusesService = StatusesV1Service(
        instance: 'test',
        context: context.buildPutStub(
          'test',
          '/api/v1/scheduled_statuses/1234',
          'test/src/service/v1/statuses/data/update_scheduled_status.json',
          statusCode: 429,
        ),
      );

      expectRateLimitExceededException(
        () async => await statusesService.updateScheduledStatus(
          statusId: '1234',
          schedule: DateTime(2023, 3, 1),
        ),
      );
    });
  });
}
