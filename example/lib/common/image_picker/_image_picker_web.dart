import 'dart:html';
import 'dart:async';
import 'dart:typed_data';

Future<Uint8List> pickImage() async {
  final completer = new Completer<Uint8List>();
  final InputElement input = document.createElement('input');
  
  input
    ..type = 'file'
    ..accept = 'image/*';
  input.onChange.listen((e) async {
    final List<File> files = input.files;
    final reader = new FileReader();
    reader.readAsArrayBuffer(files[0]);
    reader.onError.listen((error) => completer.completeError(error));
    await reader.onLoad.first;
    completer.complete(reader.result as Uint8List);
  });
  input.click();
  return completer.future;
}
