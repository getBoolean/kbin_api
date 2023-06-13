// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element

part of 'image.dart';

class ImageMapper extends ClassMapperBase<Image> {
  ImageMapper._();

  static ImageMapper? _instance;
  static ImageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ImageMapper._());
    }
    return _instance!;
  }

  static T _guard<T>(T Function(MapperContainer) fn) {
    ensureInitialized();
    return fn(MapperContainer.globals);
  }

  @override
  final String id = 'Image';

  static String _$id(Image v) => v.id;
  static const Field<Image, String> _f$id = Field('id', _$id, key: '@id');
  static String _$type(Image v) => v.type;
  static const Field<Image, String> _f$type =
      Field('type', _$type, key: '@type');
  static String _$filePath(Image v) => v.filePath;
  static const Field<Image, String> _f$filePath = Field('filePath', _$filePath);
  static int _$width(Image v) => v.width;
  static const Field<Image, int> _f$width = Field('width', _$width);
  static int _$height(Image v) => v.height;
  static const Field<Image, int> _f$height = Field('height', _$height);

  @override
  final Map<Symbol, Field<Image, dynamic>> fields = const {
    #id: _f$id,
    #type: _f$type,
    #filePath: _f$filePath,
    #width: _f$width,
    #height: _f$height,
  };

  static Image _instantiate(DecodingData data) {
    return Image(
        id: data.dec(_f$id),
        type: data.dec(_f$type),
        filePath: data.dec(_f$filePath),
        width: data.dec(_f$width),
        height: data.dec(_f$height));
  }

  @override
  final Function instantiate = _instantiate;

  static Image fromMap(Map<String, dynamic> map) {
    return _guard((c) => c.fromMap<Image>(map));
  }

  static Image fromJson(String json) {
    return _guard((c) => c.fromJson<Image>(json));
  }
}

mixin ImageMappable {
  String toJson() {
    return ImageMapper._guard((c) => c.toJson(this as Image));
  }

  Map<String, dynamic> toMap() {
    return ImageMapper._guard((c) => c.toMap(this as Image));
  }

  ImageCopyWith<Image, Image, Image> get copyWith =>
      _ImageCopyWithImpl(this as Image, $identity, $identity);
  @override
  String toString() {
    return ImageMapper._guard((c) => c.asString(this));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            ImageMapper._guard((c) => c.isEqual(this, other)));
  }

  @override
  int get hashCode {
    return ImageMapper._guard((c) => c.hash(this));
  }
}

extension ImageValueCopy<$R, $Out> on ObjectCopyWith<$R, Image, $Out> {
  ImageCopyWith<$R, Image, $Out> get $asImage =>
      $base.as((v, t, t2) => _ImageCopyWithImpl(v, t, t2));
}

abstract class ImageCopyWith<$R, $In extends Image, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? id, String? type, String? filePath, int? width, int? height});
  ImageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ImageCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Image, $Out>
    implements ImageCopyWith<$R, Image, $Out> {
  _ImageCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Image> $mapper = ImageMapper.ensureInitialized();
  @override
  $R call(
          {String? id,
          String? type,
          String? filePath,
          int? width,
          int? height}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (type != null) #type: type,
        if (filePath != null) #filePath: filePath,
        if (width != null) #width: width,
        if (height != null) #height: height
      }));
  @override
  Image $make(CopyWithData data) => Image(
      id: data.get(#id, or: $value.id),
      type: data.get(#type, or: $value.type),
      filePath: data.get(#filePath, or: $value.filePath),
      width: data.get(#width, or: $value.width),
      height: data.get(#height, or: $value.height));

  @override
  ImageCopyWith<$R2, Image, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ImageCopyWithImpl($value, $cast, t);
}
