import 'package:dart_mappable/dart_mappable.dart';

part 'image.mapper.dart';

/// Raw JSON:
///
/// ```json
/// {
///   "@id": "/api/images/56",
///   "@type": "image",
///   "filePath": "08/8e/088e62b44d8a946015e2fb1378ef6866c3e1b059107b67e7391d7b1c7ca7c40b.jpg",
///   "width": 2048,
///   "height": 1024
/// }
/// ```
@MappableClass()
class Image with ImageMappable {
  @MappableField(key: '@id')
  final String id;
  @MappableField(key: '@type')
  final String type;
  final String filePath;
  final int width;
  final int height;

  const Image({
    required this.id,
    required this.type,
    required this.filePath,
    required this.width,
    required this.height,
  });

  static const fromMap = ImageMapper.fromMap;
  static const fromJson = ImageMapper.fromJson;
}
