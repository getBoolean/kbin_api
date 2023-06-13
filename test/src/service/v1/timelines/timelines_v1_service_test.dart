// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// 🌎 Project imports:
import 'package:kbin_api/src/core/client/user_context.dart';
import 'package:kbin_api/src/service/entities/conversation.dart';
import 'package:kbin_api/src/service/entities/empty.dart';
import 'package:kbin_api/src/service/entities/notification_snapshot.dart';
import 'package:kbin_api/src/service/entities/rate_limit.dart';
import 'package:kbin_api/src/service/entities/status.dart';
import 'package:kbin_api/src/service/entities/status_snapshot.dart';
import 'package:kbin_api/src/service/response/kbin_response.dart';
import 'package:kbin_api/src/service/v1/timelines/timelines_v1_service.dart';
// 📦 Package imports:
import 'package:test/test.dart';

import '../../../../mocks/client_context_stubs.dart' as context;
import '../../common_expectations.dart';

void main() {
  group('.lookupPublicTimelines', () {
    test('when user is authorized', () async {
      final timelinesService = TimelinesV1Service(
        instance: 'test',
        context: context.buildGetStub(
          'test',
          UserContext.oauth2OrAnonymous,
          '/api/v1/timelines/public',
          'test/src/service/v1/timelines/data/lookup_timelines.json',
          {
            'local': 'true',
            'remote': 'true',
            'only_media': 'true',
            'max_id': '1234',
            'min_id': '5678',
            'since_id': '0987',
            'limit': '40',
          },
        ),
      );

      final response = await timelinesService.lookupPublicTimeline(
        onlyLocal: true,
        onlyRemote: true,
        onlyMedia: true,
        maxStatusId: '1234',
        minStatusId: '5678',
        sinceStatusId: '0987',
        limit: 40,
      );

      expect(response, isA<KbinResponse>());
      expect(response.rateLimit, isA<RateLimit>());
      expect(response.data, isA<List<Status>>());
    });

    test('when user is anonymous', () async {
      final timelinesService = TimelinesV1Service(
        instance: 'test',
        context: context.buildGetStub(
          'test',
          UserContext.oauth2OrAnonymous,
          '/api/v1/timelines/public',
          'test/src/service/v1/timelines/data/lookup_timelines_anonymous.json',
          {
            'local': 'true',
            'remote': 'true',
            'only_media': 'true',
            'max_id': '1234',
            'min_id': '5678',
            'since_id': '0987',
            'limit': '40',
          },
        ),
      );

      final response = await timelinesService.lookupPublicTimeline(
        onlyLocal: true,
        onlyRemote: true,
        onlyMedia: true,
        maxStatusId: '1234',
        minStatusId: '5678',
        sinceStatusId: '0987',
        limit: 40,
      );

      expect(response, isA<KbinResponse>());
      expect(response.rateLimit, isA<RateLimit>());
      expect(response.data, isA<List<Status>>());
    });

    test('when unauthorized', () async {
      final timelinesService = TimelinesV1Service(
        instance: 'test',
        context: context.buildGetStub(
          'test',
          UserContext.oauth2OrAnonymous,
          '/api/v1/timelines/public',
          'test/src/service/v1/timelines/data/lookup_timelines.json',
          {},
          statusCode: 401,
        ),
      );

      expectUnauthorizedException(
        () async => await timelinesService.lookupPublicTimeline(),
      );
    });

    test('when rate limit exceeded', () async {
      final timelinesService = TimelinesV1Service(
        instance: 'test',
        context: context.buildGetStub(
          'test',
          UserContext.oauth2OrAnonymous,
          '/api/v1/timelines/public',
          'test/src/service/v1/timelines/data/lookup_timelines.json',
          {},
          statusCode: 429,
        ),
      );

      expectRateLimitExceededException(
        () async => await timelinesService.lookupPublicTimeline(),
      );
    });

    test('when no data', () async {
      final timelinesService = TimelinesV1Service(
        instance: 'test',
        context: context.buildGetStub(
          'test',
          UserContext.oauth2OrAnonymous,
          '/api/v1/timelines/public',
          'test/src/service/v1/timelines/data/no_data.json',
          {
            'local': 'true',
            'remote': 'true',
            'only_media': 'true',
            'max_id': '1234',
            'min_id': '5678',
            'since_id': '0987',
            'limit': '40',
          },
        ),
      );

      final response = await timelinesService.lookupPublicTimeline(
        onlyLocal: true,
        onlyRemote: true,
        onlyMedia: true,
        maxStatusId: '1234',
        minStatusId: '5678',
        sinceStatusId: '0987',
        limit: 40,
      );

      expect(response, isA<KbinResponse>());
      expect(response.rateLimit, isA<RateLimit>());
      expect(response.data, isA<List<Status>>());
      expect(response.data, []);
    });
  });

  group('.lookupTimelinesByHashtag', () {
    test('when user is authorized', () async {
      final timelinesService = TimelinesV1Service(
        instance: 'test',
        context: context.buildGetStub(
          'test',
          UserContext.oauth2OrAnonymous,
          '/api/v1/timelines/tag/test',
          'test/src/service/v1/timelines/data/lookup_timelines.json',
          {
            'local': 'true',
            'remote': 'true',
            'only_media': 'true',
            'max_id': '1234',
            'min_id': '5678',
            'since_id': '0987',
            'limit': '40',
          },
        ),
      );

      final response = await timelinesService.lookupTimelineByHashtag(
        hashtag: 'test',
        onlyLocal: true,
        onlyRemote: true,
        onlyMedia: true,
        maxStatusId: '1234',
        minStatusId: '5678',
        sinceStatusId: '0987',
        limit: 40,
      );

      expect(response, isA<KbinResponse>());
      expect(response.rateLimit, isA<RateLimit>());
      expect(response.data, isA<List<Status>>());
    });

    test('when user is anonymous', () async {
      final timelinesService = TimelinesV1Service(
        instance: 'test',
        context: context.buildGetStub(
          'test',
          UserContext.oauth2OrAnonymous,
          '/api/v1/timelines/tag/test',
          'test/src/service/v1/timelines/data/lookup_timelines_anonymous.json',
          {
            'local': 'true',
            'remote': 'true',
            'only_media': 'true',
            'max_id': '1234',
            'min_id': '5678',
            'since_id': '0987',
            'limit': '40',
          },
        ),
      );

      final response = await timelinesService.lookupTimelineByHashtag(
        hashtag: 'test',
        onlyLocal: true,
        onlyRemote: true,
        onlyMedia: true,
        maxStatusId: '1234',
        minStatusId: '5678',
        sinceStatusId: '0987',
        limit: 40,
      );

      expect(response, isA<KbinResponse>());
      expect(response.rateLimit, isA<RateLimit>());
      expect(response.data, isA<List<Status>>());
    });

    test('when unauthorized', () async {
      final timelinesService = TimelinesV1Service(
        instance: 'test',
        context: context.buildGetStub(
          'test',
          UserContext.oauth2OrAnonymous,
          '/api/v1/timelines/tag/test',
          'test/src/service/v1/timelines/data/lookup_timelines.json',
          {},
          statusCode: 401,
        ),
      );

      expectUnauthorizedException(
        () async => await timelinesService.lookupTimelineByHashtag(
          hashtag: 'test',
        ),
      );
    });

    test('when rate limit exceeded', () async {
      final timelinesService = TimelinesV1Service(
        instance: 'test',
        context: context.buildGetStub(
          'test',
          UserContext.oauth2OrAnonymous,
          '/api/v1/timelines/tag/test',
          'test/src/service/v1/timelines/data/lookup_timelines.json',
          {},
          statusCode: 429,
        ),
      );

      expectRateLimitExceededException(
        () async => await timelinesService.lookupTimelineByHashtag(
          hashtag: 'test',
        ),
      );
    });

    test('when no data', () async {
      final timelinesService = TimelinesV1Service(
        instance: 'test',
        context: context.buildGetStub(
          'test',
          UserContext.oauth2OrAnonymous,
          '/api/v1/timelines/tag/test',
          'test/src/service/v1/timelines/data/no_data.json',
          {
            'local': 'true',
            'remote': 'true',
            'only_media': 'true',
            'max_id': '1234',
            'min_id': '5678',
            'since_id': '0987',
            'limit': '40',
          },
        ),
      );

      final response = await timelinesService.lookupTimelineByHashtag(
        hashtag: 'test',
        onlyLocal: true,
        onlyRemote: true,
        onlyMedia: true,
        maxStatusId: '1234',
        minStatusId: '5678',
        sinceStatusId: '0987',
        limit: 40,
      );

      expect(response, isA<KbinResponse>());
      expect(response.rateLimit, isA<RateLimit>());
      expect(response.data, isA<List<Status>>());
      expect(response.data, []);
    });
  });

  group('.lookupHomeTimelines', () {
    test('when user is authorized', () async {
      final timelinesService = TimelinesV1Service(
        instance: 'test',
        context: context.buildGetStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/timelines/home',
          'test/src/service/v1/timelines/data/lookup_timelines.json',
          {
            'max_id': '1234',
            'min_id': '5678',
            'since_id': '0987',
            'limit': '40',
          },
        ),
      );

      final response = await timelinesService.lookupHomeTimeline(
        maxStatusId: '1234',
        minStatusId: '5678',
        sinceStatusId: '0987',
        limit: 40,
      );

      expect(response, isA<KbinResponse>());
      expect(response.rateLimit, isA<RateLimit>());
      expect(response.data, isA<List<Status>>());
    });

    test('when unauthorized', () async {
      final timelinesService = TimelinesV1Service(
        instance: 'test',
        context: context.buildGetStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/timelines/home',
          'test/src/service/v1/timelines/data/lookup_timelines.json',
          {},
          statusCode: 401,
        ),
      );

      expectUnauthorizedException(
        () async => await timelinesService.lookupHomeTimeline(),
      );
    });

    test('when rate limit exceeded', () async {
      final timelinesService = TimelinesV1Service(
        instance: 'test',
        context: context.buildGetStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/timelines/home',
          'test/src/service/v1/timelines/data/lookup_timelines.json',
          {},
          statusCode: 429,
        ),
      );

      expectRateLimitExceededException(
        () async => await timelinesService.lookupHomeTimeline(),
      );
    });

    test('when no data', () async {
      final timelinesService = TimelinesV1Service(
        instance: 'test',
        context: context.buildGetStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/timelines/home',
          'test/src/service/v1/timelines/data/no_data.json',
          {
            'max_id': '1234',
            'min_id': '5678',
            'since_id': '0987',
            'limit': '40',
          },
        ),
      );

      final response = await timelinesService.lookupHomeTimeline(
        maxStatusId: '1234',
        minStatusId: '5678',
        sinceStatusId: '0987',
        limit: 40,
      );

      expect(response, isA<KbinResponse>());
      expect(response.rateLimit, isA<RateLimit>());
      expect(response.data, isA<List<Status>>());
      expect(response.data, []);
    });
  });

  group('.lookupListTimelines', () {
    test('when user is authorized', () async {
      final timelinesService = TimelinesV1Service(
        instance: 'test',
        context: context.buildGetStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/timelines/list/1234',
          'test/src/service/v1/timelines/data/lookup_timelines.json',
          {
            'max_id': '1234',
            'min_id': '5678',
            'since_id': '0987',
            'limit': '40',
          },
        ),
      );

      final response = await timelinesService.lookupListTimeline(
        listId: '1234',
        maxStatusId: '1234',
        minStatusId: '5678',
        sinceStatusId: '0987',
        limit: 40,
      );

      expect(response, isA<KbinResponse>());
      expect(response.rateLimit, isA<RateLimit>());
      expect(response.data, isA<List<Status>>());
    });

    test('when unauthorized', () async {
      final timelinesService = TimelinesV1Service(
        instance: 'test',
        context: context.buildGetStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/timelines/list/1234',
          'test/src/service/v1/timelines/data/lookup_timelines.json',
          {},
          statusCode: 401,
        ),
      );

      expectUnauthorizedException(
        () async => await timelinesService.lookupListTimeline(listId: '1234'),
      );
    });

    test('when rate limit exceeded', () async {
      final timelinesService = TimelinesV1Service(
        instance: 'test',
        context: context.buildGetStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/timelines/list/1234',
          'test/src/service/v1/timelines/data/lookup_timelines.json',
          {},
          statusCode: 429,
        ),
      );

      expectRateLimitExceededException(
        () async => await timelinesService.lookupListTimeline(listId: '1234'),
      );
    });

    test('when no data', () async {
      final timelinesService = TimelinesV1Service(
        instance: 'test',
        context: context.buildGetStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/timelines/list/1234',
          'test/src/service/v1/timelines/data/no_data.json',
          {
            'max_id': '1234',
            'min_id': '5678',
            'since_id': '0987',
            'limit': '40',
          },
        ),
      );

      final response = await timelinesService.lookupListTimeline(
        listId: '1234',
        maxStatusId: '1234',
        minStatusId: '5678',
        sinceStatusId: '0987',
        limit: 40,
      );

      expect(response, isA<KbinResponse>());
      expect(response.rateLimit, isA<RateLimit>());
      expect(response.data, isA<List<Status>>());
      expect(response.data, []);
    });
  });

  group('.lookupConversations', () {
    test('normal case', () async {
      final timelinesService = TimelinesV1Service(
        instance: 'test',
        context: context.buildGetStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/conversations',
          'test/src/service/v1/timelines/data/lookup_conversations.json',
          {
            'limit': '10',
          },
        ),
      );

      final response = await timelinesService.lookupConversations(limit: 10);

      expect(response, isA<KbinResponse>());
      expect(response.rateLimit, isA<RateLimit>());
      expect(response.data, isA<List<Conversation>>());
    });

    test('when unauthorized', () async {
      final timelinesService = TimelinesV1Service(
        instance: 'test',
        context: context.buildGetStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/conversations',
          'test/src/service/v1/timelines/data/lookup_conversations.json',
          {
            'limit': '10',
          },
          statusCode: 401,
        ),
      );

      expectUnauthorizedException(
        () async => await timelinesService.lookupConversations(limit: 10),
      );
    });

    test('when rate limit exceeded', () async {
      final timelinesService = TimelinesV1Service(
        instance: 'test',
        context: context.buildGetStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/conversations',
          'test/src/service/v1/timelines/data/lookup_conversations.json',
          {
            'limit': '10',
          },
          statusCode: 429,
        ),
      );

      expectRateLimitExceededException(
        () async => await timelinesService.lookupConversations(limit: 10),
      );
    });
  });

  group('.destroyConversation', () {
    test('normal case', () async {
      final timelinesService = TimelinesV1Service(
        instance: 'test',
        context: context.buildDeleteStub(
          'test',
          '/api/v1/conversations/1234',
          'test/src/service/v1/timelines/data/destroy_conversation.json',
        ),
      );

      final response = await timelinesService.destroyConversation(
        conversationId: '1234',
      );

      expect(response, isA<KbinResponse>());
      expect(response.rateLimit, isA<RateLimit>());
      expect(response.data, isA<Empty>());
    });

    test('when unauthorized', () async {
      final timelinesService = TimelinesV1Service(
        instance: 'test',
        context: context.buildDeleteStub(
          'test',
          '/api/v1/conversations/1234',
          'test/src/service/v1/timelines/data/destroy_conversation.json',
          statusCode: 401,
        ),
      );

      expectUnauthorizedException(
        () async => await timelinesService.destroyConversation(
          conversationId: '1234',
        ),
      );
    });

    test('when rate limit exceeded', () async {
      final timelinesService = TimelinesV1Service(
        instance: 'test',
        context: context.buildDeleteStub(
          'test',
          '/api/v1/conversations/1234',
          'test/src/service/v1/timelines/data/destroy_conversation.json',
          statusCode: 429,
        ),
      );

      expectRateLimitExceededException(
        () async => await timelinesService.destroyConversation(
          conversationId: '1234',
        ),
      );
    });
  });

  group('.createMarkConversationAsRead', () {
    test('normal case', () async {
      final timelinesService = TimelinesV1Service(
        instance: 'test',
        context: context.buildPostStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/conversations/1234/read',
          'test/src/service/v1/timelines/data/create_mark_conversation_as_read.json',
        ),
      );

      final response = await timelinesService.createMarkConversationAsRead(
        conversationId: '1234',
      );

      expect(response, isA<KbinResponse>());
      expect(response.rateLimit, isA<RateLimit>());
      expect(response.data, isA<Conversation>());
    });

    test('when unauthorized', () async {
      final timelinesService = TimelinesV1Service(
        instance: 'test',
        context: context.buildPostStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/conversations/1234/read',
          'test/src/service/v1/timelines/data/create_mark_conversation_as_read.json',
          statusCode: 401,
        ),
      );

      expectUnauthorizedException(
        () async => await timelinesService.createMarkConversationAsRead(
          conversationId: '1234',
        ),
      );
    });

    test('when rate limit exceeded', () async {
      final timelinesService = TimelinesV1Service(
        instance: 'test',
        context: context.buildPostStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/conversations/1234/read',
          'test/src/service/v1/timelines/data/create_mark_conversation_as_read.json',
          statusCode: 429,
        ),
      );

      expectRateLimitExceededException(
        () async => await timelinesService.createMarkConversationAsRead(
          conversationId: '1234',
        ),
      );
    });
  });

  group('.lookupStatusSnapshot', () {
    test('normal case', () async {
      final timelinesService = TimelinesV1Service(
        instance: 'test',
        context: context.buildGetStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/markers',
          'test/src/service/v1/timelines/data/lookup_status_snapshot.json',
          {
            'timeline[]': 'home',
          },
        ),
      );

      final response = await timelinesService.lookupStatusSnapshot();

      expect(response, isA<KbinResponse>());
      expect(response.rateLimit, isA<RateLimit>());
      expect(response.data, isA<StatusSnapshot>());
    });

    test('when unauthorized', () async {
      final timelinesService = TimelinesV1Service(
        instance: 'test',
        context: context.buildGetStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/markers',
          'test/src/service/v1/timelines/data/lookup_status_snapshot.json',
          {
            'timeline[]': 'home',
          },
          statusCode: 401,
        ),
      );

      expectUnauthorizedException(
        () async => await timelinesService.lookupStatusSnapshot(),
      );
    });

    test('when rate limit exceeded', () async {
      final timelinesService = TimelinesV1Service(
        instance: 'test',
        context: context.buildGetStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/markers',
          'test/src/service/v1/timelines/data/lookup_status_snapshot.json',
          {
            'timeline[]': 'home',
          },
          statusCode: 429,
        ),
      );

      expectRateLimitExceededException(
        () async => await timelinesService.lookupStatusSnapshot(),
      );
    });
  });

  group('.lookupNotificationSnapshot', () {
    test('normal case', () async {
      final timelinesService = TimelinesV1Service(
        instance: 'test',
        context: context.buildGetStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/markers',
          'test/src/service/v1/timelines/data/lookup_notification_snapshot.json',
          {
            'timeline[]': 'notifications',
          },
        ),
      );

      final response = await timelinesService.lookupNotificationSnapshot();

      expect(response, isA<KbinResponse>());
      expect(response.rateLimit, isA<RateLimit>());
      expect(response.data, isA<NotificationSnapshot>());
    });

    test('when unauthorized', () async {
      final timelinesService = TimelinesV1Service(
        instance: 'test',
        context: context.buildGetStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/markers',
          'test/src/service/v1/timelines/data/lookup_notification_snapshot.json',
          {
            'timeline[]': 'notifications',
          },
          statusCode: 401,
        ),
      );

      expectUnauthorizedException(
        () async => await timelinesService.lookupNotificationSnapshot(),
      );
    });

    test('when rate limit exceeded', () async {
      final timelinesService = TimelinesV1Service(
        instance: 'test',
        context: context.buildGetStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/markers',
          'test/src/service/v1/timelines/data/lookup_notification_snapshot.json',
          {
            'timeline[]': 'notifications',
          },
          statusCode: 429,
        ),
      );

      expectRateLimitExceededException(
        () async => await timelinesService.lookupNotificationSnapshot(),
      );
    });
  });

  group('.createStatusSnapshot', () {
    test('normal case', () async {
      final timelinesService = TimelinesV1Service(
        instance: 'test',
        context: context.buildPostStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/markers',
          'test/src/service/v1/timelines/data/create_status_snapshot.json',
        ),
      );

      final response = await timelinesService.createStatusSnapshot(
        statusId: '1234',
      );

      expect(response, isA<KbinResponse>());
      expect(response.rateLimit, isA<RateLimit>());
      expect(response.data, isA<StatusSnapshot>());
    });

    test('when unauthorized', () async {
      final timelinesService = TimelinesV1Service(
        instance: 'test',
        context: context.buildPostStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/markers',
          'test/src/service/v1/timelines/data/create_status_snapshot.json',
          statusCode: 401,
        ),
      );

      expectUnauthorizedException(
        () async => await timelinesService.createStatusSnapshot(
          statusId: '1234',
        ),
      );
    });

    test('when rate limit exceeded', () async {
      final timelinesService = TimelinesV1Service(
        instance: 'test',
        context: context.buildPostStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/markers',
          'test/src/service/v1/timelines/data/create_status_snapshot.json',
          statusCode: 429,
        ),
      );

      expectRateLimitExceededException(
        () async => await timelinesService.createStatusSnapshot(
          statusId: '1234',
        ),
      );
    });
  });

  group('.createNotificationsSnapshot', () {
    test('normal case', () async {
      final timelinesService = TimelinesV1Service(
        instance: 'test',
        context: context.buildPostStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/markers',
          'test/src/service/v1/timelines/data/create_notification_snapshot.json',
        ),
      );

      final response = await timelinesService.createNotificationSnapshot(
        notificationId: '1234',
      );

      expect(response, isA<KbinResponse>());
      expect(response.rateLimit, isA<RateLimit>());
      expect(response.data, isA<NotificationSnapshot>());
    });

    test('when unauthorized', () async {
      final timelinesService = TimelinesV1Service(
        instance: 'test',
        context: context.buildPostStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/markers',
          'test/src/service/v1/timelines/data/create_notification_snapshot.json',
          statusCode: 401,
        ),
      );

      expectUnauthorizedException(
        () async => await timelinesService.createNotificationSnapshot(
          notificationId: '1234',
        ),
      );
    });

    test('when rate limit exceeded', () async {
      final timelinesService = TimelinesV1Service(
        instance: 'test',
        context: context.buildPostStub(
          'test',
          UserContext.oauth2Only,
          '/api/v1/markers',
          'test/src/service/v1/timelines/data/create_notification_snapshot.json',
          statusCode: 429,
        ),
      );

      expectRateLimitExceededException(
        () async => await timelinesService.createNotificationSnapshot(
          notificationId: '1234',
        ),
      );
    });
  });
}
