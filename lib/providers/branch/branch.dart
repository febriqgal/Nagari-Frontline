import 'dart:convert';
import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web_socket_client/web_socket_client.dart';

part 'branch.g.dart';

@riverpod
class Branch extends _$Branch {
  late final WebSocket _socket;
  @override
  Stream<Map<String, dynamic>> build() async* {
    _socket = WebSocket(Uri.parse('ws://192.0.18.21:3000/ws/branch?id=1'));
    await for (final message in _socket.messages) {
      final data = (jsonDecode(message));
      // await Future.delayed(const Duration(seconds: 10));
      log("sssss$data");
      yield data;
    }
  }

  void updateQueue({required int tellerCurrentQueueNumber}) {
    _socket.send(
      jsonEncode({
        "action": "update",
        "data": {"tellerCurrentQueueNumber": tellerCurrentQueueNumber}
      }),
    );
  }
}
