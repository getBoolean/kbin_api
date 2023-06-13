// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element

part of 'magazine.dart';

class MagazineMapper extends ClassMapperBase<Magazine> {
  MagazineMapper._();

  static MagazineMapper? _instance;
  static MagazineMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MagazineMapper._());
      UserMapper.ensureInitialized();
      ImageMapper.ensureInitialized();
    }
    return _instance!;
  }

  static T _guard<T>(T Function(MapperContainer) fn) {
    ensureInitialized();
    return fn(MapperContainer.globals);
  }

  @override
  final String id = 'Magazine';

  static String _$id(Magazine v) => v.id;
  static const Field<Magazine, String> _f$id = Field('id', _$id, key: '@id');
  static String _$type(Magazine v) => v.type;
  static const Field<Magazine, String> _f$type =
      Field('type', _$type, key: '@type');
  static User _$user(Magazine v) => v.user;
  static const Field<Magazine, User> _f$user = Field('user', _$user);
  static Image? _$cover(Magazine v) => v.cover;
  static const Field<Magazine, Image> _f$cover =
      Field('cover', _$cover, opt: true);
  static String _$name(Magazine v) => v.name;
  static const Field<Magazine, String> _f$name = Field('name', _$name);
  static String _$title(Magazine v) => v.title;
  static const Field<Magazine, String> _f$title = Field('title', _$title);
  static String? _$description(Magazine v) => v.description;
  static const Field<Magazine, String> _f$description =
      Field('description', _$description, opt: true);
  static String? _$rules(Magazine v) => v.rules;
  static const Field<Magazine, String> _f$rules =
      Field('rules', _$rules, opt: true);
  static int _$subscriptionsCount(Magazine v) => v.subscriptionsCount;
  static const Field<Magazine, int> _f$subscriptionsCount =
      Field('subscriptionsCount', _$subscriptionsCount);
  static int _$entryCount(Magazine v) => v.entryCount;
  static const Field<Magazine, int> _f$entryCount =
      Field('entryCount', _$entryCount);
  static int _$entryCommentCount(Magazine v) => v.entryCommentCount;
  static const Field<Magazine, int> _f$entryCommentCount =
      Field('entryCommentCount', _$entryCommentCount);
  static int _$postCount(Magazine v) => v.postCount;
  static const Field<Magazine, int> _f$postCount =
      Field('postCount', _$postCount);
  static int _$postCommentCount(Magazine v) => v.postCommentCount;
  static const Field<Magazine, int> _f$postCommentCount =
      Field('postCommentCount', _$postCommentCount);
  static bool _$isAdult(Magazine v) => v.isAdult;
  static const Field<Magazine, bool> _f$isAdult = Field('isAdult', _$isAdult);

  @override
  final Map<Symbol, Field<Magazine, dynamic>> fields = const {
    #id: _f$id,
    #type: _f$type,
    #user: _f$user,
    #cover: _f$cover,
    #name: _f$name,
    #title: _f$title,
    #description: _f$description,
    #rules: _f$rules,
    #subscriptionsCount: _f$subscriptionsCount,
    #entryCount: _f$entryCount,
    #entryCommentCount: _f$entryCommentCount,
    #postCount: _f$postCount,
    #postCommentCount: _f$postCommentCount,
    #isAdult: _f$isAdult,
  };

  static Magazine _instantiate(DecodingData data) {
    return Magazine(
        id: data.dec(_f$id),
        type: data.dec(_f$type),
        user: data.dec(_f$user),
        cover: data.dec(_f$cover),
        name: data.dec(_f$name),
        title: data.dec(_f$title),
        description: data.dec(_f$description),
        rules: data.dec(_f$rules),
        subscriptionsCount: data.dec(_f$subscriptionsCount),
        entryCount: data.dec(_f$entryCount),
        entryCommentCount: data.dec(_f$entryCommentCount),
        postCount: data.dec(_f$postCount),
        postCommentCount: data.dec(_f$postCommentCount),
        isAdult: data.dec(_f$isAdult));
  }

  @override
  final Function instantiate = _instantiate;

  static Magazine fromMap(Map<String, dynamic> map) {
    return _guard((c) => c.fromMap<Magazine>(map));
  }

  static Magazine fromJson(String json) {
    return _guard((c) => c.fromJson<Magazine>(json));
  }
}

mixin MagazineMappable {
  String toJson() {
    return MagazineMapper._guard((c) => c.toJson(this as Magazine));
  }

  Map<String, dynamic> toMap() {
    return MagazineMapper._guard((c) => c.toMap(this as Magazine));
  }

  MagazineCopyWith<Magazine, Magazine, Magazine> get copyWith =>
      _MagazineCopyWithImpl(this as Magazine, $identity, $identity);
  @override
  String toString() {
    return MagazineMapper._guard((c) => c.asString(this));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            MagazineMapper._guard((c) => c.isEqual(this, other)));
  }

  @override
  int get hashCode {
    return MagazineMapper._guard((c) => c.hash(this));
  }
}

extension MagazineValueCopy<$R, $Out> on ObjectCopyWith<$R, Magazine, $Out> {
  MagazineCopyWith<$R, Magazine, $Out> get $asMagazine =>
      $base.as((v, t, t2) => _MagazineCopyWithImpl(v, t, t2));
}

abstract class MagazineCopyWith<$R, $In extends Magazine, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  UserCopyWith<$R, User, User> get user;
  ImageCopyWith<$R, Image, Image>? get cover;
  $R call(
      {String? id,
      String? type,
      User? user,
      Image? cover,
      String? name,
      String? title,
      String? description,
      String? rules,
      int? subscriptionsCount,
      int? entryCount,
      int? entryCommentCount,
      int? postCount,
      int? postCommentCount,
      bool? isAdult});
  MagazineCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _MagazineCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Magazine, $Out>
    implements MagazineCopyWith<$R, Magazine, $Out> {
  _MagazineCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Magazine> $mapper =
      MagazineMapper.ensureInitialized();
  @override
  UserCopyWith<$R, User, User> get user =>
      $value.user.copyWith.$chain((v) => call(user: v));
  @override
  ImageCopyWith<$R, Image, Image>? get cover =>
      $value.cover?.copyWith.$chain((v) => call(cover: v));
  @override
  $R call(
          {String? id,
          String? type,
          User? user,
          Object? cover = $none,
          String? name,
          String? title,
          Object? description = $none,
          Object? rules = $none,
          int? subscriptionsCount,
          int? entryCount,
          int? entryCommentCount,
          int? postCount,
          int? postCommentCount,
          bool? isAdult}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (type != null) #type: type,
        if (user != null) #user: user,
        if (cover != $none) #cover: cover,
        if (name != null) #name: name,
        if (title != null) #title: title,
        if (description != $none) #description: description,
        if (rules != $none) #rules: rules,
        if (subscriptionsCount != null) #subscriptionsCount: subscriptionsCount,
        if (entryCount != null) #entryCount: entryCount,
        if (entryCommentCount != null) #entryCommentCount: entryCommentCount,
        if (postCount != null) #postCount: postCount,
        if (postCommentCount != null) #postCommentCount: postCommentCount,
        if (isAdult != null) #isAdult: isAdult
      }));
  @override
  Magazine $make(CopyWithData data) => Magazine(
      id: data.get(#id, or: $value.id),
      type: data.get(#type, or: $value.type),
      user: data.get(#user, or: $value.user),
      cover: data.get(#cover, or: $value.cover),
      name: data.get(#name, or: $value.name),
      title: data.get(#title, or: $value.title),
      description: data.get(#description, or: $value.description),
      rules: data.get(#rules, or: $value.rules),
      subscriptionsCount:
          data.get(#subscriptionsCount, or: $value.subscriptionsCount),
      entryCount: data.get(#entryCount, or: $value.entryCount),
      entryCommentCount:
          data.get(#entryCommentCount, or: $value.entryCommentCount),
      postCount: data.get(#postCount, or: $value.postCount),
      postCommentCount:
          data.get(#postCommentCount, or: $value.postCommentCount),
      isAdult: data.get(#isAdult, or: $value.isAdult));

  @override
  MagazineCopyWith<$R2, Magazine, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _MagazineCopyWithImpl($value, $cast, t);
}
