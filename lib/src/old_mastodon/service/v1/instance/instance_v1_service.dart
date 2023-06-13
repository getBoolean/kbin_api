// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// 🌎 Project imports:
import '../../../../core/client/client_context.dart';
import '../../../../core/client/user_context.dart';
import '../../base_service.dart';
import '../../entities/account.dart';
import '../../entities/announcement.dart';
import '../../entities/blocked_domain.dart';
import '../../entities/emoji.dart';
import '../../entities/empty.dart';
import '../../entities/extended_description.dart';
import '../../entities/instance.dart';
import '../../entities/instance_activity.dart';
import '../../entities/rule.dart';
import '../../entities/status.dart';
import '../../entities/tag.dart';
import '../../entities/trends_link.dart';
import '../../response/kbin_response.dart';
import 'instance_account_order.dart';

abstract class InstanceV1Service {
  /// Returns the new instance of [InstanceV1Service].
  factory InstanceV1Service({
    required String instance,
    required ClientContext context,
  }) =>
      _InstanceV1Service(
        instance: instance,
        context: context,
      );

  /// Obtain general information about the server.
  ///
  /// ## Endpoint Url
  ///
  /// - GET /api/v1/instance HTTP/1.1
  ///
  /// ## Authentication Methods
  ///
  /// - Anonymous
  /// - OAuth 2.0
  ///
  /// ## Reference
  ///
  /// - https://docs.joinmastodon.org/methods/instance/#v1
  @Deprecated('Still works, but officially deprecated. Use v2 endpoint instead')
  Future<KbinResponse<Instance>> lookupInformation();

  /// Domains that this instance is aware of.
  ///
  /// ## Endpoint Url
  ///
  /// - GET /api/v1/instance/peers HTTP/1.1
  ///
  /// ## Authentication Methods
  ///
  /// - Anonymous
  ///
  /// ## Reference
  ///
  /// - https://docs.joinmastodon.org/methods/instance/#peers
  Future<KbinResponse<List<String>>> lookupConnectedDomains();

  /// Instance activity over the last 3 months, binned weekly.
  ///
  /// ## Endpoint Url
  ///
  /// - GET /api/v1/instance/activity HTTP/1.1
  ///
  /// ## Authentication Methods
  ///
  /// - Anonymous
  /// - Oauth 2.0
  ///
  /// ## Reference
  ///
  /// - https://docs.joinmastodon.org/methods/instance/#activity
  Future<KbinResponse<List<InstanceActivity>>> lookupWeeklyActivities();

  /// Rules that the users of this service should follow.
  ///
  /// ## Endpoint Url
  ///
  /// - GET /api/v1/instance/rules HTTP/1.1
  ///
  /// ## Authentication Methods
  ///
  /// - Anonymous
  /// - Oauth 2.0
  ///
  /// ## Reference
  ///
  /// - https://docs.joinmastodon.org/methods/instance/#rules
  Future<KbinResponse<List<Rule>>> lookupRules();

  /// Obtain a list of domains that have been blocked.
  ///
  /// ## Endpoint Url
  ///
  /// - GET /api/v1/instance/domain_block HTTP/1.1
  ///
  /// ## Authentication Methods
  ///
  /// - Anonymous
  /// - Oauth 2.0
  ///
  /// ## Reference
  ///
  /// - https://docs.joinmastodon.org/methods/instance/#domain_blocks
  Future<KbinResponse<List<BlockedDomain>>> lookupBlockedDomains();

  /// Obtain an extended description of this server
  ///
  /// ## Endpoint Url
  ///
  /// - GET /api/v1/example HTTP/1.1
  ///
  /// ## Authentication Methods
  ///
  /// - Anonymous
  ///
  /// ## Reference
  ///
  /// - https://docs.joinmastodon.org/methods/instance/#extended_description
  Future<KbinResponse<ExtendedDescription>> lookupExtendedDescription();

  /// Tags that are being used more frequently within the past week.
  ///
  /// ## Parameters
  ///
  /// - [limit]: Maximum number of results to return. Defaults to 10.
  ///
  /// ## Endpoint Url
  ///
  /// - GET /api/v1/trends/tags HTTP/1.1
  ///
  /// ## Authentication Methods
  ///
  /// - Anonymous
  ///
  /// ## Reference
  ///
  /// - https://docs.joinmastodon.org/methods/trends/#tags
  Future<KbinResponse<List<Tag>>> lookupTrendingTags({
    int? limit,
  });

  /// Statuses that have been interacted with more than others.
  ///
  /// ## Parameters
  ///
  /// - [limit]: Maximum number of results to return. Defaults to 10.
  ///
  /// ## Endpoint Url
  ///
  /// - GET /api/v1/trends/statuses HTTP/1.1
  ///
  /// ## Authentication Methods
  ///
  /// - Anonymous
  ///
  /// ## Reference
  ///
  /// - https://docs.joinmastodon.org/methods/trends/#statuses
  Future<KbinResponse<List<Status>>> lookupTrendingStatuses({
    int? limit,
  });

  /// Links that have been shared more than others.
  ///
  /// ## Parameters
  ///
  /// - [limit]: Maximum number of results to return. Defaults to 10.
  ///
  /// ## Endpoint Url
  ///
  /// - GET /api/v1/trends/links HTTP/1.1
  ///
  /// ## Authentication Methods
  ///
  /// - Anonymous
  ///
  /// ## Reference
  ///
  /// - https://docs.joinmastodon.org/methods/trends/#links
  Future<KbinResponse<List<TrendsLink>>> lookupTrendingLinks({
    int? limit,
  });

  /// See all currently active announcements set by admins.
  ///
  /// ## Endpoint Url
  ///
  /// - GET /api/v1/announcements HTTP/1.1
  ///
  /// ## Authentication Methods
  ///
  /// - OAuth 2.0
  ///
  /// ## Reference
  ///
  /// - https://docs.joinmastodon.org/methods/announcements/#get
  Future<KbinResponse<List<Announcement>>> lookupActiveAnnouncements();

  /// See all announcements set by admins.
  ///
  /// ## Endpoint Url
  ///
  /// - GET /api/v1/announcements HTTP/1.1
  ///
  /// ## Authentication Methods
  ///
  /// - OAuth 2.0
  ///
  /// ## Reference
  ///
  /// - https://docs.joinmastodon.org/methods/announcements/#get
  Future<KbinResponse<List<Announcement>>> lookupAnnouncements();

  /// Allows a user to mark the announcement as read.
  ///
  /// ## Parameters
  ///
  /// - [announcementId]: The ID of the Announcement in the database.
  ///
  /// ## Endpoint Url
  ///
  /// - POST /api/v1/announcements/:id/dismiss HTTP/1.1
  ///
  /// ## Authentication Methods
  ///
  /// - OAuth 2.0
  ///
  /// ## Required Scopes
  ///
  /// - write:accounts
  ///
  /// ## Reference
  ///
  /// - https://docs.joinmastodon.org/methods/announcements/#dismiss
  Future<KbinResponse<Empty>> createMarkAnnouncementAsRead({
    required String announcementId,
  });

  /// React to an announcement with an emoji.
  ///
  /// ## Parameters
  ///
  /// - [announcementId]: The ID of the Announcement in the database.
  ///
  /// - [emojiName]: Unicode emoji, or the shortcode of a custom emoji.
  ///
  /// ## Endpoint Url
  ///
  /// - PUT /api/v1/announcements/:id/reactions/:name HTTP/1.1
  ///
  /// ## Authentication Methods
  ///
  /// - OAuth 2.0
  ///
  /// ## Required Scopes
  ///
  /// - write:favourites
  ///
  /// ## Reference
  ///
  /// - https://docs.joinmastodon.org/methods/announcements/#put-reactions
  Future<KbinResponse<Empty>> createReactionToAnnouncement({
    required String announcementId,
    required String emojiName,
  });

  /// Undo a react emoji to an announcement.
  ///
  /// ## Parameters
  ///
  /// - [announcementId]: The ID of the Announcement in the database.
  ///
  /// - [emojiName]: Unicode emoji, or the shortcode of a custom emoji.
  ///
  /// ## Endpoint Url
  ///
  /// - DELETE /api/v1/announcements/:id/reactions/:name HTTP/1.1
  ///
  /// ## Authentication Methods
  ///
  /// - OAuth 2.0
  ///
  /// ## Required Scopes
  ///
  /// - write:favourites
  ///
  /// ## Reference
  ///
  /// - https://docs.joinmastodon.org/methods/announcements/#delete-reactions
  Future<KbinResponse<Empty>> destroyReactionToAnnouncement({
    required String announcementId,
    required String emojiName,
  });

  /// Returns custom emojis that are available on the server.
  ///
  /// ## Endpoint Url
  ///
  /// - GET /api/v1/custom_emojis HTTP/1.1
  ///
  /// ## Authentication Methods
  ///
  /// - Anonymous
  ///
  /// ## Reference
  ///
  /// - https://docs.joinmastodon.org/methods/custom_emojis/#get
  Future<KbinResponse<List<Emoji>>> lookupAvailableEmoji();

  /// List accounts visible in the directory.
  ///
  /// ## Parameters
  ///
  /// - [offset]: Skip the first n results.
  ///
  /// - [limit]: How many accounts to load. Defaults to 40 accounts.
  ///            Max 80 accounts.
  ///
  /// - [order]:  Use active to sort by most recently posted statuses (default)
  ///             or new to sort by most recently created profiles.
  ///
  /// - [onlyLocal]: If true, returns only local accounts.
  ///
  /// ## Endpoint Url
  ///
  /// - GET /api/v1/directory HTTP/1.1
  ///
  /// ## Authentication Methods
  ///
  /// - Anonymous
  ///
  /// ## Reference
  ///
  /// - https://docs.joinmastodon.org/methods/directory/#get
  Future<KbinResponse<List<Account>>> lookupAccounts({
    int? offset,
    int? limit,
    InstanceAccountOrder? order,
    bool? onlyLocal,
  });
}

class _InstanceV1Service extends BaseService implements InstanceV1Service {
  /// Returns the new instance of [_InstanceV1Service].
  _InstanceV1Service({
    required super.instance,
    required super.context,
  });

  @override
  Future<KbinResponse<Instance>> lookupInformation() async =>
      super.transformSingleDataResponse(
        await super.get(
          UserContext.oauth2OrAnonymous,
          '/api/v1/instance',
        ),
        dataBuilder: Instance.fromJson,
      );

  @override
  Future<KbinResponse<List<String>>> lookupConnectedDomains() async =>
      super.transformMultiRawDataResponse<String>(
        await super.get(
          UserContext.anonymousOnly,
          '/api/v1/instance/peers',
        ),
      );

  @override
  Future<KbinResponse<List<InstanceActivity>>> lookupWeeklyActivities() async =>
      super.transformMultiDataResponse(
        await super.get(
          UserContext.oauth2OrAnonymous,
          '/api/v1/instance/activity',
        ),
        dataBuilder: InstanceActivity.fromJson,
      );

  @override
  Future<KbinResponse<List<Rule>>> lookupRules() async =>
      super.transformMultiDataResponse(
        await super.get(
          UserContext.oauth2OrAnonymous,
          '/api/v1/instance/rules',
        ),
        dataBuilder: Rule.fromJson,
      );

  @override
  Future<KbinResponse<List<BlockedDomain>>> lookupBlockedDomains() async =>
      super.transformMultiDataResponse(
        await super.get(
          UserContext.oauth2OrAnonymous,
          '/api/v1/instance/domain_block',
        ),
        dataBuilder: BlockedDomain.fromJson,
      );

  @override
  Future<KbinResponse<ExtendedDescription>> lookupExtendedDescription() async =>
      super.transformSingleDataResponse(
        await super.get(
          UserContext.anonymousOnly,
          '/api/v1/example',
        ),
        dataBuilder: ExtendedDescription.fromJson,
      );

  @override
  Future<KbinResponse<List<Tag>>> lookupTrendingTags({
    int? limit,
  }) async =>
      super.transformMultiDataResponse(
        await super.get(
          UserContext.anonymousOnly,
          '/api/v1/trends/tags',
          queryParameters: {
            'limit': limit,
          },
        ),
        dataBuilder: Tag.fromJson,
      );

  @override
  Future<KbinResponse<List<Status>>> lookupTrendingStatuses({
    int? limit,
  }) async =>
      super.transformMultiDataResponse(
        await super.get(
          UserContext.anonymousOnly,
          '/api/v1/trends/statuses',
          queryParameters: {
            'limit': limit,
          },
        ),
        dataBuilder: Status.fromJson,
      );

  @override
  Future<KbinResponse<List<TrendsLink>>> lookupTrendingLinks({
    int? limit,
  }) async =>
      super.transformMultiDataResponse(
        await super.get(
          UserContext.anonymousOnly,
          '/api/v1/trends/links',
          queryParameters: {
            'limit': limit,
          },
        ),
        dataBuilder: TrendsLink.fromJson,
      );

  @override
  Future<KbinResponse<List<Announcement>>> lookupActiveAnnouncements({
    bool? includeDismissed,
  }) async =>
      await _lookupAnnouncements(includeDismissed: false);

  @override
  Future<KbinResponse<List<Announcement>>> lookupAnnouncements({
    bool? includeDismissed,
  }) async =>
      await _lookupAnnouncements(includeDismissed: true);

  @override
  Future<KbinResponse<Empty>> createMarkAnnouncementAsRead({
    required String announcementId,
  }) async =>
      super.transformEmptyResponse(
        await super.post(
          UserContext.oauth2Only,
          '/api/v1/announcements/$announcementId/dismiss',
        ),
      );

  @override
  Future<KbinResponse<Empty>> createReactionToAnnouncement({
    required String announcementId,
    required String emojiName,
  }) async =>
      super.transformEmptyResponse(
        await super.put(
          UserContext.oauth2Only,
          '/api/v1/announcements/$announcementId/reactions/$emojiName',
        ),
      );

  @override
  Future<KbinResponse<Empty>> destroyReactionToAnnouncement({
    required String announcementId,
    required String emojiName,
  }) async =>
      super.transformEmptyResponse(
        await super.delete(
          UserContext.oauth2Only,
          '/api/v1/announcements/$announcementId/reactions/$emojiName',
        ),
      );

  Future<KbinResponse<List<Announcement>>> _lookupAnnouncements({
    bool? includeDismissed,
  }) async =>
      super.transformMultiDataResponse(
        await super.get(
          UserContext.oauth2Only,
          '/api/v1/announcements',
          queryParameters: {
            'with_dismissed': includeDismissed,
          },
        ),
        dataBuilder: Announcement.fromJson,
      );

  @override
  Future<KbinResponse<List<Emoji>>> lookupAvailableEmoji() async =>
      super.transformMultiDataResponse(
        await super.get(
          UserContext.anonymousOnly,
          '/api/v1/custom_emojis',
        ),
        dataBuilder: Emoji.fromJson,
      );

  @override
  Future<KbinResponse<List<Account>>> lookupAccounts({
    int? offset,
    int? limit,
    InstanceAccountOrder? order,
    bool? onlyLocal,
  }) async =>
      super.transformMultiDataResponse(
        await super.get(
          UserContext.anonymousOnly,
          '/api/v1/directory',
          queryParameters: {
            'offset': offset,
            'limit': limit,
            'order': order,
            'local': onlyLocal,
          },
        ),
        dataBuilder: Account.fromJson,
      );
}
