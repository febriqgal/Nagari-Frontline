import 'package:nagarifrontline/data/local/kantor.dart';
import 'package:nagarifrontline/model/kantor/kantor.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kantor.g.dart';

@riverpod
class Kantor extends _$Kantor {
  @override
  List<KantorModel> build() {
    List<KantorModel> kantorList =
        dataKantor.map((json) => KantorModel.fromJson(json)).toList();
    return kantorList;
  }
}
