// Copyright 2023 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// ignore_for_file: invalid_annotation_target

// 📦 Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';
import 'status.dart';

part 'status_context.freezed.dart';
part 'status_context.g.dart';

@freezed
class StatusContext with _$StatusContext {
  @JsonSerializable(includeIfNull: false)
  const factory StatusContext({
    /// Parents in the thread.
    required List<Status> ancestors,

    /// Children in the thread.
    required List<Status> descendants,
  }) = _StatusesContext;

  factory StatusContext.fromJson(Map<String, Object?> json) =>
      _$StatusContextFromJson(json);
}
