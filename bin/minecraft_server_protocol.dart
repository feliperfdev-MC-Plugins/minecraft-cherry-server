import 'dart:io';

import 'package:minecraft_server_protocol/minecraft_server.dart';

void main(List<String> arguments) async {
  final server = MinecraftServer(
    host: InternetAddress.anyIPv4.address,
    port: int.tryParse(arguments.firstOrNull ?? '') ?? 8002,
  );

  try {
    await server.start();
  } catch (e) {
    if (!server.isClosed) {
      await server.close();
    }
  }
}
