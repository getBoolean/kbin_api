// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// 🌎 Project imports:
import '../core/client/client_context.dart';
import 'v2/accounts/accounts_v2_service.dart';
import 'v2/media/media_v2_service.dart';
import 'v2/search/search_v2_service.dart';

/// The class represents the Kbin v2 services.
abstract class KbinV2Service {
  /// Returns the new instance of [KbinV2Service].
  factory KbinV2Service({
    required String instance,
    required ClientContext context,
  }) =>
      _KbinV2Service(
        instance: instance,
        context: context,
      );

  /// Returns the accounts service.
  AccountsV2Service get accounts;

  /// Returns the search service.
  SearchV2Service get search;

  /// Returns the media service.
  MediaV2Service get media;
}

class _KbinV2Service implements KbinV2Service {
  /// Returns the new instance of [_KbinV2Service].
  _KbinV2Service({
    required String instance,
    required ClientContext context,
  })  : accounts = AccountsV2Service(instance: instance, context: context),
        search = SearchV2Service(instance: instance, context: context),
        media = MediaV2Service(instance: instance, context: context);

  @override
  final AccountsV2Service accounts;

  @override
  final SearchV2Service search;

  @override
  final MediaV2Service media;
}
