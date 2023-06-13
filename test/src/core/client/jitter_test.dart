// Copyright 2023 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

import 'package:kbin_api/src/core/client/jitter.dart';
import 'package:test/test.dart';

void main() {
  test('normal case', () {
    final jitter = Jitter(maxInSeconds: 5);

    expect(jitter.minInSeconds, 0);
    expect(jitter.maxInSeconds, 5);
  });

  test('with minInSeconds', () {
    final jitter = Jitter(minInSeconds: 2, maxInSeconds: 5);

    expect(jitter.minInSeconds, 2);
    expect(jitter.maxInSeconds, 5);
  });

  test('when minInSeconds is less than 0', () {
    expect(
      () => Jitter(minInSeconds: -1, maxInSeconds: 5),
      throwsA(
        isA<ArgumentError>(),
      ),
    );
  });

  test('when maxInSeconds is less than 0', () {
    expect(
      () => Jitter(minInSeconds: 0, maxInSeconds: -1),
      throwsA(
        isA<ArgumentError>(),
      ),
    );
  });

  test('when maxInSeconds is less than minInSeconds', () {
    expect(
      () => Jitter(minInSeconds: 2, maxInSeconds: 1),
      throwsA(
        isA<ArgumentError>(),
      ),
    );
  });
}
