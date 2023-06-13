// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element

part of 'collection.dart';

class CollectionMapper extends ClassMapperBase<Collection> {
  CollectionMapper._();

  static CollectionMapper? _instance;
  static CollectionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CollectionMapper._());
    }
    return _instance!;
  }

  static T _guard<T>(T Function(MapperContainer) fn) {
    ensureInitialized();
    return fn(MapperContainer.globals);
  }

  @override
  final String id = 'Collection';
  @override
  Function get typeFactory => <T>(f) => f<Collection<T>>();

  static String _$context(Collection v) => v.context;
  static const Field<Collection, String> _f$context =
      Field('context', _$context, key: '@context');
  static String _$id(Collection v) => v.id;
  static const Field<Collection, String> _f$id = Field('id', _$id, key: '@id');
  static String _$type(Collection v) => v.type;
  static const Field<Collection, String> _f$type =
      Field('type', _$type, key: '@type');
  static List<dynamic> _$member(Collection v) => v.member;
  static dynamic _arg$member<T>(f) => f<List<T>>();
  static const Field<Collection, List<dynamic>> _f$member =
      Field('member', _$member, key: 'hydra:member', arg: _arg$member);
  static int _$totalItems(Collection v) => v.totalItems;
  static const Field<Collection, int> _f$totalItems =
      Field('totalItems', _$totalItems, key: 'hydra:totalItems');

  @override
  final Map<Symbol, Field<Collection, dynamic>> fields = const {
    #context: _f$context,
    #id: _f$id,
    #type: _f$type,
    #member: _f$member,
    #totalItems: _f$totalItems,
  };

  static Collection<T> _instantiate<T>(DecodingData data) {
    return Collection(
        context: data.dec(_f$context),
        id: data.dec(_f$id),
        type: data.dec(_f$type),
        member: data.dec(_f$member),
        totalItems: data.dec(_f$totalItems));
  }

  @override
  final Function instantiate = _instantiate;

  static Collection<T> fromMap<T>(Map<String, dynamic> map) {
    return _guard((c) => c.fromMap<Collection<T>>(map));
  }

  static Collection<T> fromJson<T>(String json) {
    return _guard((c) => c.fromJson<Collection<T>>(json));
  }
}

mixin CollectionMappable<T> {
  String toJson() {
    return CollectionMapper._guard((c) => c.toJson(this as Collection<T>));
  }

  Map<String, dynamic> toMap() {
    return CollectionMapper._guard((c) => c.toMap(this as Collection<T>));
  }

  CollectionCopyWith<Collection<T>, Collection<T>, Collection<T>, T>
      get copyWith =>
          _CollectionCopyWithImpl(this as Collection<T>, $identity, $identity);
  @override
  String toString() {
    return CollectionMapper._guard((c) => c.asString(this));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            CollectionMapper._guard((c) => c.isEqual(this, other)));
  }

  @override
  int get hashCode {
    return CollectionMapper._guard((c) => c.hash(this));
  }
}

extension CollectionValueCopy<$R, $Out, T>
    on ObjectCopyWith<$R, Collection<T>, $Out> {
  CollectionCopyWith<$R, Collection<T>, $Out, T> get $asCollection =>
      $base.as((v, t, t2) => _CollectionCopyWithImpl(v, t, t2));
}

abstract class CollectionCopyWith<$R, $In extends Collection<T>, $Out, T>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, T, ObjectCopyWith<$R, T, T>> get member;
  $R call(
      {String? context,
      String? id,
      String? type,
      List<T>? member,
      int? totalItems});
  CollectionCopyWith<$R2, $In, $Out2, T> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CollectionCopyWithImpl<$R, $Out, T>
    extends ClassCopyWithBase<$R, Collection<T>, $Out>
    implements CollectionCopyWith<$R, Collection<T>, $Out, T> {
  _CollectionCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Collection> $mapper =
      CollectionMapper.ensureInitialized();
  @override
  ListCopyWith<$R, T, ObjectCopyWith<$R, T, T>> get member => ListCopyWith(
      $value.member,
      (v, t) => ObjectCopyWith(v, $identity, t),
      (v) => call(member: v));
  @override
  $R call(
          {String? context,
          String? id,
          String? type,
          List<T>? member,
          int? totalItems}) =>
      $apply(FieldCopyWithData({
        if (context != null) #context: context,
        if (id != null) #id: id,
        if (type != null) #type: type,
        if (member != null) #member: member,
        if (totalItems != null) #totalItems: totalItems
      }));
  @override
  Collection<T> $make(CopyWithData data) => Collection(
      context: data.get(#context, or: $value.context),
      id: data.get(#id, or: $value.id),
      type: data.get(#type, or: $value.type),
      member: data.get(#member, or: $value.member),
      totalItems: data.get(#totalItems, or: $value.totalItems));

  @override
  CollectionCopyWith<$R2, Collection<T>, $Out2, T> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _CollectionCopyWithImpl($value, $cast, t);
}
