// Copyright 2023 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// 🌎 Project imports:
import '../../../core/http_method.dart';

class KbinRequest {
  /// Returns the new instance of [KbinRequest].
  const KbinRequest({
    required this.method,
    required this.url,
  });

  /// The http method when request has sent.
  final HttpMethod method;

  /// The request url.
  final Uri url;
}
