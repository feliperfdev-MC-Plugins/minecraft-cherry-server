import 'package:jovial_misc/io_utils.dart';
import 'package:minecraft_server_protocol/data/craft_data_types.dart';
import 'package:minecraft_server_protocol/packets/packet.dart';

class HandshakePacket extends Packet {
  late int protocol;
  late int state;
  late int port;
  late String host;

  HandshakePacket();

  HandshakePacket.writeBytes(super.data) : super.writeBytes() {
    DataInputStream input = getDataIStream();
    CraftDataTypes.readVarInt(input).then((protocolValue) {
      protocol = protocolValue;
    });
    CraftDataTypes.readString(input).then((hostString) {
      host = hostString;
    });
    input.readShort().then((value) {
      port = value;
    });
    input.readByte().then((value) {
      state = value;
    });
  }
}
