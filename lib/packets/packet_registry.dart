import 'package:minecraft_server_protocol/packets/handshake_packet.dart';
import 'package:minecraft_server_protocol/packets/in_status/client_status_ping_packet.dart';
import 'package:minecraft_server_protocol/packets/in_status/client_status_request_packet.dart';
import 'package:minecraft_server_protocol/utils/functions/print_color.dart';

import '../data/game_state.dart';
import 'packet.dart';

class PacketRegistry {
  static final Map<GameState, Map<int, Packet>> _packets = {}
    ..putIfAbsent(GameState.login, () => <int, Packet>{})
    ..putIfAbsent(GameState.play, () => <int, Packet>{})
    ..putIfAbsent(
      GameState.status,
      () {
        final map = <int, Packet>{};
        map.putIfAbsent(0x00, () => ClientStatusRequestPacket());
        map.putIfAbsent(0x01, () => ClientStatusPingPacket());

        return map;
      },
    )
    ..putIfAbsent(
      GameState.handshake,
      () {
        final map = <int, Packet>{};
        map.putIfAbsent(0x00, () => HandshakePacket());

        return map;
      },
    );

  static Packet? getPacketById(GameState state, int id) {
    if (_packets[state]?[id] != null) {
      printColor('Packet ready! ID = $id', Color.cyan);
    }

    return _packets[state]?[id];
  }
}
