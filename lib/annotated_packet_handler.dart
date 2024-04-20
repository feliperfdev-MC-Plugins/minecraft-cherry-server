import 'package:minecraft_server_protocol/client_session.dart';
import 'package:minecraft_server_protocol/packets/packet.dart';

class AnnotatedPacketHandler {
  final ClientSession session;

  AnnotatedPacketHandler({
    required this.session,
  });

  void onPing() {}
  void onStatusRequest() {}
  void onHandshake() {}
  void handle(Packet packet, [List<String>? params]) {}
}
