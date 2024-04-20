import 'package:minecraft_server_protocol/packets/packet.dart';

class ClientStatusPingPacket extends Packet {
  late int _payload;

  ClientStatusPingPacket();

  ClientStatusPingPacket.writeBytes(super.data) : super.writeBytes() {
    getDataIStream().readLong().then((value) {
      _payload = value;
    });
  }

  int get payload => _payload;
}
