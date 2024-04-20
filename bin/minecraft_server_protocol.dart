import 'dart:io';

import 'package:minecraft_server_protocol/minecraft_server.dart';

void main(List<String> arguments) async {
  final server = MinecraftServer(
    host: InternetAddress.anyIPv4.address,
    port: int.tryParse(arguments.first) ?? 8002,
  );

  await server.start();
}
