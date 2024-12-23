// A shared state that can be accessed by multiple widgets at the same time.
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ping.g.dart';

@riverpod
class Ping extends _$Ping {
  final _dio = Dio();

  @override
  Future<String> build({required String url}) async {
    try {
      final response = await _dio.get(url);
      await Future.delayed(
        const Duration(seconds: 2),
      );
      return response.data;
    } catch (e) {
      return "error";
    }
  }
}
