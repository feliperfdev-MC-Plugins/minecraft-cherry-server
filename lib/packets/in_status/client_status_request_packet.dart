import 'package:minecraft_server_protocol/packets/packet.dart';

class ClientStatusRequestPacket extends Packet {
  ClientStatusRequestPacket();

  ClientStatusRequestPacket.writeBytes(super.data) : super.writeBytes();
}
