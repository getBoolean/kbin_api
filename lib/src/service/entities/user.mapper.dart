// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element

part of 'user.dart';

class UserMapper extends ClassMapperBase<User> {
  UserMapper._();

  static UserMapper? _instance;
  static UserMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UserMapper._());
      ImageMapper.ensureInitialized();
    }
    return _instance!;
  }

  static T _guard<T>(T Function(MapperContainer) fn) {
    ensureInitialized();
    return fn(MapperContainer.globals);
  }

  @override
  final String id = 'User';

  static String _$id(User v) => v.id;
  static const Field<User, String> _f$id = Field('id', _$id, key: '@id');
  static String _$type(User v) => v.type;
  static const Field<User, String> _f$type =
      Field('type', _$type, key: '@type');
  static String? _$username(User v) => v.username;
  static const Field<User, String> _f$username =
      Field('username', _$username, opt: true);
  static Image? _$avatar(User v) => v.avatar;
  static const Field<User, Image> _f$avatar =
      Field('avatar', _$avatar, opt: true);

  @override
  final Map<Symbol, Field<User, dynamic>> fields = const {
    #id: _f$id,
    #type: _f$type,
    #username: _f$username,
    #avatar: _f$avatar,
  };

  static User _instantiate(DecodingData data) {
    return User(
        id: data.dec(_f$id),
        type: data.dec(_f$type),
        username: data.dec(_f$username),
        avatar: data.dec(_f$avatar));
  }

  @override
  final Function instantiate = _instantiate;

  static User fromMap(Map<String, dynamic> map) {
    return _guard((c) => c.fromMap<User>(map));
  }

  static User fromJson(String json) {
    return _guard((c) => c.fromJson<User>(json));
  }
}

mixin UserMappable {
  String toJson() {
    return UserMapper._guard((c) => c.toJson(this as User));
  }

  Map<String, dynamic> toMap() {
    return UserMapper._guard((c) => c.toMap(this as User));
  }

  UserCopyWith<User, User, User> get copyWith =>
      _UserCopyWithImpl(this as User, $identity, $identity);
  @override
  String toString() {
    return UserMapper._guard((c) => c.asString(this));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            UserMapper._guard((c) => c.isEqual(this, other)));
  }

  @override
  int get hashCode {
    return UserMapper._guard((c) => c.hash(this));
  }
}

extension UserValueCopy<$R, $Out> on ObjectCopyWith<$R, User, $Out> {
  UserCopyWith<$R, User, $Out> get $asUser =>
      $base.as((v, t, t2) => _UserCopyWithImpl(v, t, t2));
}

abstract class UserCopyWith<$R, $In extends User, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ImageCopyWith<$R, Image, Image>? get avatar;
  $R call({String? id, String? type, String? username, Image? avatar});
  UserCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _UserCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, User, $Out>
    implements UserCopyWith<$R, User, $Out> {
  _UserCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<User> $mapper = UserMapper.ensureInitialized();
  @override
  ImageCopyWith<$R, Image, Image>? get avatar =>
      $value.avatar?.copyWith.$chain((v) => call(avatar: v));
  @override
  $R call(
          {String? id,
          String? type,
          Object? username = $none,
          Object? avatar = $none}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (type != null) #type: type,
        if (username != $none) #username: username,
        if (avatar != $none) #avatar: avatar
      }));
  @override
  User $make(CopyWithData data) => User(
      id: data.get(#id, or: $value.id),
      type: data.get(#type, or: $value.type),
      username: data.get(#username, or: $value.username),
      avatar: data.get(#avatar, or: $value.avatar));

  @override
  UserCopyWith<$R2, User, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _UserCopyWithImpl($value, $cast, t);
}
