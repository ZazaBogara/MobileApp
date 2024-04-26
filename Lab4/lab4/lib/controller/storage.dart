import 'dart:io';


abstract class LocalStorage {
  Future<void> saveData(String key, String value);
  Future<String?> getData(String key);
  Future<void> updateData(String key, String value);
  Future<void> deleteData(String key);
}

class SharedPreferencesStorage implements LocalStorage {
  final String filePath = "D:\\Programing\\flutterLabs\\Lab4\\lab4\\Storage\\storage.txt";

  SharedPreferencesStorage();

  @override
  Future<void> saveData(String key, String value) async {
    final File file = File(filePath);
    IOSink sink;
    sink = file.openWrite(mode: FileMode.append);
    sink.writeln('$key=$value');
    try {
      await sink.flush();
    } finally {
      await sink.close();
    }
  }

  @override
  Future<String?> getData(String key) async {
    final File file = File(filePath);
    try {
      if (!await file.exists()) {
        return null;
      }
      final lines = await file.readAsLines();
      if (lines.isEmpty) {
        return null;
      }
      for (var line in lines) {
        if (line.startsWith('$key=')) {
          return line.substring(key.length + 1);
        }
      }
      return null;
    } on FileSystemException {
      return null;
    }
  }

  @override
  Future<void> updateData(String key, String value) async {
    final File file = File(filePath);
    List<String> lines = await file.readAsLines();
    for (int i = 0; i < lines.length; i++) {
      if (lines[i].startsWith('$key=')) {
        lines[i] = '$key=$value';
        break;
      }
    }
    await file.writeAsString(lines.join('\n'));
  }

  @override
  Future<void> deleteData(String key) async {
    final File file = File(filePath);
    List<String> lines = await file.readAsLines();
    lines.removeWhere((line) => line.startsWith('$key='));
    await file.writeAsString(lines.join('\n'));
  }
}