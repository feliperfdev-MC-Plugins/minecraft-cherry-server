import 'dart:async';
import 'dart:io';

import 'package:jovial_misc/io_utils.dart';
import 'package:minecraft_server_protocol/annotated_packet_handler.dart';
import 'package:minecraft_server_protocol/data/craft_data_types.dart';
import 'package:minecraft_server_protocol/data/game_state.dart';
import 'package:minecraft_server_protocol/minecraft_server.dart';
import 'package:minecraft_server_protocol/packets/packet_registry.dart';
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
    output = DataOutputSink(StreamController<List<int>>());
  }

  GameState state = GameState.handshake;

  int protocol = -1;

  AnnotatedPacketHandler get handler => AnnotatedPacketHandler(session: this);

  Future<void> handle() async {
    try {
      while (!isClosed) {
        int len = await CraftDataTypes.readVarInt(input);
        int id = await CraftDataTypes.readVarInt(input);
        final data = (len - CraftDataTypes.getVarIntSize(id)).bitLength;
        await input.readBytes(data);

        printColor(id.toString(), Color.blue);

        final packet = PacketRegistry.getPacketById(state, id);
        if (packet != null) {
          handler.handle(packet);
        } else {
          printColor('PACKET IS NULL!!!', Color.red);
        }
      }
    } on EOFException catch (e, st) {
      printColor(
          '\nEND OF FILE (EOF) Exception!! Leaving server...', Color.red);
      printColor(st.toString(), Color.magenta);
    } catch (e, st) {
      printColor(e.toString(), Color.red);
      printColor('\n$st', Color.magenta);
    }
  }

  bool get isClosed => server.isClosed;

  Future<void> close() => Future.wait([socket.close(), server.close()]);
}
