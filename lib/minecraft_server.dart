import 'dart:io';
import 'dart:isolate';

import 'package:minecraft_server_protocol/client_session.dart';
import 'package:minecraft_server_protocol/utils/functions/print_color.dart';

class MinecraftServer {
  final String host;
  final int port;

  MinecraftServer({
    required this.host,
    required this.port,
  });

  late ServerSocket _server;
  var _isClosed = false;
  late ClientSession _session;

  final pool = Isolate.spawn((_) => {}, '');

  Future<void> start() async {
    _server = await ServerSocket.bind(host, port);
    printColor(
        "Server is running on: ${_server.address.address}:${_server.port}",
        Color.green);
    _server.listen((socket) async {
      printColor("Listening ${socket.remoteAddress.address}", Color.yellow);
      try {
        _session = ClientSession(socket: socket, server: this);
        await _session.handle();
      } catch (e) {
        printColor(e.toString(), Color.red);
        await _session.close();
      }
    });
  }

  bool get isClosed => _isClosed;

  Future<void> close() async {
    if (!isClosed) {
      await Future.wait([_server.close(), _session.close()]);
      _isClosed = true;
    }
  }
}
