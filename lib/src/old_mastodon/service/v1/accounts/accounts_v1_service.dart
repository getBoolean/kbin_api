// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// 🎯 Dart imports:
import 'dart:io';

// 📦 Package imports:
import 'package:http/http.dart';

// 🌎 Project imports:
import '../../../../core/client/client_context.dart';
import '../../../../core/client/user_context.dart';
import '../../../../core/language.dart';
import '../../../../core/locale.dart';
import '../../base_service.dart';
import '../../entities/account.dart';
import '../../entities/account_preferences.dart';
import '../../entities/empty.dart';
import '../../entities/familiar_follower.dart';
import '../../entities/featured_tag.dart';
import '../../entities/relationship.dart';
import '../../entities/report.dart';
import '../../entities/report_category.dart';
import '../../entities/status.dart';
import '../../entities/tag.dart';
import '../../entities/token.dart';
import '../../entities/user_list.dart';
import '../../response/kbin_response.dart';
import 'account_default_settings_param.dart';
import 'account_profile_meta_param.dart';

abstract class AccountsV1Service {
  /// Returns the new instance of [AccountsV1Service].
  factory AccountsV1Service({
    required String instance,
    required ClientContext context,
  }) =>
      _AccountsV1Service(
        instance: instance,
        context: context,
      );

  /// Creates a user and account records. Returns an account access token for
  /// the app that initiated the request. The app should save this token for
  /// later, and should wait for the user to confirm their account by clicking
  /// a link in their email inbox.
  ///
  /// ## Parameters
  ///
  /// - [username]: The desired username for the account.
  ///
  /// - [email]: The email address to be used for login.
  ///
  /// - [password]: The password to be used for login.
  ///
  /// - [agreement]: Whether the user agrees to the local rules, terms, and
  ///                policies. These should be presented to the user in order
  ///                to allow them to consent before setting this parameter
  ///                to TRUE.
  ///
  /// - [locale]: The language of the confirmation email that will be sent.
  ///
  /// - [reason]: If registrations require manual approval, this text will be
  ///             reviewed by moderators.
  ///
  /// ## Endpoint Url
  ///
  /// - POST /api/v1/accounts HTTP/1.1
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
  /// - https://docs.joinmastodon.org/methods/accounts/#create
  Future<KbinResponse<Token>> createAccount({
    required String username,
    required String email,
    required String password,
    required bool agreement,
    required Locale locale,
    String? reason,
  });

  /// Test to make sure that the user token works.
  ///
  /// ## Parameters
  ///
  /// - [bearerToken]: Specific Bearer to verify credentials.
  ///
  /// ## Endpoint Url
  ///
  /// - GET /api/v1/accounts/verify_credentials HTTP/1.1
  ///
  /// ## Authentication Methods
  ///
  /// - OAuth 2.0
  ///
  /// ## Required Scopes
  ///
  /// - read:accounts
  ///
  /// ## Reference
  ///
  /// - https://docs.joinmastodon.org/methods/accounts/#verify_credentials
  Future<KbinResponse<Account>> verifyAccountCredentials({
    String? bearerToken,
  });

  /// Update the user’s display and preferences.
  ///
  /// ## Parameters
  ///
  /// - [displayName]: The display name to use for the profile.
  ///
  /// - [bio]: The account bio.
  ///
  /// - [discoverable]: Whether the account should be shown in the profile
  ///                   directory.
  ///
  /// - [bot]: Whether the account has a bot flag.
  ///
  /// - [locked]: Whether manual approval of follow requests is required.
  ///
  /// - [defaultSettings]: Default settings for account.
  ///
  /// - [profileMeta]: Profile metadata name and value.
  ///                  By default, max 4 fields and 255 characters per
  ///                  value.
  ///
  /// ## Endpoint Url
  ///
  /// - PATCH /api/v1/accounts/update_credentials HTTP/1.1
  ///
  /// ## Authentication Methods
  ///
  /// - OAuth 2.0
  ///
  /// ## Required Scopes
  ///
  /// - read:accounts
  ///
  /// ## Reference
  ///
  /// - https://docs.joinmastodon.org/methods/accounts/#verify_credentials
  Future<KbinResponse<Account>> updateAccount({
    String? displayName,
    String? bio,
    bool? discoverable,
    bool? bot,
    bool? locked,
    AccountDefaultSettingsParam? defaultSettings,
    List<AccountProfileMetaParam>? profileMeta,
  });

  /// Update the user’s avatar image.
  ///
  /// ## Parameters
  ///
  /// - [file]: File image to update avatar.
  ///
  /// ## Endpoint Url
  ///
  /// - PATCH /api/v1/accounts/update_credentials HTTP/1.1
  ///
  /// ## Authentication Methods
  ///
  /// - OAuth 2.0
  ///
  /// ## Required Scopes
  ///
  /// - read:accounts
  ///
  /// ## Reference
  ///
  /// - https://docs.joinmastodon.org/methods/accounts/#verify_credentials
  Future<KbinResponse<Account>> updateAvatarImage({
    required File file,
  });

  /// Update the user’s header image.
  ///
  /// ## Parameters
  ///
  /// - [file]: File image to update header.
  ///
  /// ## Endpoint Url
  ///
  /// - PATCH /api/v1/accounts/update_credentials HTTP/1.1
  ///
  /// ## Authentication Methods
  ///
  /// - OAuth 2.0
  ///
  /// ## Required Scopes
  ///
  /// - read:accounts
  ///
  /// ## Reference
  ///
  /// - https://docs.joinmastodon.org/methods/accounts/#verify_credentials
  Future<KbinResponse<Account>> updateHeaderImage({
    required File file,
  });

  @Deprecated('Use lookupAccount instead. Will be removed v1.0.0')
  Future<KbinResponse<Account>> lookupById({
    required String accountId,
  });

  /// View information about a profile.
  ///
  /// ## Parameters
  ///
  /// - [accountId]: The ID of the Account in the database.
  ///
  /// ## Endpoint Url
  ///
  /// - GET /api/v1/accounts/:id HTTP/1.1
  ///
  /// ## Authentication Methods
  ///
  /// - Anonymous
  /// - OAuth 2.0
  ///
  /// ## Required Scopes
  ///
  /// - read:accounts
  ///
  /// ## Reference
  ///
  /// - https://docs.joinmastodon.org/methods/accounts/#get
  Future<KbinResponse<Account>> lookupAccount({
    required String accountId,
  });

  /// Statuses posted to the given account.
  ///
  /// ## Parameters
  ///
  /// - [accountId]: The ID of the Account in the database.
  ///
  /// - [maxStatusId]: Return results older than this ID.
  ///
  /// - [minStatusId]: Return results immediately newer than this ID.
  ///
  /// - [sinceStatusId]: Return results newer than this ID.
  ///
  /// - [tagged]: Filter for statuses using a specific hashtag.
  ///
  /// - [limit]: Maximum number of results to return. Default: 20.
  ///
  /// - [excludeReblogs]: Whether to filter out boosts from the response.
  ///
  /// ## Endpoint Url
  ///
  /// - GET /api/v1/accounts/:id/statuses HTTP/1.1
  ///
  /// ## Authentication Methods
  ///
  /// - Anonymous
  /// - OAuth 2.0
  ///
  /// ## Required Scopes
  ///
  /// - read:statuses
  ///
  /// ## Reference
  ///
  /// - https://docs.joinmastodon.org/methods/accounts/#statuses
  Future<KbinResponse<List<Status>>> lookupStatuses({
    required String accountId,
    String? maxStatusId,
    String? minStatusId,
    String? sinceStatusId,
    String? tagged,
    int? limit,
    bool? excludeReblogs,
  });

  /// Accounts which follow the given account, if network is not hidden by the
  /// account owner.
  ///
  /// ## Parameters
  ///
  /// - [accountId]: The ID of the Account in the database.
  ///
  /// - [limit]: Maximum number of results to return. Defaults to 40.
  ///
  /// ## Endpoint Url
  ///
  /// - GET /api/v1/accounts/:id/followers HTTP/1.1
  ///
  /// ## Authentication Methods
  ///
  /// - OAuth 2.0
  ///
  /// ## Required Scopes
  ///
  /// - read:accounts
  ///
  /// ## Reference
  ///
  /// - https://docs.joinmastodon.org/methods/accounts/#followers
  Future<KbinResponse<List<Account>>> lookupFollowers({
    required String accountId,
    int? limit,
  });

  /// Accounts which follow the given account, if network is not hidden by the
  /// account owner.
  ///
  /// ## Parameters
  ///
  /// - [accountId]: The ID of the Account in the database.
  ///
  /// - [limit]: Maximum number of results to return. Defaults to 40.
  ///
  /// ## Endpoint Url
  ///
  /// - GET /api/v1/accounts/:id/following HTTP/1.1
  ///
  /// ## Authentication Methods
  ///
  /// - OAuth 2.0
  ///
  /// ## Required Scopes
  ///
  /// - read:accounts
  ///
  /// ## Reference
  ///
  /// - https://docs.joinmastodon.org/methods/accounts/#following
  Future<KbinResponse<List<Account>>> lookupFollowings({
    required String accountId,
    int? limit,
  });

  /// Tags featured by this account.
  ///
  /// ## Parameters
  ///
  /// - [accountId]: The ID of the Account in the database.
  ///
  /// ## Endpoint Url
  ///
  /// - GET /api/v1/accounts/:id/featured_tags HTTP/1.1
  ///
  /// ## Authentication Methods
  ///
  /// - Anonymous
  ///
  /// ## Reference
  ///
  /// - https://docs.joinmastodon.org/methods/accounts/#featured_tags
  Future<KbinResponse<List<FeaturedTag>>> lookupFeaturedTags({
    required String accountId,
  });

  /// User lists that you have added this account to.
  ///
  /// ## Parameters
  ///
  /// - [accountId]: The ID of the Account in the database.
  ///
  /// ## Endpoint Url
  ///
  /// - GET /api/v1/accounts/:id/lists HTTP/1.1
  ///
  /// ## Authentication Methods
  ///
  /// - OAuth 2.0
  ///
  /// ## Required Scopes
  ///
  /// - read:lists
  ///
  /// ## Reference
  ///
  /// - https://docs.joinmastodon.org/methods/accounts/#lists
  Future<KbinResponse<List<UserList>>> lookupContainedLists({
    required String accountId,
  });

  /// Follow the given account. Can also be used to update whether to show
  /// reblogs or enable notifications.
  ///
  /// ## Parameters
  ///
  /// - [accountId]: The ID of the Account in the database.
  ///
  /// - [receiveReblogs]: Receive this account’s reblogs in home timeline?
  ///                     Defaults to true.
  ///
  /// - [receiveNotifications]: Receive notifications when this account posts
  ///                          a status? Defaults to false.
  ///
  /// - [filteringLanguages]: Filter received statuses for these languages.
  ///                         If not provided, you will receive this account’s
  ///                         posts in all languages.
  ///
  /// ## Endpoint Url
  ///
  /// - POST /api/v1/accounts/:id/follow HTTP/1.1
  ///
  /// ## Authentication Methods
  ///
  /// - OAuth 2.0
  ///
  /// ## Required Scopes
  ///
  /// - read:lists
  ///
  /// ## Reference
  ///
  /// - https://docs.joinmastodon.org/methods/accounts/#follow
  Future<KbinResponse<Relationship>> createFollow({
    required String accountId,
    bool? receiveReblogs,
    bool? receiveNotifications,
    List<Language>? filteringLanguages,
  });

  /// Unfollow the given account.
  ///
  /// ## Parameters
  ///
  /// - [accountId]: The ID of the Account in the database.
  ///
  /// ## Endpoint Url
  ///
  /// - POST /api/v1/accounts/:id/unfollow HTTP/1.1
  ///
  /// ## Authentication Methods
  ///
  /// - OAuth 2.0
  ///
  /// ## Required Scopes
  ///
  /// - write:follows
  ///
  /// ## Reference
  ///
  /// - https://docs.joinmastodon.org/methods/accounts/#unfollow
  Future<KbinResponse<Relationship>> destroyFollow({
    required String accountId,
  });

  /// Remove the given account from your followers.
  ///
  /// ## Parameters
  ///
  /// - [accountId]: The ID of the Account in the database.
  ///
  /// ## Endpoint Url
  ///
  /// - POST /api/v1/accounts/:id/remove_from_followers HTTP/1.1
  ///
  /// ## Authentication Methods
  ///
  /// - OAuth 2.0
  ///
  /// ## Required Scopes
  ///
  /// - write:follows
  ///
  /// ## Reference
  ///
  /// - https://docs.joinmastodon.org/methods/accounts/#remove_from_followers
  Future<KbinResponse<Relationship>> destroyFollower({
    required String accountId,
  });

  /// Block the given account. Clients should filter statuses from this account
  /// if received (e.g. due to a boost in the Home timeline)
  ///
  /// ## Parameters
  ///
  /// - [accountId]: The ID of the Account in the database.
  ///
  /// ## Endpoint Url
  ///
  /// - POST /api/v1/accounts/:id/block HTTP/1.1
  ///
  /// ## Authentication Methods
  ///
  /// - OAuth 2.0
  ///
  /// ## Required Scopes
  ///
  /// - write:blocks
  ///
  /// ## Reference
  ///
  /// - https://docs.joinmastodon.org/methods/accounts/#block
  Future<KbinResponse<Relationship>> createBlock({
    required String accountId,
  });

  /// Unblock the given account.
  ///
  /// ## Parameters
  ///
  /// - [accountId]: The ID of the Account in the database.
  ///
  /// ## Endpoint Url
  ///
  /// - POST /api/v1/accounts/:id/unblock HTTP/1.1
  ///
  /// ## Authentication Methods
  ///
  /// - OAuth 2.0
  ///
  /// ## Required Scopes
  ///
  /// - write:blocks
  ///
  /// ## Reference
  ///
  /// - https://docs.joinmastodon.org/methods/accounts/#unblock
  Future<KbinResponse<Relationship>> destroyBlock({
    required String accountId,
  });

  /// Mute the given account. Clients should filter statuses and notifications
  /// from this account, if received (e.g. due to a boost in the Home timeline).
  ///
  /// ## Parameters
  ///
  /// - [accountId]: The ID of the Account in the database.
  ///
  /// - [includeNotifications]: Mute notifications in addition to statuses?
  ///                           Defaults to true.
  ///
  /// - [duration]: How long the mute should last. Defaults to 0 (indefinite).
  ///
  /// ## Endpoint Url
  ///
  /// - POST /api/v1/accounts/:id/mute HTTP/1.1
  ///
  /// ## Authentication Methods
  ///
  /// - OAuth 2.0
  ///
  /// ## Required Scopes
  ///
  /// - write:mutes
  ///
  /// ## Reference
  ///
  /// - https://docs.joinmastodon.org/methods/accounts/#mute
  Future<KbinResponse<Relationship>> createMute({
    required String accountId,
    bool? includeNotifications,
    Duration? duration,
  });

  /// Unmute the given account.
  ///
  /// ## Parameters
  ///
  /// - [accountId]: The ID of the Account in the database.
  ///
  /// ## Endpoint Url
  ///
  /// - POST /api/v1/accounts/:id/unmute HTTP/1.1
  ///
  /// ## Authentication Methods
  ///
  /// - OAuth 2.0
  ///
  /// ## Required Scopes
  ///
  /// - write:mutes
  ///
  /// ## Reference
  ///
  /// - https://docs.joinmastodon.org/methods/accounts/#unmute
  Future<KbinResponse<Relationship>> destroyMute({
    required String accountId,
  });

  /// Add the given account to the user’s featured profiles.
  /// (Featured profiles are currently shown on the user’s own public profile.)
  ///
  /// ## Parameters
  ///
  /// - [accountId]: The ID of the Account in the database.
  ///
  /// ## Endpoint Url
  ///
  /// - POST /api/v1/accounts/:id/pin HTTP/1.1
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
  /// - https://docs.joinmastodon.org/methods/accounts/#pin
  Future<KbinResponse<Relationship>> createFeaturedProfile({
    required String accountId,
  });

  /// Remove the given account from the user’s featured profiles.
  ///
  /// ## Parameters
  ///
  /// - [accountId]: The ID of the Account in the database.
  ///
  /// ## Endpoint Url
  ///
  /// - POST /api/v1/accounts/:id/unpin HTTP/1.1
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
  /// - https://docs.joinmastodon.org/methods/accounts/#unpin
  Future<KbinResponse<Relationship>> destroyFeaturedProfile({
    required String accountId,
  });

  /// Sets a private note on a user.
  ///
  /// ## Parameters
  ///
  /// - [accountId]: The ID of the Account in the database.
  ///
  /// - [text]: The comment to be set on that user.
  ///           Provide an empty string or leave out this parameter to
  ///           clear the currently set note.
  ///
  /// ## Endpoint Url
  ///
  /// - POST /api/v1/accounts/:id/note HTTP/1.1
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
  /// - https://docs.joinmastodon.org/methods/accounts/#note
  Future<KbinResponse<Relationship>> updatePrivateComment({
    required String accountId,
    String text = '',
  });

  /// Find out whether a given account is followed, blocked, muted, etc.
  ///
  /// ## Parameters
  ///
  /// - [accountIds]: Check relationships for the provided account IDs.
  ///
  /// ## Endpoint Url
  ///
  /// - GET /api/v1/accounts/relationships HTTP/1.1
  ///
  /// ## Authentication Methods
  ///
  /// - OAuth 2.0
  ///
  /// ## Required Scopes
  ///
  /// - read:follows
  ///
  /// ## Reference
  ///
  /// - https://docs.joinmastodon.org/methods/accounts/#relationships
  Future<KbinResponse<List<Relationship>>> lookupRelationships({
    required List<String> accountIds,
  });

  /// Obtain a list of all accounts that follow a given account, filtered for
  /// accounts you follow.
  ///
  /// ## Parameters
  ///
  /// - [accountIds]: Find familiar followers for the provided account IDs.
  ///
  /// ## Endpoint Url
  ///
  /// - GET /api/v1/accounts/familiar_followers HTTP/1.1
  ///
  /// ## Authentication Methods
  ///
  /// - OAuth 2.0
  ///
  /// ## Required Scopes
  ///
  /// - read:follows
  ///
  /// ## Reference
  ///
  /// - https://docs.joinmastodon.org/methods/accounts/#familiar_followers
  Future<KbinResponse<List<FamiliarFollower>>> lookupFamiliarFollowers({
    required List<String> accountIds,
  });

  /// Search for matching accounts by username or display name.
  ///
  /// ## Parameters
  ///
  /// - [query]: Search query for accounts.
  ///
  /// - [limit]: Maximum number of results. Defaults to 40.
  ///
  /// - [resolveWithWebFinger]: Attempt WebFinger lookup. Defaults to false.
  ///                           Use this when [query] is an exact address.
  ///
  /// - [onlyFollowings]: Limit the search to users you are following.
  ///                            Defaults to false.
  ///
  /// ## Endpoint Url
  ///
  /// - GET /api/v1/accounts/search HTTP/1.1
  ///
  /// ## Authentication Methods
  ///
  /// - OAuth 2.0
  ///
  /// ## Required Scopes
  ///
  /// - read:accounts
  ///
  /// ## Reference
  ///
  /// - https://docs.joinmastodon.org/methods/accounts/#search
  Future<KbinResponse<List<Account>>> searchAccounts({
    required String query,
    int? limit,
    bool? resolveWithWebFinger,
    bool? onlyFollowings,
  });

  /// Quickly lookup a username to see if it is available, or quickly
  /// resolve a Web Finger address to an account ID.
  ///
  /// ## Parameters
  ///
  /// - [accountIdentifier]: The username or Web Finger address to lookup.
  ///
  /// - [skipWebFinger]: Whether to use the locally cached result instead of
  ///                    performing full Web Finger resolution. Defaults to
  ///                    true.
  ///
  /// ## Endpoint Url
  ///
  /// - GET /api/v1/accounts/lookup HTTP/1.1
  ///
  /// ## Authentication Methods
  ///
  /// - Anonymous
  ///
  /// ## Required Scopes
  ///
  /// - read:accounts
  ///
  /// ## Reference
  ///
  /// - https://docs.joinmastodon.org/methods/accounts/#lookup
  Future<KbinResponse<Account>> lookupAccountFromWebFingerAddress({
    required String accountIdentifier,
    bool? skipWebFinger,
  });

  /// Preferences defined by the user in their account settings.
  ///
  /// ## Endpoint Url
  ///
  /// - GET /api/v1/preferences HTTP/1.1
  ///
  /// ## Authentication Methods
  ///
  /// - OAuth 2.0
  ///
  /// ## Required Scopes
  ///
  /// - read:accounts
  ///
  /// ## Reference
  ///
  /// - https://docs.joinmastodon.org/methods/preferences/#get
  Future<KbinResponse<AccountPreferences>> lookupPreferences();

  /// List all hashtags featured on your profile.
  ///
  /// ## Endpoint Url
  ///
  /// - GET /api/v1/featured_tags HTTP/1.1
  ///
  /// ## Authentication Methods
  ///
  /// - OAuth 2.0
  ///
  /// ## Required Scopes
  ///
  /// - read:accounts
  ///
  /// ## Reference
  ///
  /// - https://docs.joinmastodon.org/methods/featured_tags/#get
  Future<KbinResponse<List<FeaturedTag>>> lookupOwnedFeaturedTags();

  /// Promote a hashtag on your profile.
  ///
  /// ## Parameters
  ///
  /// - [tagName]: The hashtag to be featured, without the hash sign.
  ///
  /// ## Endpoint Url
  ///
  /// - POST /api/v1/featured_tags HTTP/1.1
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
  /// - https://docs.joinmastodon.org/methods/featured_tags/#feature
  Future<KbinResponse<FeaturedTag>> createFeaturedTag({
    required String tagName,
  });

  /// Stop promoting a hashtag on your profile.
  ///
  /// ## Parameters
  ///
  /// - [tagId]: The ID of the FeaturedTag in the database.
  ///
  /// ## Endpoint Url
  ///
  /// - DELETE /api/v1/featured_tags/:id HTTP/1.1
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
  /// - https://docs.joinmastodon.org/methods/featured_tags/#unfeature-a-tag-unfeature
  Future<KbinResponse<Empty>> destroyFeaturedTag({
    required String tagId,
  });

  /// Shows up to 10 recently-used tags.
  ///
  /// ## Endpoint Url
  ///
  /// - GET /api/v1/featured_tags/suggestions HTTP/1.1
  ///
  /// ## Authentication Methods
  ///
  /// - OAuth 2.0
  ///
  /// ## Required Scopes
  ///
  /// - read:accounts
  ///
  /// ## Reference
  ///
  /// - https://docs.joinmastodon.org/methods/featured_tags/#suggestions
  Future<KbinResponse<List<Tag>>> lookupSuggestedTags();

  /// View all followed tags.
  ///
  /// ## Parameters
  ///
  /// - [limit]: Maximum number of results to return. Defaults to 100 tags.
  ///            Max 200 tags.
  ///
  /// ## Endpoint Url
  ///
  /// - GET /api/v1/followed_tags HTTP/1.1
  ///
  /// ## Authentication Methods
  ///
  /// - OAuth 2.0
  ///
  /// ## Required Scopes
  ///
  /// - read:follows
  ///
  /// ## Reference
  ///
  /// - https://docs.joinmastodon.org/methods/followed_tags/#get
  Future<KbinResponse<List<Tag>>> lookupFollowedTags({int? limit});

  /// Remove an account from follow suggestions.
  ///
  /// ## Parameters
  ///
  /// - [accountId]: The ID of the Account in the database.
  ///
  /// ## Endpoint Url
  ///
  /// - DELETE /api/v1/suggestions/:account_id HTTP/1.1
  ///
  /// ## Authentication Methods
  ///
  /// - OAuth 2.0
  ///
  /// ## Required Scopes
  ///
  /// - read
  ///
  /// ## Reference
  ///
  /// - https://docs.joinmastodon.org/methods/suggestions/#remove
  Future<KbinResponse<Empty>> destroyFollowSuggestion({
    required String accountId,
  });

  /// Show a hashtag and its associated information
  ///
  /// ## Parameters
  ///
  /// - [tagId]: The name of the hashtag.
  ///
  /// ## Endpoint Url
  ///
  /// - GET /api/v1/tags/:id HTTP/1.1
  ///
  /// ## Authentication Methods
  ///
  /// - Anonymous
  /// - OAuth 2.0
  ///
  /// ## Reference
  ///
  /// - https://docs.joinmastodon.org/methods/tags/#get
  Future<KbinResponse<Tag>> lookupTag({
    required String tagId,
  });

  /// Follow a hashtag.
  ///
  /// Posts containing a followed hashtag will be inserted into your home
  /// timeline.
  ///
  /// ## Parameters
  ///
  /// - [tagId]: The name of the hashtag.
  ///
  /// ## Endpoint Url
  ///
  /// - POST /api/v1/tags/:id/follow HTTP/1.1
  ///
  /// ## Authentication Methods
  ///
  /// - OAuth 2.0
  ///
  /// ## Required Scopes
  ///
  /// - write:follows
  ///
  /// ## Reference
  ///
  /// - https://docs.joinmastodon.org/methods/tags/#follow
  Future<KbinResponse<Tag>> createFollowingTag({
    required String tagId,
  });

  /// Unfollow a hashtag.
  ///
  /// Posts containing this hashtag will no longer be inserted into your home
  /// timeline.
  ///
  /// ## Parameters
  ///
  /// - [tagId]: The name of the hashtag.
  ///
  /// ## Endpoint Url
  ///
  /// - POST /api/v1/tags/:id/unfollow HTTP/1.1
  ///
  /// ## Authentication Methods
  ///
  /// - OAuth 2.0
  ///
  /// ## Required Scopes
  ///
  /// - write:follows
  ///
  /// ## Reference
  ///
  /// - https://docs.joinmastodon.org/methods/tags/#unfollow
  Future<KbinResponse<Tag>> destroyFollowingTag({
    required String tagId,
  });

  /// Report problematic users to your moderators.
  ///
  /// ## Parameters
  ///
  /// - [accountId]: ID of the account to report.
  ///
  /// - [reason]: The reason for the report. Default maximum of
  ///              1000 characters.
  ///
  /// - [forward]: If the account is remote, should the report be forwarded
  ///              to the remote admin? Defaults to false.
  ///
  /// - [category]: Specify if the report is due to [ReportCategory.spam],
  ///               [ReportCategory.violation] of enumerated instance
  ///               rules, or some other reason. Defaults to
  ///               [ReportCategory.other]. Will be set to violation if
  ///               [ruleIds] is provided (regardless of any category value
  ///               you provide).
  ///
  /// - [statusIds]: You can attach statuses to the report to provide
  ///                additional context.
  ///
  /// - [ruleIds]: For violation category reports, specify the ID
  ///              of the exact rules broken.
  ///
  /// ## Endpoint Url
  ///
  /// - POST /api/v1/reports HTTP/1.1
  ///
  /// ## Authentication Methods
  ///
  /// - OAuth 2.0
  ///
  /// ## Required Scopes
  ///
  /// - write:reports
  ///
  /// ## Reference
  ///
  /// - https://docs.joinmastodon.org/methods/reports/#post
  Future<KbinResponse<Report>> createReport({
    required String accountId,
    String? reason,
    bool? forward,
    ReportCategory? category,
    List<String>? statusIds,
    List<String>? ruleIds,
  });

  /// Accounts that the user is currently featuring on their profile.
  ///
  /// ## Parameters
  ///
  /// - [limit]: Maximum number of results to return. Defaults to 40 accounts.
  ///            Max 80 accounts.
  ///
  /// ## Endpoint Url
  ///
  /// - GET /api/v1/endorsements HTTP/1.1
  ///
  /// ## Authentication Methods
  ///
  /// - OAuth 2.0
  ///
  /// ## Required Scopes
  ///
  /// - read:accounts
  ///
  /// ## Reference
  ///
  /// - https://docs.joinmastodon.org/methods/endorsements/#get
  Future<KbinResponse<List<Account>>> lookupFeaturedProfiles({
    int? limit,
  });

  /// Accounts the user has muted.
  ///
  /// ## Parameters
  ///
  /// - [limit]: Maximum number of results to return. Defaults to 40 accounts.
  ///            Max 80 accounts.
  ///
  /// ## Endpoint Url
  ///
  /// - GET /api/v1/mutes HTTP/1.1
  ///
  /// ## Authentication Methods
  ///
  /// - OAuth 2.0
  ///
  /// ## Required Scopes
  ///
  /// - follow
  /// - read:mutes
  ///
  /// ## Reference
  ///
  /// - https://docs.joinmastodon.org/methods/mutes/#get
  Future<KbinResponse<List<Account>>> lookupMutedAccounts({
    int? limit,
  });

  /// Statuses the user has favourited.
  ///
  /// ## Parameters
  ///
  /// - [limit]: Maximum number of results to return. Defaults to 20 statuses.
  ///            Max 40 statuses.
  ///
  /// ## Endpoint Url
  ///
  /// - GET /api/v1/favourites HTTP/1.1
  ///
  /// ## Authentication Methods
  ///
  /// - OAuth 2.0
  ///
  /// ## Required Scopes
  ///
  /// - read:favourites
  ///
  /// ## Reference
  ///
  /// - https://docs.joinmastodon.org/methods/favourites/#get
  Future<KbinResponse<List<Status>>> lookupFavouritedStatuses({
    int? limit,
  });

  /// View your blocks.
  ///
  /// ## Parameters
  ///
  /// - [limit]: Maximum number of results to return. Defaults to 40 accounts.
  ///            Max 80 accounts.
  ///
  /// ## Endpoint Url
  ///
  /// - GET /api/v1/blocks HTTP/1.1
  ///
  /// ## Authentication Methods
  ///
  /// - OAuth 2.0
  ///
  /// ## Required Scopes
  ///
  /// - read:blocks
  ///
  /// ## Reference
  ///
  /// - https://docs.joinmastodon.org/methods/blocks/#get
  Future<KbinResponse<List<Account>>> lookupBlockedAccounts({
    int? limit,
  });

  /// Statuses the user has bookmarked.
  ///
  /// ## Parameters
  ///
  /// - [limit]: Maximum number of results to return. Defaults to 20 statuses.
  ///            Max 40 statuses.
  ///
  /// ## Endpoint Url
  ///
  /// - GET /api/v1/bookmarks HTTP/1.1
  ///
  /// ## Authentication Methods
  ///
  /// - OAuth 2.0
  ///
  /// ## Required Scopes
  ///
  /// - read:bookmarks
  ///
  /// ## Reference
  ///
  /// - https://docs.joinmastodon.org/methods/bookmarks/#get
  Future<KbinResponse<List<Status>>> lookupBookmarkedStatuses({
    int? limit,
  });

  /// View domains the user has blocked.
  ///
  /// ## Parameters
  ///
  /// - [limit]: Maximum number of results to return. Defaults to 100 domain
  ///            blocks. Max 200 domain blocks.
  ///
  /// ## Endpoint Url
  ///
  /// - GET /api/v1/domain_blocks HTTP/1.1
  ///
  /// ## Authentication Methods
  ///
  /// - OAuth 2.0
  ///
  /// ## Required Scopes
  ///
  /// - follow
  /// - read:blocks
  ///
  /// ## Reference
  ///
  /// - https://docs.joinmastodon.org/methods/domain_blocks/#get
  Future<KbinResponse<List<String>>> lookupBlockedDomains({
    int? limit,
  });

  /// Block a domain to:
  ///
  /// - hide all public posts from it
  /// - hide all notifications from it
  /// - remove all followers from it
  /// - prevent following new users from it (but does not remove existing
  ///   follows)
  ///
  /// ## Parameters
  ///
  /// - [domainName]: Domain to block.
  ///
  /// ## Endpoint Url
  ///
  /// - POST /api/v1/domain_blocks HTTP/1.1
  ///
  /// ## Authentication Methods
  ///
  /// - OAuth 2.0
  ///
  /// ## Required Scopes
  ///
  /// - follow
  /// - write:blocks
  ///
  /// ## Reference
  ///
  /// - https://docs.joinmastodon.org/methods/domain_blocks/#block
  Future<KbinResponse<Empty>> createBlockedDomain({
    required String domainName,
  });

  /// Remove a domain block, if it exists in the user’s array of
  /// blocked domains.
  ///
  /// ## Parameters
  ///
  /// - [domainName]: Domain to block.
  ///
  /// ## Endpoint Url
  ///
  /// - DELETE /api/v1/domain_blocks HTTP/1.1
  ///
  /// ## Authentication Methods
  ///
  /// - OAuth 2.0
  ///
  /// ## Required Scopes
  ///
  /// - follow
  /// - write:blocks
  ///
  /// ## Reference
  ///
  /// - https://docs.joinmastodon.org/methods/domain_blocks/#unblock
  Future<KbinResponse<Empty>> destroyBlockedDomain({
    required String domainName,
  });

  /// View pending follow requests.
  ///
  /// ## Parameters
  ///
  /// - [limit]: Maximum number of results to return. Defaults to 40 accounts.
  ///            Max 80 accounts.
  ///
  /// ## Endpoint Url
  ///
  /// - GET /api/v1/follow_requests HTTP/1.1
  ///
  /// ## Authentication Methods
  ///
  /// - OAuth 2.0
  ///
  /// ## Required Scopes
  ///
  /// - follow
  /// - read:follows
  ///
  /// ## Reference
  ///
  /// - https://docs.joinmastodon.org/methods/follow_requests/#get
  Future<KbinResponse<List<Account>>> lookupFollowRequests({
    int? limit,
  });

  /// Accept follow request.
  ///
  /// ## Parameters
  ///
  /// - [accountId]: The ID of the Account in the database.
  ///
  /// ## Endpoint Url
  ///
  /// - POST /api/v1/follow_requests/:account_id/authorize HTTP/1.1
  ///
  /// ## Authentication Methods
  ///
  /// - OAuth 2.0
  ///
  /// ## Required Scopes
  ///
  /// - follow
  /// - write:follows
  ///
  /// ## Reference
  ///
  /// - https://docs.joinmastodon.org/methods/follow_requests/#accept
  Future<KbinResponse<Relationship>> createFollower({
    required String accountId,
  });

  /// Reject follow request.
  ///
  /// ## Parameters
  ///
  /// - [accountId]: The ID of the Account in the database.
  ///
  /// ## Endpoint Url
  ///
  /// - POST /api/v1/follow_requests/:account_id/reject HTTP/1.1
  ///
  /// ## Authentication Methods
  ///
  /// - OAuth 2.0
  ///
  /// ## Required Scopes
  ///
  /// - follow
  /// - write:follows
  ///
  /// ## Reference
  ///
  /// - https://docs.joinmastodon.org/methods/follow_requests/#reject
  Future<KbinResponse<Relationship>> destroyFollowRequest({
    required String accountId,
  });
}

class _AccountsV1Service extends BaseService implements AccountsV1Service {
  /// Returns the new instance of [_AccountsV1Service].
  _AccountsV1Service({
    required super.instance,
    required super.context,
  });

  @override
  Future<KbinResponse<Token>> createAccount({
    required String username,
    required String email,
    required String password,
    required bool agreement,
    required Locale locale,
    String? reason,
  }) async =>
      super.transformSingleDataResponse(
        await super.post(
          UserContext.oauth2Only,
          '/api/v1/accounts',
          body: {
            'username': username,
            'email': email,
            'password': password,
            'agreement': agreement,
            'locale': locale.toString(),
            'reason': reason,
          },
        ),
        dataBuilder: Token.fromJson,
      );

  @override
  Future<KbinResponse<Account>> verifyAccountCredentials({
    String? bearerToken,
  }) async =>
      super.transformSingleDataResponse(
        await super.get(
          UserContext.oauth2Only,
          '/api/v1/accounts/verify_credentials',
          headers: {
            if (bearerToken != null) 'Authorization': 'Bearer $bearerToken',
          },
        ),
        dataBuilder: Account.fromJson,
      );

  @override
  Future<KbinResponse<Account>> updateAccount({
    String? displayName,
    String? bio,
    bool? discoverable,
    bool? bot,
    bool? locked,
    AccountDefaultSettingsParam? defaultSettings,
    List<AccountProfileMetaParam>? profileMeta,
  }) async =>
      super.transformSingleDataResponse(
        await super.patch(
          UserContext.oauth2Only,
          '/api/v1/accounts/update_credentials',
          body: {
            'display_name': displayName,
            'note': bio,
            'discoverable': discoverable,
            'bot': bot,
            'locked': locked,
            'source': {
              'privacy': defaultSettings?.privacy,
              'sensitive': defaultSettings?.sensitive,
              'language': defaultSettings?.language,
            },
            'fields_attributes': profileMeta
                ?.map(
                  (e) => {
                    'name': e.name,
                    'value': e.value,
                  },
                )
                .toList(),
          },
        ),
        dataBuilder: Account.fromJson,
      );

  @override
  Future<KbinResponse<Account>> updateAvatarImage({
    required File file,
  }) async =>
      super.transformSingleDataResponse(
        await super.patchMultipart(
          UserContext.oauth2Only,
          '/api/v1/accounts/update_credentials',
          files: [
            MultipartFile.fromBytes(
              'avatar',
              file.readAsBytesSync(),
              filename: file.path,
            ),
          ],
        ),
        dataBuilder: Account.fromJson,
      );

  @override
  Future<KbinResponse<Account>> updateHeaderImage({
    required File file,
  }) async =>
      super.transformSingleDataResponse(
        await super.patchMultipart(
          UserContext.oauth2Only,
          '/api/v1/accounts/update_credentials',
          files: [
            MultipartFile.fromBytes(
              'avatar',
              file.readAsBytesSync(),
              filename: file.path,
            ),
          ],
        ),
        dataBuilder: Account.fromJson,
      );

  @override
  Future<KbinResponse<Account>> lookupById({
    required String accountId,
  }) async =>
      await lookupAccount(accountId: accountId);

  @override
  Future<KbinResponse<Account>> lookupAccount({
    required String accountId,
  }) async =>
      super.transformSingleDataResponse(
        await super.get(
          UserContext.oauth2OrAnonymous,
          '/api/v1/accounts/$accountId',
        ),
        dataBuilder: Account.fromJson,
      );

  @override
  Future<KbinResponse<List<Status>>> lookupStatuses({
    required String accountId,
    String? maxStatusId,
    String? minStatusId,
    String? sinceStatusId,
    String? tagged,
    int? limit,
    bool? excludeReblogs,
  }) async =>
      super.transformMultiDataResponse(
        await super.get(
          UserContext.oauth2OrAnonymous,
          '/api/v1/accounts/$accountId/statuses',
          queryParameters: {
            'max_id': maxStatusId,
            'min_id': minStatusId,
            'since_id': sinceStatusId,
            'tagged': tagged,
            'limit': limit,
            'exclude_reblogs': excludeReblogs,
          },
        ),
        dataBuilder: Status.fromJson,
      );

  @override
  Future<KbinResponse<List<Account>>> lookupFollowers({
    required String accountId,
    int? limit,
  }) async =>
      super.transformMultiDataResponse(
        await super.get(
          UserContext.oauth2Only,
          '/api/v1/accounts/$accountId/followers',
          queryParameters: {
            'limit': limit,
          },
        ),
        dataBuilder: Account.fromJson,
      );

  @override
  Future<KbinResponse<List<Account>>> lookupFollowings({
    required Object accountId,
    int? limit,
  }) async =>
      super.transformMultiDataResponse(
        await super.get(
          UserContext.oauth2Only,
          '/api/v1/accounts/$accountId/following',
          queryParameters: {
            'limit': limit,
          },
        ),
        dataBuilder: Account.fromJson,
      );

  @override
  Future<KbinResponse<List<FeaturedTag>>> lookupFeaturedTags({
    required String accountId,
  }) async =>
      super.transformMultiDataResponse(
        await super.get(
          UserContext.anonymousOnly,
          '/api/v1/accounts/$accountId/featured_tags',
        ),
        dataBuilder: FeaturedTag.fromJson,
      );

  @override
  Future<KbinResponse<List<UserList>>> lookupContainedLists({
    required String accountId,
  }) async =>
      super.transformMultiDataResponse(
        await super.get(
          UserContext.oauth2Only,
          '/api/v1/accounts/$accountId/lists',
        ),
        dataBuilder: UserList.fromJson,
      );

  @override
  Future<KbinResponse<Relationship>> createFollow({
    required String accountId,
    bool? receiveReblogs,
    bool? receiveNotifications,
    List<Language>? filteringLanguages,
  }) async =>
      super.transformSingleDataResponse(
        await super.post(
          UserContext.oauth2Only,
          '/api/v1/accounts/$accountId/follow',
          body: {
            'reblogs': receiveReblogs,
            'notify': receiveNotifications,
            'languages': filteringLanguages?.map((e) => e.value).toList(),
          },
        ),
        dataBuilder: Relationship.fromJson,
      );

  @override
  Future<KbinResponse<Relationship>> destroyFollow({
    required String accountId,
  }) async =>
      super.transformSingleDataResponse(
        await super.post(
          UserContext.oauth2Only,
          '/api/v1/accounts/$accountId/unfollow',
        ),
        dataBuilder: Relationship.fromJson,
      );

  @override
  Future<KbinResponse<Relationship>> destroyFollower({
    required String accountId,
  }) async =>
      super.transformSingleDataResponse(
        await super.post(
          UserContext.oauth2Only,
          '/api/v1/accounts/$accountId/remove_from_followers',
        ),
        dataBuilder: Relationship.fromJson,
      );

  @override
  Future<KbinResponse<Relationship>> createBlock({
    required Object accountId,
  }) async =>
      super.transformSingleDataResponse(
        await super.post(
          UserContext.oauth2Only,
          '/api/v1/accounts/$accountId/block',
        ),
        dataBuilder: Relationship.fromJson,
      );

  @override
  Future<KbinResponse<Relationship>> destroyBlock({
    required String accountId,
  }) async =>
      super.transformSingleDataResponse(
        await super.post(
          UserContext.oauth2Only,
          'api/v1/accounts/$accountId/unblock',
        ),
        dataBuilder: Relationship.fromJson,
      );

  @override
  Future<KbinResponse<Relationship>> createMute({
    required String accountId,
    bool? includeNotifications,
    Duration? duration,
  }) async =>
      super.transformSingleDataResponse(
        await super.post(
          UserContext.oauth2Only,
          '/api/v1/accounts/$accountId/mute',
          body: {
            'notifications': includeNotifications,
            'duration': duration?.inSeconds,
          },
        ),
        dataBuilder: Relationship.fromJson,
      );

  @override
  Future<KbinResponse<Relationship>> destroyMute({
    required String accountId,
  }) async =>
      super.transformSingleDataResponse(
        await super.post(
          UserContext.oauth2Only,
          '/api/v1/accounts/$accountId/unmute',
        ),
        dataBuilder: Relationship.fromJson,
      );

  @override
  Future<KbinResponse<Relationship>> createFeaturedProfile({
    required String accountId,
  }) async =>
      super.transformSingleDataResponse(
        await super.post(
          UserContext.oauth2Only,
          '/api/v1/accounts/$accountId/pin',
        ),
        dataBuilder: Relationship.fromJson,
      );

  @override
  Future<KbinResponse<Relationship>> destroyFeaturedProfile({
    required String accountId,
  }) async =>
      super.transformSingleDataResponse(
        await super.post(
          UserContext.oauth2Only,
          '/api/v1/accounts/$accountId/unpin',
        ),
        dataBuilder: Relationship.fromJson,
      );

  @override
  Future<KbinResponse<Relationship>> updatePrivateComment({
    required String accountId,
    String text = '',
  }) async =>
      super.transformSingleDataResponse(
        await super.post(
          UserContext.oauth2Only,
          '/api/v1/accounts/$accountId/note',
          body: {
            'comment': text,
          },
        ),
        dataBuilder: Relationship.fromJson,
      );

  @override
  Future<KbinResponse<List<Relationship>>> lookupRelationships({
    required List<String> accountIds,
  }) async =>
      super.transformMultiDataResponse(
        await super.get(
            UserContext.oauth2Only, '/api/v1/accounts/relationships',
            queryParameters: {
              'id[]': accountIds,
            }),
        dataBuilder: Relationship.fromJson,
      );

  @override
  Future<KbinResponse<List<FamiliarFollower>>> lookupFamiliarFollowers({
    required List<String> accountIds,
  }) async =>
      super.transformMultiDataResponse(
        await super.get(
            UserContext.oauth2Only, '/api/v1/accounts/familiar_followers',
            queryParameters: {'id[]': accountIds}),
        dataBuilder: FamiliarFollower.fromJson,
      );

  @override
  Future<KbinResponse<List<Account>>> searchAccounts({
    required String query,
    int? limit,
    bool? resolveWithWebFinger,
    bool? onlyFollowings,
  }) async =>
      super.transformMultiDataResponse(
        await super.get(
          UserContext.oauth2Only,
          '/api/v1/accounts/search',
          queryParameters: {
            'q': query,
            'limit': limit,
            'resolve': resolveWithWebFinger,
            'following': onlyFollowings,
          },
        ),
        dataBuilder: Account.fromJson,
      );

  @override
  Future<KbinResponse<Account>> lookupAccountFromWebFingerAddress({
    required String accountIdentifier,
    bool? skipWebFinger,
  }) async =>
      super.transformSingleDataResponse(
        await super.get(
          UserContext.anonymousOnly,
          '/api/v1/accounts/lookup',
          queryParameters: {
            'acct': accountIdentifier,
            'skip_webfinger': skipWebFinger,
          },
        ),
        dataBuilder: Account.fromJson,
      );

  @override
  Future<KbinResponse<AccountPreferences>> lookupPreferences() async =>
      super.transformSingleDataResponse(
        await super.get(
          UserContext.oauth2Only,
          '/api/v1/preferences',
        ),
        dataBuilder: AccountPreferences.fromJson,
      );

  @override
  Future<KbinResponse<List<FeaturedTag>>> lookupOwnedFeaturedTags() async =>
      super.transformMultiDataResponse(
        await super.get(
          UserContext.oauth2Only,
          '/api/v1/featured_tags',
        ),
        dataBuilder: FeaturedTag.fromJson,
      );

  @override
  Future<KbinResponse<FeaturedTag>> createFeaturedTag({
    required String tagName,
  }) async =>
      super.transformSingleDataResponse(
        await super.post(
          UserContext.oauth2Only,
          '/api/v1/featured_tags',
          body: {
            'name': tagName,
          },
        ),
        dataBuilder: FeaturedTag.fromJson,
      );

  @override
  Future<KbinResponse<Empty>> destroyFeaturedTag({
    required String tagId,
  }) async =>
      super.transformEmptyResponse(
        await super.delete(
          UserContext.oauth2Only,
          '/api/v1/featured_tags/$tagId',
        ),
      );

  @override
  Future<KbinResponse<List<Tag>>> lookupSuggestedTags() async =>
      super.transformMultiDataResponse(
        await super.get(
          UserContext.oauth2Only,
          '/api/v1/featured_tags/suggestions',
        ),
        dataBuilder: Tag.fromJson,
      );

  @override
  Future<KbinResponse<List<Tag>>> lookupFollowedTags({
    int? limit,
  }) async =>
      super.transformMultiDataResponse(
        await super.get(
          UserContext.oauth2Only,
          '/api/v1/followed_tags',
          queryParameters: {
            'limit': limit,
          },
        ),
        dataBuilder: Tag.fromJson,
      );

  @override
  Future<KbinResponse<Empty>> destroyFollowSuggestion({
    required String accountId,
  }) async =>
      super.transformEmptyResponse(
        await super.delete(
          UserContext.oauth2Only,
          '/api/v1/suggestions/$accountId',
        ),
      );

  @override
  Future<KbinResponse<Tag>> lookupTag({
    required String tagId,
  }) async =>
      super.transformSingleDataResponse(
        await super.get(
          UserContext.oauth2OrAnonymous,
          '/api/v1/tags/$tagId',
        ),
        dataBuilder: Tag.fromJson,
      );

  @override
  Future<KbinResponse<Tag>> createFollowingTag({
    required String tagId,
  }) async =>
      super.transformSingleDataResponse(
        await super.post(
          UserContext.oauth2Only,
          '/api/v1/tags/$tagId/follow',
        ),
        dataBuilder: Tag.fromJson,
      );

  @override
  Future<KbinResponse<Tag>> destroyFollowingTag({
    required String tagId,
  }) async =>
      super.transformSingleDataResponse(
        await super.post(
          UserContext.oauth2Only,
          '/api/v1/tags/$tagId/unfollow',
        ),
        dataBuilder: Tag.fromJson,
      );

  @override
  Future<KbinResponse<Report>> createReport({
    required String accountId,
    String? reason,
    bool? forward,
    ReportCategory? category,
    List<String>? statusIds,
    List<String>? ruleIds,
  }) async =>
      super.transformSingleDataResponse(
        await super.post(
          UserContext.oauth2Only,
          '/api/v1/reports',
          body: {
            'account_id': accountId,
            'comment': reason,
            'forward': forward,
            'category': category?.value,
            'status_ids[]': statusIds,
            'rule_ids[]': ruleIds,
          },
        ),
        dataBuilder: Report.fromJson,
      );

  @override
  Future<KbinResponse<List<Account>>> lookupFeaturedProfiles({
    int? limit,
  }) async =>
      super.transformMultiDataResponse(
        await super.get(
          UserContext.oauth2Only,
          '/api/v1/endorsements',
          queryParameters: {
            'limit': limit,
          },
        ),
        dataBuilder: Account.fromJson,
      );

  @override
  Future<KbinResponse<List<Account>>> lookupMutedAccounts({
    int? limit,
  }) async =>
      super.transformMultiDataResponse(
        await super.get(
          UserContext.oauth2Only,
          '/api/v1/mutes',
          queryParameters: {
            'limit': limit,
          },
        ),
        dataBuilder: Account.fromJson,
      );

  @override
  Future<KbinResponse<List<Status>>> lookupFavouritedStatuses({
    int? limit,
  }) async =>
      super.transformMultiDataResponse(
        await super.get(
          UserContext.oauth2Only,
          '/api/v1/favourites',
          queryParameters: {
            'limit': limit,
          },
        ),
        dataBuilder: Status.fromJson,
      );

  @override
  Future<KbinResponse<List<Account>>> lookupBlockedAccounts({
    int? limit,
  }) async =>
      super.transformMultiDataResponse(
        await super.get(
          UserContext.oauth2Only,
          '/api/v1/blocks',
          queryParameters: {
            'limit': limit,
          },
        ),
        dataBuilder: Account.fromJson,
      );

  @override
  Future<KbinResponse<List<Status>>> lookupBookmarkedStatuses({
    int? limit,
  }) async =>
      super.transformMultiDataResponse(
        await super.get(
          UserContext.oauth2Only,
          '/api/v1/bookmarks',
          queryParameters: {
            'limit': limit,
          },
        ),
        dataBuilder: Status.fromJson,
      );

  @override
  Future<KbinResponse<List<String>>> lookupBlockedDomains({
    int? limit,
  }) async =>
      super.transformMultiRawDataResponse(
        await super.get(
          UserContext.oauth2Only,
          '/api/v1/domain_blocks',
          queryParameters: {
            'limit': limit,
          },
        ),
      );

  @override
  Future<KbinResponse<Empty>> createBlockedDomain({
    required String domainName,
  }) async =>
      super.transformEmptyResponse(
        await super.post(
          UserContext.oauth2Only,
          '/api/v1/domain_blocks',
          body: {
            'domain': domainName,
          },
        ),
      );

  @override
  Future<KbinResponse<Empty>> destroyBlockedDomain({
    required String domainName,
  }) async =>
      super.transformEmptyResponse(
        await super.delete(
          UserContext.oauth2Only,
          '/api/v1/domain_blocks',
        ),
      );

  @override
  Future<KbinResponse<List<Account>>> lookupFollowRequests({
    int? limit,
  }) async =>
      super.transformMultiDataResponse(
        await super.get(
          UserContext.oauth2Only,
          '/api/v1/follow_requests',
          queryParameters: {
            'limit': limit,
          },
        ),
        dataBuilder: Account.fromJson,
      );

  @override
  Future<KbinResponse<Relationship>> createFollower({
    required String accountId,
  }) async =>
      super.transformSingleDataResponse(
        await super.post(
          UserContext.oauth2Only,
          '/api/v1/follow_requests/$accountId/authorize',
        ),
        dataBuilder: Relationship.fromJson,
      );

  @override
  Future<KbinResponse<Relationship>> destroyFollowRequest({
    required String accountId,
  }) async =>
      super.transformSingleDataResponse(
        await super.post(
          UserContext.oauth2Only,
          '/api/v1/follow_requests/$accountId/reject',
        ),
        dataBuilder: Relationship.fromJson,
      );
}
