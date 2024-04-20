import 'package:minecraft_server_protocol/packets/packet.dart';

class ServerStatusPongPacket extends Packet {
  ServerStatusPongPacket.writeBytes(List<int> data, int payload)
      : super.writeBytes(data.isNotEmpty ? data : [0x01]) {
    super.wrapper.writeByte(payload);
  }
}
