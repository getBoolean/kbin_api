# kbin API

An Easy and Powerful Dart/Flutter Library for Kbin API 🎯

**WARNING: THIS LIBRARY IS HEAVILY WIP. DO NOT USE!.**

<!-- TOC -->

- [kbin API](#kbin-api)
  - [1. Guide 🌎](#1-guide-)
    - [1.1. Features 💎](#11-features-)
    - [1.2. Getting Started ⚡](#12-getting-started-)
      - [1.2.1. Install Library](#121-install-library)
      - [1.2.2. Import](#122-import)
      - [1.2.3. Implementation](#123-implementation)
    - [1.3. Supported Endpoints 👀](#13-supported-endpoints-)
    - [1.4. Tips 🏄](#14-tips-)
      - [1.4.1. Method Names](#141-method-names)
      - [1.4.2. Null Parameter at Request](#142-null-parameter-at-request)
      - [1.4.4. Change the Timeout Duration](#144-change-the-timeout-duration)
      - [1.4.5. Automatic Retry](#145-automatic-retry)
        - [1.4.5.1. Exponential Backoff and Jitter](#1451-exponential-backoff-and-jitter)
        - [1.4.5.2. Do Something on Retry](#1452-do-something-on-retry)
      - [1.4.6. Thrown Exceptions](#146-thrown-exceptions)
    - [1.5. Contribution 🏆](#15-contribution-)
    - [1.6. Support ❤️](#16-support-️)
    - [1.7 License 🔑](#17-license-)
    - [1.8. More Information 🧐](#18-more-information-)

<!-- /TOC -->

## 1. Guide 🌎

This library provides the easiest way to use [Kbin API](https://docs.kbin.pub/#introduction) in **Dart** and **Flutter** apps.

This library was originally designed and developed by **_Kato Shinya_** ([@myConsciousness](https://github.com/myConsciousness)),
the author of [twitter_api_v2](https://pub.dev/packages/twitter_api_v2), and many parts are adapted from
[twitter_api_v2](https://pub.dev/packages/twitter_api_v2). It was then forked by
**[@getBoolean](https://github.com/getBoolean)** to support the kbin API.

**Show some ❤️ and star the repo to support the project.**

### 1.1. Features 💎

✅ The **wrapper library** for **[Kbin API](https://docs.kbin.pub/#introduction)**. </br>
✅ **Easily integrates** with the **Dart** & **Flutter** apps. </br>
✅ Provides response objects with a **guaranteed safe types.** </br>
✅ **Well documented** and **well tested**.</br>
✅ Supports the powerful **automatic retry**.</br>

### 1.2. Getting Started ⚡

#### 1.2.1. Install Library

**With Dart:**

```bash
 dart pub add kbin_api
```

**Or With Flutter:**

```bash
 flutter pub add kbin_api
```

#### 1.2.2. Import

```dart
import 'package:kbin_api/kbin_api';
```

#### 1.2.3. Implementation

```dart
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
        'Retry after ${event.intervalInSeconds} seconds... '
        '[${event.retryCount} times]',
      ),
    ),

    //! The default timeout is 10 seconds.
    timeout: Duration(seconds: 20),
  );

  try {
    //! Let's Toot from v1 endpoint!
    final response = await mastodon.v1.statuses.createStatus(
      text: 'Toot!',
    );

    print(response.rateLimit);
    print(response.data);
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
```

### 1.3. Supported Endpoints 👀

This is a WIP.

<!-- #### 1.3.1. Instance Service

##### 1.3.1.1. v1

| **Endpoint**                                                                                                              | **Method Name**                                                                                                                                                                                                                                                   |
| ------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [GET /api/v1/instance (deprecated)](https://docs.joinmastodon.org/methods/instance/#v1)                                   | [lookupInformation](https://pub.dev/documentation/kbin_api/latest/kbin_api/InstanceV1Service/lookupInformation.html)                                                                                                                                              |
| [GET /api/v1/instance/peers](https://docs.joinmastodon.org/methods/instance/#peers)                                       | [lookupConnectedDomains](https://pub.dev/documentation/kbin_api/latest/kbin_api/InstanceV1Service/lookupConnectedDomains.html)                                                                                                                                    |
| [GET /api/v1/instance/activity](https://docs.joinmastodon.org/methods/instance/#activity)                                 | [lookupWeeklyActivities](https://pub.dev/documentation/kbin_api/latest/kbin_api/InstanceV1Service/lookupWeeklyActivities.html)                                                                                                                                    |
| [GET /api/v1/instance/rules](https://docs.joinmastodon.org/methods/instance/#rules)                                       | [lookupRules](https://pub.dev/documentation/kbin_api/latest/kbin_api/InstanceV1Service/lookupRules.html)                                                                                                                                                          |
| [GET /api/v1/instance/domain_block](https://docs.joinmastodon.org/methods/instance/#domain_blocks)                        | [lookupBlockedDomains](https://pub.dev/documentation/kbin_api/latest/kbin_api/InstanceV1Service/lookupBlockedDomains.html)                                                                                                                                        |
| [GET /api/v1/example](https://docs.joinmastodon.org/methods/instance/#extended_description)                               | [lookupExtendedDescription](https://pub.dev/documentation/kbin_api/latest/kbin_api/InstanceV1Service/lookupExtendedDescription.html)                                                                                                                              |
| [GET /api/v1/announcements](https://docs.joinmastodon.org/methods/announcements/#get)                                     | [lookupAnnouncements](https://pub.dev/documentation/kbin_api/latest/kbin_api/InstanceV1Service/lookupAnnouncements.html)</br>[lookupActiveAnnouncements](https://pub.dev/documentation/kbin_api/latest/kbin_api/InstanceV1Service/lookupActiveAnnouncements.html) |
| [POST /api/v1/announcements/:id/dismiss](https://docs.joinmastodon.org/methods/announcements/#dismiss)                    | [createMarkAnnouncementAsRead](https://pub.dev/documentation/kbin_api/latest/kbin_api/InstanceV1Service/createMarkAnnouncementAsRead.html)                                                                                                                        |
| [PUT /api/v1/announcements/:id/reactions/:name](https://docs.joinmastodon.org/methods/announcements/#put-reactions)       | [createReactionToAnnouncement](https://pub.dev/documentation/kbin_api/latest/kbin_api/InstanceV1Service/createReactionToAnnouncement.html)                                                                                                                        |
| [DELETE /api/v1/announcements/:id/reactions/:name](https://docs.joinmastodon.org/methods/announcements/#delete-reactions) | [destroyReactionToAnnouncement](https://pub.dev/documentation/kbin_api/latest/kbin_api/InstanceV1Service/destroyReactionToAnnouncement.html)                                                                                                                      |
| [GET /api/v1/custom_emojis](https://docs.joinmastodon.org/methods/custom_emojis/#get)                                     | [lookupAvailableEmoji](https://pub.dev/documentation/kbin_api/latest/kbin_api/InstanceV1Service/lookupAvailableEmoji.html)                                                                                                                                        |
| [GET /api/v1/directory](https://docs.joinmastodon.org/methods/directory/#get)                                             | [lookupAccounts](https://pub.dev/documentation/kbin_api/latest/kbin_api/InstanceV1Service/lookupAccounts.html)                                                                                                                                                    | -->

### 1.4. Tips 🏄

#### 1.4.1. Method Names

**kbin_api** uses the following standard prefixes depending on endpoint characteristics. So it's very easy to find the method corresponding to the endpoint you want to use!

| Prefix      | Description                                                                                        |
| ----------- | -------------------------------------------------------------------------------------------------- |
| **lookup**  | This prefix is attached to endpoints that reference posts, accounts, etc.                          |
| **search**  | This prefix is attached to endpoints that perform extensive searches.                              |
| **connect** | This prefix is attached to endpoints with high-performance streaming.                              |
| **create**  | This prefix is attached to the endpoint performing the create state such as `Post` and `Comment`.  |
| **destroy** | This prefix is attached to the endpoint performing the destroy state such as `Post` and `Comment`. |
| **update**  | This prefix is attached to the endpoint performing the update state.                               |
| **upload**  | This prefix is attached to the endpoint performing the media uploading.                            |
| **verify**  | This prefix is attached to the endpoint performing the verify specific states or values.           |

#### 1.4.2. Null Parameter at Request

In this library, parameters that are not required at request time, i.e., optional parameters, are defined as nullable.
However, developers do not need to be aware of the null parameter when sending requests when using this library.

It means the parameters specified with a null value are safely removed and ignored before the request is sent.

For example, arguments specified with null are ignored in the following request.

```dart
import 'package:kbin_api/kbin_api.dart';

Future<void> main() async {
  final mastodon = KbinApi(
    instance: 'KBIN_INSTANCE',
    bearerToken: 'YOUR_BEARER_TOKEN',
  );

  await mastodon.v1.statuses.createStatus(
    text: 'Toot!',

    //! These parameters are ignored at request because they are null.
    poll: null,
    sensitive: null,
  );
}
```

#### 1.4.4. Change the Timeout Duration

The library specifies a default timeout of **10 seconds** for all API communications.

However, there may be times when you wish to specify an arbitrary timeout duration. If there is such a demand, an arbitrary timeout duration can be specified as follows.

```dart
import 'package:kbin_api/kbin_api.dart';

Future<void> main() {
 final mastodon = KbinApi(
    instance: 'KBIN_INSTANCE',
    bearerToken: 'YOUR_TOKEN_HERE',

    //! The default timeout is 10 seconds.
    timeout: Duration(seconds: 20),
  );
}
```

#### 1.4.5. Automatic Retry

Due to the nature of this library's communication with external systems, timeouts may occur due to inevitable communication failures or temporary crashes of the server to which requests are sent.

When such timeouts occur, an effective countermeasure in many cases is to send the request again after a certain interval. And **kbin_api** provides an **automatic retry** feature as a solution to this problem.

Also, errors subject to retry are as follows.

- When the status code of the response returned from Kbin is `500` or `503`.
- When the network is temporarily lost and a `SocketException` is thrown.
- When communication times out temporarily and a `TimeoutException` is thrown

##### 1.4.5.1. Exponential Backoff and Jitter

Although the algorithm introduced earlier that exponentially increases the retry interval is already powerful, some may believe that it is not yet sufficient to distribute the sensation of retries. It's more distributed than equally spaced retries, but retries still occur at static intervals.

This problem can be solved by adding a random number called **Jitter**, and this method is called the **Exponential Backoff and Jitter** algorithm. By adding a random number to the exponentially increasing retry interval, the retry interval can be distributed more flexibly.

Similar to the previous example, **kbin_api** can be implemented as follows.

```dart
import 'package:kbin_api/kbin_api.dart';

Future<void> main() async {
  final mastodon = KbinApi(
    instance: 'KBIN_INSTANCE',
    bearerToken: 'YOUR_TOKEN_HERE',

    //! Add these lines.
    retryConfig: RetryConfig(
      maxAttempts: 3,
    ),
  );
}
```

In the above implementation, the interval increases exponentially for each retry count with jitter. It can be expressed by next formula.

> **(2 ^ retryCount) + jitter(Random Number between 0 ~ 3)**

##### 1.4.5.2. Do Something on Retry

It would be useful to output logging on retries and a popup notifying the user that a retry has been executed. So **kbin_api** provides callbacks that can perform arbitrary processing when retries are executed.

It can be implemented as follows.

```dart
import 'package:kbin_api/kbin_api.dart';

Future<void> main() async {
  final mastodon = KbinApi(
    instance: 'KBIN_INSTANCE',
    bearerToken: 'YOUR_TOKEN_HERE',
    retryConfig: RetryConfig(
      maxAttempts: 3,

      //! Add this line.
      onExecute: (event) => print('Retrying... ${event.retryCount} times.'),
    ),
  );
}
```

The [RetryEvent](https://pub.dev/documentation/kbin_api/latest/kbin_api/RetryEvent-class.html) passed to the callback contains information on retries.

#### 1.4.6. Thrown Exceptions

**kbin_api** provides a convenient exception object for easy handling of exceptional responses and errors returned from Kbin API.

| Exception                                                                                                                  | Description                                                                                                           |
| -------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------- |
| [KbinException](https://pub.dev/documentation/kbin_api/latest/kbin_api/KbinException-class.html)                           | The most basic exception object. For example, it can be used to search for posts that have already been deleted, etc. |
| [UnauthorizedException](https://pub.dev/documentation/kbin_api/latest/kbin_api/UnauthorizedException-class.html)           | Thrown when authentication fails with the specified access token.                                                     |
| [RateLimitExceededException](https://pub.dev/documentation/kbin_api/latest/kbin_api/RateLimitExceededException-class.html) | Thrown when the request rate limit is exceeded.                                                                       |
| [DataNotFoundException](https://pub.dev/documentation/kbin_api/latest/kbin_api/DataNotFoundException-class.html)           | Thrown when response has no body or data field in body string, or when 404 status is returned.                        |

Also, all of the above exceptions thrown from the **kbin_api** process extend [KbinException](https://pub.dev/documentation/kbin_api/latest/kbin_api/KbinException-class.html). This means that you can take all exceptions as [KbinException](https://pub.dev/documentation/kbin_api/latest/kbin_api/KbinException-class.html) or handle them as certain exception types, depending on the situation.

However note that, if you receive an individual type exception, be sure to define the process so that the individual exception type is cached before [KbinException](https://pub.dev/documentation/kbin_api/latest/kbin_api/KbinException-class.html). Otherwise, certain type exceptions will also be caught as [KbinException](https://pub.dev/documentation/kbin_api/latest/kbin_api/KbinException-class.html).

Therefore, if you need to catch a specific type of exception in addition to [KbinException](https://pub.dev/documentation/kbin_api/latest/kbin_api/KbinException-class.html), be sure to catch [KbinException](https://pub.dev/documentation/kbin_api/latest/kbin_api/KbinException-class.html) in the bottom catch clause as in the following example.

```dart
import 'package:kbin_api/kbin_api.dart';

Future<void> main() async {
  final kbin = KbinApi(
    instance: 'KBIN_INSTANCE',
    bearerToken: 'YOUR_TOKEN_HERE',
  );

  try {
    final response = await kbin.v1.statuses.createStatus(text: 'Toot!');

    print(response);
  } on UnauthorizedException catch (e) {
    print(e);
  } on RateLimitExceededException catch (e) {
    print(e);
  } on KbinException catch (e) {
    print(e);
  }
}
```

### 1.5. Contribution 🏆

If you would like to contribute to **kbin_api**, please create an [issue](https://github.com/geBoolean/kbin_api/issues) or create a Pull Request.

There are many ways to contribute to the OSS. For example, the following subjects can be considered:

- There are request parameters or response fields that are not implemented.
- Documentation is outdated or incomplete.
- Have a better way or idea to achieve the functionality.
- etc...

You can see more details from resources below:

- [Contributor Covenant Code of Conduct](https://github.com/getBoolean/kbin_api/blob/main/CODE_OF_CONDUCT.md)
- [Contribution Guidelines](https://github.com/getBoolean/kbin_api//blob/main/CONTRIBUTING.md)

Or you can create a [discussion](https://github.com/getBoolean/kbin_api/discussions) if you like.

**Feel free to join this development, diverse opinions make software better!**

### 1.6. Support ❤️

The simplest way to show us your support is by **giving the project a star** at [GitHub](https://github.com/getBoolean/kbin/).
<!-- and [Pub.dev](https://pub.dev/packages/kbin_api). -->

### 1.7 License 🔑

All resources of **kbin_api** (formerly **mastodon_api**) is provided under the `BSD-3` license.

```license
Copyright 2023 getBoolean. All rights reserved.
Redistribution and use in source and binary forms, with or without
modification, are permitted provided the conditions.

Copyright 2022 Kato Shinya. All rights reserved.
Redistribution and use in source and binary forms, with or without
modification, are permitted provided the conditions.
```

### 1.8. More Information 🧐

**kbin_api**, formerly **mastodon_api**, was designed and implemented by **_Kato Shinya ([@myConsciousness](https://github.com/myConsciousness))_** and
forked by **[@getBoolean](https://github.com/getBoolean)**.

- [Creator Profile](ttps://github.com/getBoolean)
- [License](https://github.com/getBoolean/kbin_api/blob/main/LICENSE)
<!-- - [API Document](https://pub.dev/documentation/kbin_api/latest/kbin_api/kbin_api-library.html) -->
<!-- - [Release Note](https://github.com/getBoolean/kbin_api/releases) -->
- [Bug Report](https://github.com/getBoolean/kbin_api/issues)
