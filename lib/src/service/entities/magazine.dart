import 'package:dart_mappable/dart_mappable.dart';

import 'image.dart';
import 'user.dart';

// import 'user.dart';

part 'magazine.mapper.dart';

/// Magazine, AKA "subreddit"
///
/// Raw JSON:
///
/// ```json
/// {
///   "@context": "/api/contexts/magazine",
///   "@id": "/api/magazines/rust",
///   "@type": "magazine",
///   "user": {
///     "@id": "/api/users/ernest",
///     "@type": "user",
///     "username": "ernest",
///     "avatar": []
///   },
///   "cover": {
///     "@id": "/api/images/56",
///     "@type": "image",
///     "filePath": "08/8e/088e62b44d8a946015e2fb1378ef6866c3e1b059107b67e7391d7b1c7ca7c40b.jpg",
///     "width": 2048,
///     "height": 1024
///   },
///   "name": "rust",
///   "title": "rust",
///   "description": null,
///   "rules": null,
///   "subscriptionsCount": 1,
///   "entryCount": 1,
///   "entryCommentCount": 0,
///   "postCount": 0,
///   "postCommentCount": 0,
///   "isAdult": false
/// }
/// ```
@MappableClass()
class Magazine with MagazineMappable {
  @MappableField(key: '@id')
  final String id;
  @MappableField(key: '@type')
  final String type;
  final User user;
  final Image? cover;
  final String name;
  final String title;
  final String? description;
  final String? rules;
  final int subscriptionsCount;
  final int entryCount;
  final int entryCommentCount;
  final int postCount;
  final int postCommentCount;
  final bool isAdult;

  const Magazine({
    required this.id,
    required this.type,
    required this.user,
    this.cover,
    required this.name,
    required this.title,
    this.description,
    this.rules,
    required this.subscriptionsCount,
    required this.entryCount,
    required this.entryCommentCount,
    required this.postCount,
    required this.postCommentCount,
    required this.isAdult,
  });

  static const fromMap = MagazineMapper.fromMap;
  static const fromJson = MagazineMapper.fromJson;
}
