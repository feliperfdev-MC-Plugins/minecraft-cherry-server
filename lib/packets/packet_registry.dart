import '../data/game_state.dart';
import 'packet.dart';

class PacketRegistry {
  static final Map<GameState, Map<int, Packet>> _packets = {}
    ..putIfAbsent(GameState.login, () => <int, Packet>{})
    ..putIfAbsent(GameState.play, () => <int, Packet>{})
    ..putIfAbsent(GameState.status, () => <int, Packet>{})
    ..putIfAbsent(GameState.handshake, () => <int, Packet>{});

  static Packet? getPacketById(GameState state, int id) {
    return _packets[state]?[id];
  }
}
