import 'package:freezed_annotation/freezed_annotation.dart';

part 'kantor.freezed.dart';
part 'kantor.g.dart';

@freezed
class KantorModel with _$KantorModel {
  const factory KantorModel({
    required String basis,
    required String kode,
    required String nama,
  }) = _KantorModel;

  factory KantorModel.fromJson(Map<String, dynamic> json) =>
      _$KantorModelFromJson(json);
}
