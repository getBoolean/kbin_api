import 'package:dart_mappable/dart_mappable.dart';

part 'collection.mapper.dart';

/// Raw JSON:
///
/// ```json
/// {
///   "@context": "/api/contexts/magazine",
///   "@id": "/api/magazines",
///   "@type": "hydra:Collection",
///   "hydra:member": [],
///   "hydra:totalItems": 13
/// }
/// ```
@MappableClass()
class Collection<T> with CollectionMappable<T> {
  @MappableField(key: '@context')
  final String context;
  @MappableField(key: '@id')
  final String id;
  @MappableField(key: '@type')
  final String type;
  @MappableField(key: 'hydra:member')
  final List<T> member;
  @MappableField(key: 'hydra:totalItems')
  final int totalItems;

  // final View? view;

  const Collection({
    required this.context,
    required this.id,
    required this.type,
    required this.member,
    required this.totalItems,
  });

  static const fromMap = CollectionMapper.fromMap;
  static const fromJson = CollectionMapper.fromJson;
}
