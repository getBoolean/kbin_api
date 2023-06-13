import 'package:dart_mappable/dart_mappable.dart';
import 'image.dart';

part 'user.mapper.dart';

/// Raw JSON:
///
/// ```json
/// {
///   "@id": "/api/users/ernest",
///   "@type": "user",
///   "username": "ernest",
///   "avatar": {
///     "@id": "/api/images/54",
///     "@type": "image",
///     "filePath": "89/bf/89bf6b16d2516c0756275aacbc88f443c45076c554e3e19b132c3ffd9e8356ee.jpg",
///     "width": 978,
///     "height": 931
///   }
/// }
/// ```
@MappableClass()
class User with UserMappable {
  @MappableField(key: '@id')
  final String id;
  @MappableField(key: '@type')
  final String type;
  final String? username;
  final Image? avatar;

  const User({
    required this.id,
    required this.type,
    this.username,
    this.avatar,
  });

  static const fromMap = UserMapper.fromMap;
  static const fromJson = UserMapper.fromJson;
}
