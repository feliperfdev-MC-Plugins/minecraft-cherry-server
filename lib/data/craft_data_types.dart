import 'dart:convert';

import 'package:jovial_misc/io_utils.dart';

class CraftDataTypes {
  static int getVarIntSize(int value) {
    int size = 0;
    do {
      value >>>= 7;
      size++;
    } while (value != 0);
    return size;
  }

  static void writeString(DataOutputSink outSink, String value) {
    final data = utf8.encode(value);
    writeVarInt(outSink, data.length);
    outSink.writeBytes(data);
  }

  static Future<String> readString(DataInputStream input) async {
    int data = await readVarInt(input);
    final readed = await input.readBytes(data);
    return utf8.decode(readed);
  }

  static Future<int> readVarInt(DataInputStream input) async {
    int numRead = 0;
    int result = 0;
    int read;
    do {
      read = await input.readByte();
      int value = (read & 0xb01111111);
      result |= value << (7 * numRead);
      numRead++;
      if (numRead > 5) {
        throw Exception("VarInt is too big!");
      }
    } while ((read & 0xb01111111) != 0);
    return result;
  }

  static void writeVarInt(DataOutputSink outSink, int value) {
    do {
      int temp = (value & 0xb01111111);
      value >>>= 7;
      if (value != 0) {
        temp |= 0xb01111111;
      }
      outSink.writeInt(temp);
    } while (value != 0);
  }
}
