// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kantor.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

KantorModel _$KantorModelFromJson(Map<String, dynamic> json) {
  return _KantorModel.fromJson(json);
}

/// @nodoc
mixin _$KantorModel {
  String get basis => throw _privateConstructorUsedError;
  String get kode => throw _privateConstructorUsedError;
  String get nama => throw _privateConstructorUsedError;

  /// Serializes this KantorModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of KantorModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $KantorModelCopyWith<KantorModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KantorModelCopyWith<$Res> {
  factory $KantorModelCopyWith(
          KantorModel value, $Res Function(KantorModel) then) =
      _$KantorModelCopyWithImpl<$Res, KantorModel>;
  @useResult
  $Res call({String basis, String kode, String nama});
}

/// @nodoc
class _$KantorModelCopyWithImpl<$Res, $Val extends KantorModel>
    implements $KantorModelCopyWith<$Res> {
  _$KantorModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of KantorModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? basis = null,
    Object? kode = null,
    Object? nama = null,
  }) {
    return _then(_value.copyWith(
      basis: null == basis
          ? _value.basis
          : basis // ignore: cast_nullable_to_non_nullable
              as String,
      kode: null == kode
          ? _value.kode
          : kode // ignore: cast_nullable_to_non_nullable
              as String,
      nama: null == nama
          ? _value.nama
          : nama // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$KantorModelImplCopyWith<$Res>
    implements $KantorModelCopyWith<$Res> {
  factory _$$KantorModelImplCopyWith(
          _$KantorModelImpl value, $Res Function(_$KantorModelImpl) then) =
      __$$KantorModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String basis, String kode, String nama});
}

/// @nodoc
class __$$KantorModelImplCopyWithImpl<$Res>
    extends _$KantorModelCopyWithImpl<$Res, _$KantorModelImpl>
    implements _$$KantorModelImplCopyWith<$Res> {
  __$$KantorModelImplCopyWithImpl(
      _$KantorModelImpl _value, $Res Function(_$KantorModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of KantorModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? basis = null,
    Object? kode = null,
    Object? nama = null,
  }) {
    return _then(_$KantorModelImpl(
      basis: null == basis
          ? _value.basis
          : basis // ignore: cast_nullable_to_non_nullable
              as String,
      kode: null == kode
          ? _value.kode
          : kode // ignore: cast_nullable_to_non_nullable
              as String,
      nama: null == nama
          ? _value.nama
          : nama // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$KantorModelImpl implements _KantorModel {
  const _$KantorModelImpl(
      {required this.basis, required this.kode, required this.nama});

  factory _$KantorModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$KantorModelImplFromJson(json);

  @override
  final String basis;
  @override
  final String kode;
  @override
  final String nama;

  @override
  String toString() {
    return 'KantorModel(basis: $basis, kode: $kode, nama: $nama)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KantorModelImpl &&
            (identical(other.basis, basis) || other.basis == basis) &&
            (identical(other.kode, kode) || other.kode == kode) &&
            (identical(other.nama, nama) || other.nama == nama));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, basis, kode, nama);

  /// Create a copy of KantorModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$KantorModelImplCopyWith<_$KantorModelImpl> get copyWith =>
      __$$KantorModelImplCopyWithImpl<_$KantorModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KantorModelImplToJson(
      this,
    );
  }
}

abstract class _KantorModel implements KantorModel {
  const factory _KantorModel(
      {required final String basis,
      required final String kode,
      required final String nama}) = _$KantorModelImpl;

  factory _KantorModel.fromJson(Map<String, dynamic> json) =
      _$KantorModelImpl.fromJson;

  @override
  String get basis;
  @override
  String get kode;
  @override
  String get nama;

  /// Create a copy of KantorModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KantorModelImplCopyWith<_$KantorModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
