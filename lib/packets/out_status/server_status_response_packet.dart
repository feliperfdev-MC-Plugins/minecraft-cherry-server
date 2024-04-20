import 'package:minecraft_server_protocol/packets/packet.dart';

import '../../data/craft_data_types.dart';

class ServerStatusResponsePacket extends Packet {
  ServerStatusResponsePacket.writeBytes(List<int> data, String json)
      : super.writeBytes(data.isNotEmpty ? data : [0x00]) {
    CraftDataTypes.writeString(wrapper, json);
  }
}
