import 'dart:async';

import 'package:jovial_misc/io_utils.dart';
import 'package:minecraft_server_protocol/data/craft_data_types.dart';

class Packet {
  StreamController<List<int>> get _buffer => StreamController<List<int>>();
  DataOutputSink get _wrapper =>
      DataOutputSink(StreamController(onListen: () => _buffer));

  Packet.writeBytes(List<int> data) {
    _wrapper.writeBytes(data);
  }

  Packet.writeVarInt(int id) {
    CraftDataTypes.writeVarInt(_wrapper, id);
  }

  DataInputStream getDataIStream() => DataInputStream(_buffer.stream);

  set _buffer(StreamController<List<int>> buffer) {
    _buffer = buffer;
  }

  Stream<List<int>> getData() {
    List<int> raw = [];
    _buffer.stream.listen((event) {
      raw = event;
    });
    _buffer = StreamController<List<int>>();
    CraftDataTypes.writeVarInt(DataOutputSink(_buffer), raw.length);
    _buffer.sink.add(raw);
    return _buffer.stream;
  }
}
