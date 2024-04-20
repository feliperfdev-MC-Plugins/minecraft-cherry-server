import 'dart:async';
import 'dart:io';

import 'package:jovial_misc/io_utils.dart';
import 'package:minecraft_server_protocol/data/craft_data_types.dart';
import 'package:minecraft_server_protocol/minecraft_server.dart';
import 'package:minecraft_server_protocol/utils/functions/print_color.dart';

class ClientSession {
  final Socket socket;
  final MinecraftServer server;

  late DataOutputSink output;
  late DataInputStream input;

  ClientSession({
    required this.socket,
    required this.server,
  }) {
    input = DataInputStream(socket.asBroadcastStream());

    Sink<List<int>> list = StreamController();
    output = DataOutputSink(list);
  }

  Future<void> handle() async {
    try {
      while (!isClosed) {
        int len = await CraftDataTypes.readVarInt(input);
        int id = await CraftDataTypes.readVarInt(input);
        final data = (len - CraftDataTypes.getVarIntSize(id)).bitLength;
        await input.readBytes(data);

        printColor(id.toString(), Color.blue);
      }
    } catch (e, st) {
      printColor(e.toString(), Color.red);
      printColor('\n$st', Color.magenta);
    }
  }

  bool get isClosed => server.isClosed;

  Future<void> close() async {}
}
